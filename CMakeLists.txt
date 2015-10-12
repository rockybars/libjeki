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
include(LibJekiDependency REQUIRED)
include(LibJekiModule REQUIRED)
include(LibJekiVersion REQUIRED)
include(Package REQUIRED)

# Compiler options
include(LibJekiCompilerOptions REQUIRED)

# Set options
set_option(BUILD_MODULES "Build LibJeki modules" ON)
set_option(BUILD_MODULE_TESTS "Build module test applications" ON)

# MSVC CRT linkage
set_option(BUILD_WITH_STATIC_CRT "Enables staticaly linked CRT for staticaly linked libraries" ON)


# Internal options
set(LibJeki_INCLUDE_DIRS "") # CACHE INTERNAL "Global include dirs" FORCE)
set(LibJeki_LIBRARY_DIRS "") # CACHE INTERNAL "Global include library dirs" FORCE)
set(LibJeki_INCLUDE_LIBRARIES "") # CACHE INTERNAL "Global include libraries" FORCE)

set(LibJeki_BUILD_DEPENDENCIES "" CACHE INTERNAL "Dependencies to build" FORCE)
set(LibJeki_BUILD_MODULES "" CACHE INTERNAL "Modules to build" FORCE)
set(LibJeki_BUILD_SAMPLES "" CACHE INTERNAL "Samples to build" FORCE)
set(LibJeki_BUILD_TESTS "" CACHE INTERNAL "Tests to build" FORCE)
set(LibJeki_BUILD_APPLICATIONS "" CACHE INTERNAL "Applications to build" FORCE)

set(LibJeki_DIR ${CMAKE_SOURCE_DIR})
set(LibJeki_SOURCE_DIR ${CMAKE_SOURCE_DIR}/src)
set(LibJeki_BUILD_DIR ${CMAKE_BINARY_DIR})
set(LibJeki_INSTALL_DIR ${CMAKE_INSTALL_PREFIX})

set(LibJeki_DEPENDENCIES_SOURCE_DIR "${LibJeki_DIR}/deps")
set(LibJeki_DEPENDENCIES_BUILD_DIR "${LibJeki_BUID_DIR}/deps")
set(LibJeki_DEPENDENCIES_INSTALL_DIR "${LibJeki_INSTALL_DIR}/deps")

if (BUILD_MODULE_TESTS)
    enable_testing()
    # catch framework
    list(APPEND LibJeki_INCLUDE_DIRS ${LibJeki_DEPENDENCIES_SOURCE_DIR}/catch)
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

set_option(WITH_LIBUV "Include libuv support" OFF)

list(APPEND LibJeki_INCLUDE_DIRS ${LibSourcey_DEPENDENCIES_BUILD_DIR})

if(WITH_LIBUV)
    #include_dependency(LibUV REQUIRED)
    add_subdirectory(deps/libuv)
    set(HAVE_LIBUV 1)
endif()

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

#if(UNIX)
#    CONFIGURE_FILE(
#        "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
#        "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
#        IMMEDIATE @ONLY)

#    ADD_CUSTOM_TARGET(uninstall
#        "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake")
#endif()

if(MSVC)
    include(LibJekiCRTLinkage REQUIRED)
endif()

# Warn in the case of in-source build
if("${CMAKE_CURRENT_SOURCE_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")
    message(WARNING "The source directory is the same as binary directory. \"make clean\" may damage the source tree")
endif()
