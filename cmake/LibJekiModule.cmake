macro(define_jeki_module name)

    project(${name})

    message(STATUS "Defining module '${name}'")

    file(GLOB_RECURSE lib_srcs "src/*.cpp")
    file(GLOB_RECURSE lib_hdrs "include/*.h")

    source_group("Src" FILES ${lib_srcs})
    source_group("Include" FILES ${lib_hdrs})

    add_library(${name} ${lib_srcs} ${lib_hdrs})

    # Set HAVE_JEKI_XXX at parent scope for inclusion
    # into our Config.h
    set(HAVE_JEKI_${name} ON PARENT_SCOPE)

    # Include dependent modules
    foreach(module ${ARGV})
        include_jeki_modules(${module})
        add_dependencies(${name} ${module})
    endforeach()

    if(NOT ANDROID)
        # Android SDK build scripts can include only .so files into final .apk
        # As result we should not set version properties for Android
        set_target_properties(${name} PROPERTIES
            VERSION ${LibJeki_VERSION}
            SOVERSION ${LibJeki_SOVERSION})
    endif()

    set_jeki_libname(${name} lib_name)

    set_target_properties(${name} PROPERTIES
        OUTPUT_NAME ${lib_name}
        DEBUG_POSTFIX "${LibJeki_DEBUG_POSTFIX}"
        #ARCHIVE_OUTPUT_DIRECTORY ${LIBRARY_OUTPUT_PATH}
        #RUNTIME_OUTPUT_DIRECTORY ${EXECUTABLE_OUTPUT_PATH}
        INSTALL_NAME_DIR lib
        LINKER_LANGUAGE CXX)

    # Add install routine, unless lib is header only
    if (lib_srcs)
        install(TARGETS ${name}
            RUNTIME DESTINATION bin COMPONENT main
            LIBRARY DESTINATION lib COMPONENT main
            ARCHIVE DESTINATION lib COMPONENT main)
    endif()

    # FIXME: Check if we can remove following lines
    if (lib_hdrs)
        install(DIRECTORY include/ DESTINATION include COMPONENT main)
    endif()

    # Build tests
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/tests)
        ask_build_jeki_test(${name})
        if(BUILD_MODULE_TESTS AND BUILD_TEST_${name})
            add_subdirectory(tests)
        endif()
    endif()

endmacro()

#
### Macro: define_libjeki_test
#
# Defines a generic LibJeki test application.
#
macro(define_libjeki_test name)

    project(${name})

    # Add source files
    file(GLOB lib_hdrs "*.h*")
    # file(GLOB lib_srcs "*.cpp")
    set(lib_srcs "${name}.cpp")

    source_group("Src" FILES ${lib_srcs})
    source_group("Include" FILES ${lib_hdrs})

    add_executable(${name} ${lib_srcs} ${lib_hdrs})

    # Include dependent modules
    foreach(module ${ARGV})
        if (NOT ${module} MATCHES ${name})
            include_jeki_modules(${module})
            add_dependencies(${name} ${module})
            # include external libs
            set(LibJeki_INCLUDE_LIBRARIES "${LibJeki_INCLUDE_LIBRARIES} ${module}")
            string(STRIP "${LibJeki_INCLUDE_LIBRARIES}" LibJeki_INCLUDE_LIBRARIES)
        endif()
    endforeach()

    # Include external dependencies
    target_link_libraries(${name} ${LibJeki_INCLUDE_LIBRARIES})
    # add_dependencies(${name} ${LibJeki_INCLUDE_LIBRARIES})

    #message(STATUS "Defining module test ${name}:")
    #message(STATUS "    Libraries: ${LibJeki_INCLUDE_LIBRARIES}")
    #message(STATUS "    Library Dirs: ${LibJeki_LIBRARY_DIRS}")
    #message(STATUS "    Include Dirs: ${LibJeki_INCLUDE_DIRS}")

    # Include library and header directories
    include_directories("${CMAKE_CURRENT_SOURCE_DIR}/include")
    include_directories(${LibJeki_INCLUDE_DIRS})
    link_directories(${LibJeki_LIBRARY_DIRS})

    if(ENABLE_SOLUTION_FOLDERS)
        set_target_properties(${name} PROPERTIES FOLDER "tests")
    endif()
    set_target_properties(${name} PROPERTIES DEBUG_POSTFIX "d")

    add_test(NAME ${name} WORKING_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}" COMMAND ${name})

    message(STATUS "Enable testing ${name}")

    install(TARGETS ${name} RUNTIME DESTINATION "tests/${name}" COMPONENT main)
endmacro()
