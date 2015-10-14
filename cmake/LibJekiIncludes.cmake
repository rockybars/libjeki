#
### Macro: jeki_find_library
#
# Finds libraries with finer control over search paths
# for compilers with multiple configuration types.
#
macro(jeki_find_library prefix)

  include(CMakeParseArguments REQUIRED)
  # cmake_parse_arguments(prefix options singleValueArgs multiValueArgs ${ARGN})
  cmake_parse_arguments(${prefix}
    ""
    ""
    "NAMES;DEBUG_NAMES;RELEASE_NAMES;DEBUG_PATHS;RELEASE_PATHS;PATHS"
    ${ARGN}
    )

  if(WIN32 AND MSVC)

    if(NOT ${prefix}_DEBUG_PATHS)
      list(APPEND ${prefix}_DEBUG_PATHS ${${prefix}_PATHS})
    endif()

    # Reloading to ensure build always passes and picks up changes
    # This is more expensive but proves useful for fragmented libraries like WebRTC
    set(${prefix}_DEBUG_LIBRARY ${prefix}_DEBUG_LIBRARY-NOTFOUND)
    find_library(${prefix}_DEBUG_LIBRARY
      NAMES
        ${${prefix}_DEBUG_NAMES}
        ${${prefix}_NAMES}
      PATHS
        ${${prefix}_DEBUG_PATHS}
        # ${${prefix}_PATHS}
      )

    if(NOT ${prefix}_RELEASE_PATHS)
      list(APPEND ${prefix}_RELEASE_PATHS ${${prefix}_PATHS})
    endif()

    set(${prefix}_RELEASE_LIBRARY ${prefix}_RELEASE_LIBRARY-NOTFOUND)
    find_library(${prefix}_RELEASE_LIBRARY
      NAMES
        ${${prefix}_RELEASE_NAMES}
        ${${prefix}_NAMES}
      PATHS
        ${${prefix}_RELEASE_PATHS}
        # ${${prefix}_PATHS}
      )

    if(${prefix}_DEBUG_LIBRARY OR ${prefix}_RELEASE_LIBRARY)
      if(CMAKE_CONFIGURATION_TYPES OR CMAKE_BUILD_TYPE)
        #if (${prefix}_RELEASE_LIBRARY)
          list(APPEND ${prefix}_LIBRARY "optimized" ${${prefix}_RELEASE_LIBRARY})
        #endif()
        #if (${prefix}_DEBUG_LIBRARY)
          list(APPEND ${prefix}_LIBRARY "debug" ${${prefix}_DEBUG_LIBRARY})
        #endif()
      else()
        if (${prefix}_RELEASE_LIBRARY)
          list(APPEND ${prefix}_LIBRARY ${${prefix}_RELEASE_LIBRARY})
        elseif (${prefix}_DEBUG_LIBRARY)
          list(APPEND ${prefix}_LIBRARY ${${prefix}_DEBUG_LIBRARY})
        endif()
      endif()
      #mark_as_advanced(${prefix}_DEBUG_LIBRARY ${prefix}_RELEASE_LIBRARY)
    endif()

  else()

    find_library(${prefix}_LIBRARY
      NAMES
        # ${${prefix}_RELEASE_NAMES}
        # ${${prefix}_DEBUG_NAMES}
        ${${prefix}_NAMES}
      PATHS
        # ${${prefix}_RELEASE_PATHS}
        # ${${prefix}_DEBUG_PATHS}
        ${${prefix}_PATHS}
      )

  endif()

  #message("*** Sourcey find library for ${prefix}")
  #message("Debug Library: ${${prefix}_DEBUG_LIBRARY}")
  #message("Release Library: ${${prefix}_RELEASE_LIBRARY}")
  #message("Library: ${${prefix}_LIBRARY}")
  #message("Debug Paths: ${${prefix}_RELEASE_PATHS}")
  #message("Release Paths: ${${prefix}_DEBUG_PATHS}")
  #message("Paths: ${${prefix}_PATHS}")
  #message("Debug Names: ${${prefix}_RELEASE_NAMES}")
  #message("Release Names: ${${prefix}_DEBUG_NAMES}")
  #message("Names: ${${prefix}_NAMES}")

endmacro()
#
### Macro: include_jeki_modules
#
# Includes dependent LibJeki module(s) into a project.
#
macro(include_jeki_modules)
    foreach(name ${ARGN})
        message(STATUS "Including module '${name}'")

        # Include the module headers.
        # These may be located in the "src/" root directory,
        # or in a sub directory.
        set(HAVE_JEKI_${name} 0)
        if(IS_DIRECTORY "${LibJeki_SOURCE_DIR}/${name}/include")
            include_directories("${LibJeki_SOURCE_DIR}/${name}/include")
            set(HAVE_JEKI_${name} 1)
        else()
            subdirlist(subdirs "${LibJeki_SOURCE_DIR}")
            foreach(dir ${subdirs})
                set(dir "${LibJeki_SOURCE_DIR}/${dir}/${name}/include")
                if(IS_DIRECTORY ${dir})
                    include_directories(${dir})
                    set(HAVE_JEKI_${name} 1)
                endif()
            endforeach()
        endif()

        if (NOT HAVE_JEKI_${name})
            message(ERROR "Unable to include dependent LibJeki module ${name}. The build may fail.")
        endif()

        set_jeki_libname(${name} lib_name)
        #set(lib_name "Jeki${name}${LibJeki_DLLVERSION}")

        # FIXME: Create a Debug and a Release list for MSVC

    endforeach()
endmacro()

