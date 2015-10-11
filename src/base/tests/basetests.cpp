#include "jeki/base.h"
#include "jeki/hello.h"

#include <vector>

#define CATCH_CONFIG_MAIN
#include <catch>

SCENARIO ("Hello") {

    GIVEN ("Hello") {

        std::vector<int> v( 5 );
        REQUIRE(v.size() == 5);
    }
}




