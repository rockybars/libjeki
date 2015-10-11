#include "jeki/base.h"
#include "jeki/hello.h"

#include <vector>

#define CATCH_CONFIG_MAIN
#include <catch>

DESCRIBE ("std::vector tests") {

    IT ("Should check std::vector size correctly") {

        std::vector<int> v(5);
        REQUIRE(v.size() == 5);
    }
}




