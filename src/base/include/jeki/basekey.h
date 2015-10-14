//
// LibJeki
// Copyright (C) 2015, Dhi Aurrahman <diorahman@rockybars.com>

#ifndef JEKI_BaseKey_H
#define JEKI_BaseKey_H

#include <string>

namespace jeki {

namespace key {

    class BaseKey
    {
        public:
            virtual void toPEM(const std::string& filename) const {}
    };
}

}

#endif
