include_directories("${CMAKE_CURRENT_SOURCE_DIR}")

set(catch_SOURCE_FILES catch.hpp)
set(catch_parser_HEADER_FILES catch.hpp)

define_jeki_dependency(catch)
