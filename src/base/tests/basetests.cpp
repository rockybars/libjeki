#include "jeki/hello.h"
#include "jeki/make_unique.h"
#include "jeki/privatekey.h"
#include "jeki/publickey.h"

#define CATCH_CONFIG_MAIN
#include <catch>

#include <iostream>

using namespace jeki;

DESCRIBE ("base tests") {

    IT ("should check hello version size correctly") {

        std::cout << jeki::hello::version() << std::endl;

        auto key = std::make_unique<key::PrivateKey>();
        key->toPEM("hihi", "hihi");

        std::vector<int> v(5);
        REQUIRE(v.size() == 5);
    }
}
