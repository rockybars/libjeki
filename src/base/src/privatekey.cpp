#include "jeki/make_unique.h"
#include "jeki/privatekey.h"
#include "jeki/publickey.h"

#include <botan/pubkey.h>
#include <botan/x509_key.h>

namespace jeki {

namespace key {

class PrivateKey::Impl
{
    public:
        void toPEM(const std::string& filename, const std::string& passphrase)
        {
            // pkcs8 serialize encode pem

        }

        PublicKey* publicKey()
        {
            return PublicKey::fromBER(Botan::X509::BER_encode(*this->privateKey));
        }

    private:
        std::unique_ptr<Botan::Private_Key> privateKey;
};

PrivateKey::PrivateKey()
    : impl{std::make_unique<Impl>()}
{}

PrivateKey::~PrivateKey()
{}

void PrivateKey::toPEM(const std::string& filename, const std::string& passphrase) const
{}

PrivateKey* PrivateKey::generate(size_t bits)
{
    auto key = std::make_unique<PrivateKey>();
    return key.release();
}

PublicKey* PrivateKey::publicKey()
{
    return impl->publicKey();
}

} // namespace key

} // namespace jeki
