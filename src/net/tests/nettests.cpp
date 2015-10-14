#include "jeki/net/tlsmanager.h"

#define CATCH_CONFIG_MAIN
#include <catch>

#include <iostream>

DESCRIBE ("net tests") {

    IT ("should check hello version size correctly") {
        jeki::net::TLSManager tlsManager;
        std::vector<int> v(5);
        REQUIRE(v.size() == 5);
    }
}
