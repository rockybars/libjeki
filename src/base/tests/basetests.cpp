#include "jeki/hello.h"

#define CATCH_CONFIG_MAIN
#include <catch>

#include <iostream>

DESCRIBE ("base tests") {

    IT ("should check hello version size correctly") {

        std::cout << jeki::hello::version() << std::endl;

        std::vector<int> v(5);
        REQUIRE(v.size() == 5);
    }
}
