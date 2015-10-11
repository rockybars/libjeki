#
# Root CMake file for LibJeki
#

cmake_minimum_required(VERSION 2.8)

project(LibJeki)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)
set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} ${CMAKE_SOURCE_DIR}/cmake)

include(LibJekiUtilities REQUIRED)
include(LibJekiModule REQUIRED)
include(LibJekiVersion REQUIRED)

# set options
set_option(BUILD_MODULES "Build LibJeki modules" ON)

set(LibJeki_DIR ${CMAKE_SOURCE_DIR})
set(LibJeki_SOURCE_DIR ${CMAKE_SOURCE_DIR}/src)
set(LibJeki_BUILD_DIR ${CMAKE_BINARY_DIR})
set(LibJeki_INSTALL_DIR ${CMAKE_INSTALL_PREFIX})

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
set(PACKAGE_BUGREPORT "https://github.com/rockybars/LibJeki/issues")
set(PACKAGE_NAME "LibJeki")
set(PACKAGE_STRING "${PACKAGE} ${LibJeki_VERSION}")
set(PACKAGE_TARNAME "${PACKAGE}")
set(PACKAGE_VERSION "${LibJeki_VERSION}")

status("Parsing 'LibJekiConfig.h.cmake'")
configure_file(
    "${CMAKE_SOURCE_DIR}/cmake/LibJekiConfig.h.cmake" 
    "${LibJeki_CONFIG_FILE_INCLUDE_DIR}/scyconfig.h")

