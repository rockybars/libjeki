#
### Macro: include_sourcey_modules
#
# Includes dependent LibSourcey module(s) into a project.
#
macro(include_jeki_modules)
    foreach(name ${ARGN})
        # message(STATUS "Including module: ${name}")

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

