macro(define_jeki_module name)

    project(${name})

    file(GLOB_RECURSE lib_srcs "src/*.cpp")
    file(GLOB_RECURSE lib_hdrs "include/*.h")

    source_group("Src" FILES ${lib_srcs})
    source_group("Include" FILES ${lib_hdrs})

    add_library(${name} ${lib_srcs} ${lib_hdrs})

    # Set HAVE_JEKI_XXX at parent scope for inclusion
    # into our Config.h
    set(HAVE_JEKI_${name} ON PARENT_SCOPE)

endmacro()
