//
// LibJeki
// Copyright (C) 2015, Dhi Aurrahman <diorahman@rockybars.com>
//

#ifndef Jeki_PrivateKey_H
#define Jeki_PrivateKey_H

#include "jeki/basekey.h"
#include <memory>

namespace jeki {

namespace key {

    class PublicKey;

    class PrivateKey : public BaseKey
    {
        public:
            PrivateKey();
            ~PrivateKey();

            void toPEM(const std::string& filename, const std::string& passphrase = "") const;
            static PrivateKey* generate(size_t bits);
            PublicKey* publicKey();

        private:
            class Impl;
            std::unique_ptr<Impl> impl;
    };

} // namespace key

} // namespace jeki

#endif // Jeki_PrivateKey_H
