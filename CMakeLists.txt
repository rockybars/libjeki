#
# Root CMake file for LibJeki
#

cmake_minimum_required(VERSION 2.8)

# This _must_ go before project(LibJeki) in order to work
if(WIN32)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install" CACHE PATH "Installation Directory")
else()
    set(CMAKE_INSTALL_PREFIX "/usr/local" CACHE PATH "Installation Directory")
endif()

set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "Configs" FORCE)
if(DEFINED CMAKE_BUILD_TYPE AND CMAKE_VERSION VERSION_GREATER "2.8")
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS ${CMAKE_CONFIGURATION_TYPES})
endif()

project(LibJeki)

add_definitions(-DUNICODE -D_UNICODE)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)
set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} ${CMAKE_SOURCE_DIR}/cmake)

include(LibJekiUtilities REQUIRED)
include(LibJekiIncludes REQUIRED)
include(LibJekiModule REQUIRED)
include(LibJekiVersion REQUIRED)

# set options
set_option(BUILD_MODULES "Build LibJeki modules" ON)
set_option(BUILD_MODULE_TESTS "Build module test applications" ON)

# internal options
set(LibJeki_INCLUDE_DIRS           "") # CACHE INTERNAL "Global include dirs" FORCE)
set(LibJeki_LIBRARY_DIRS           "") # CACHE INTERNAL "Global include library dirs" FORCE)
set(LibJeki_INCLUDE_LIBRARIES      "") # CACHE INTERNAL "Global include libraries" FORCE)

set(LibJeki_BUILD_DEPENDENCIES     "" CACHE INTERNAL "Dependencies to build" FORCE)
set(LibJeki_BUILD_MODULES          "" CACHE INTERNAL "Modules to build" FORCE)
set(LibJeki_BUILD_SAMPLES          "" CACHE INTERNAL "Samples to build" FORCE)
set(LibJeki_BUILD_TESTS            "" CACHE INTERNAL "Tests to build" FORCE)
set(LibJeki_BUILD_APPLICATIONS     "" CACHE INTERNAL "Applications to build" FORCE)

set(LibJeki_DIR ${CMAKE_SOURCE_DIR})
set(LibJeki_SOURCE_DIR ${CMAKE_SOURCE_DIR}/src)
set(LibJeki_BUILD_DIR ${CMAKE_BINARY_DIR})
set(LibJeki_INSTALL_DIR ${CMAKE_INSTALL_PREFIX})

if (BUILD_MODULE_TESTS)
    enable_testing()
endif()

if (BUILD_MODULES)
    subdirlist(subdirs "${CMAKE_SOURCE_DIR}/src")
    foreach(name ${subdirs})
        set(HAVE_LibJeki_${name} 0)
        set(dir "${CMAKE_SOURCE_DIR}/src/${name}")
        if (EXISTS "${dir}/CMakeLists.txt")
            add_subdirectory(${dir})
        endif()
    endforeach()
endif()

add_definitions(-DHAVE_CONFIG_H)

#
# Set the platform dependant LibJekiConfig.h
set(LibJeki_CONFIG_FILE_INCLUDE_DIR "${CMAKE_BINARY_DIR}/" CACHE PATH "Where to create the platform-dependant LibJekiConfig.h")
include_directories("${LibJeki_CONFIG_FILE_INCLUDE_DIR}")

# Variables for LibJekiConfig.h.cmake
set(PACKAGE "LibJeki")
set(PACKAGE_BUGREPORT "https://github.com/rockybars/libjeki/issues")
set(PACKAGE_NAME "LibJeki")
set(PACKAGE_STRING "${PACKAGE} ${LibJeki_VERSION}")
set(PACKAGE_TARNAME "${PACKAGE}")
set(PACKAGE_VERSION "${LibJeki_VERSION}")

status("Parsing 'LibJekiConfig.h.cmake'")
configure_file(
    "${CMAKE_SOURCE_DIR}/cmake/LibJekiConfig.h.cmake"
    "${LibJeki_CONFIG_FILE_INCLUDE_DIR}/jekiconfig.h")

