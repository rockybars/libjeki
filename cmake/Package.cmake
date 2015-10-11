#
# CPack template for LibSourcey
#
# (c) Copyrights 2008 Hartmut Seichter, HIT Lab NZ
#

if(MSVC)
    set(CMAKE_INSTALL_DEBUG_LIBRARIES 1)
endif()
#if(ENABLE_OPENMP)
#    set(CMAKE_INSTALL_OPENMP_LIBRARIES 1)
#endif()

# include(InstallRequiredSystemLibraries)

set(CPACK_PACKAGE_NAME "LibJeki")
set(CPACK_PACKAGE_VENDOR "LibJeki project rockybars.com")

set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "LibJeki for ${CMAKE_GENERATOR} is crane in swahili")

#set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_SOURCE_DIR}/README")
#set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/doc/license.txt")

set(CPACK_PACKAGE_VERSION_MAJOR "${LibJeki_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${LibJeki_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${LibJeki_VERSION_PATCH}")

set(CPACK_PACKAGE_INSTALL_DIRECTORY "LibJeki${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}")

set(CPACK_PACKAGE_EXECUTABLES "")

set(CPACK_COMPONENTS_ALL libraries headers)

set(CPACK_COMPONENT_main_DISPLAY_NAME "Binaries and the Documentation")
#set(CPACK_COMPONENT_headers_DISPLAY_NAME "Binaries and the Documentation")
#set(CPACK_COMPONENT_src_DISPLAY_NAME "The source code")
#set(CPACK_COMPONENT_py_DISPLAY_NAME "Python Bindings")

set(CPACK_ALL_INSTALL_TYPES Full)

set(CPACK_COMPONENT_MAIN_INSTALL_TYPES Full)
set(CPACK_COMPONENT_SRC_INSTALL_TYPES Full)
#set(CPACK_COMPONENT_py_INSTALL_TYPES Full)

set(CPACK_SOURCE_IGNORE_FILES
    "/\\\\.svn/"
    "/autom4te.cache/"
    "/build/"
    "/interfaces/"
    "/swig_python/"
    "/octave/"
    "/gtest/"
    "~$"
    "\\\\.aux$"
    "\\\\.bbl$"
    "\\\\.blg$"
    "\\\\.idx$"
    "\\\\.ilg$"
    "\\\\.ind$"
    "\\\\.log$"
    "\\\\.toc$"
    "\\\\.out$"
    "\\\\.pyc$"
    "\\\\.pyo$"
    "\\\\.vcproj$"
    "\\\\.vcxproj$"
    "/1$"
    "${CPACK_SOURCE_IGNORE_FILES}")

if(NOT WIN32)
    set(CPACK_SOURCE_IGNORE_FILES
    "/lib/"
    "\\\\.dll$"
    "${CPACK_SOURCE_IGNORE_FILES}")
endif()

set(CPACK_SOURCE_PACKAGE_FILE_NAME
    "${CMAKE_PROJECT_NAME}-${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}")

if(WIN32)
    set(CPACK_GENERATOR "NSIS")
    set(CPACK_SOURCE_GENERATOR "ZIP")
    set(CPACK_NSIS_PACKAGE_NAME "LibSourcey ${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}rc")
    #set(CPACK_NSIS_MUI_ICON "${CMAKE_SOURCE_DIR}\\\\doc\\\\libsourcey.ico")
    #set(CPACK_NSIS_MUI_UNIICON "${CMAKE_SOURCE_DIR}\\\\doc\\\\libsourcey.ico")
    #set(CPACK_PACKAGE_ICON "utils/libsourcey.ico")

    set(CPACK_NSIS_INSTALLED_ICON_NAME "${CMAKE_SOURCE_DIR}\\\\doc\\\\libsourcey.ico")
    set(CPACK_NSIS_HELP_LINK "http:\\\\\\\\sourcey.com")
    set(CPACK_NSIS_URL_INFO_ABOUT "http:\\\\\\\\sourcey.com")
    set(CPACK_NSIS_CONTACT "")
    set(CPACK_NSIS_DISPLAY_NAME "Open Source Computer Vision Library")

    set(CPACK_NSIS_MENU_LINKS
        "http://sourcey.com" "Start Page"
        #"doc\\\\libsourcey2refman.pdf" "The LibSourcey Reference Manual"
        #"doc\\\\libsourcey_tutorials.pdf" "The LibSourcey Tutorials for Beginners"
        "CMakeLists.txt" "The Build Script (open with CMake)"
        #"samples\\\\c" "C Samples"
        #"samples\\\\cpp" "C++ Samples"
        #"samples\\\\python" "Python Samples"
        )

    # Add "<install_path>/bin" to the system PATH
    set(CPACK_NSIS_MODIFY_PATH ON)
else()
    set(CPACK_GENERATOR "TBZ2")
    set(CPACK_SOURCE_GENERATOR "TBZ2")

    if(APPLE)
    set(CPACK_GENERATOR "PackageMaker;TBZ2")
    endif()
endif()

include(CPack)
