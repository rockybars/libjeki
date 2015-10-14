//
// LibJeki
// Copyright (C) 2015, Dhi Aurrahman <diorahman@rockybars.com>
//

#ifndef Jeki_PublicKey_H
#define Jeki_PublicKey_H

#include "jeki/basekey.h"

#include <memory>
#include <vector>

namespace jeki {

namespace key {

    class PublicKey : public BaseKey
    {
        public:
            PublicKey();
            ~PublicKey();

            void toPEM(const std::string& filename) const;
            static PublicKey* fromBER(const std::vector<std::uint8_t>& bytes);

        private:
            class Impl;
            std::unique_ptr<Impl> impl;
    };

} // namespace key

} // namespace jeki

#endif // Jeki_PublicKey_H
