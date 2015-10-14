#include "jeki/publickey.h"
#include "jeki/make_unique.h"

#include <botan/pubkey.h>
#include <botan/x509_key.h>

namespace jeki {

namespace key {

class PublicKey::Impl
{
    public:
        void toPEM(const std::string& filename)
        {
        }

        template <typename T>
        void loadKey(const T& buffer)
        {
            publicKey.reset(Botan::X509::load_key(buffer));
        }

    private:
        std::unique_ptr<Botan::Public_Key> publicKey;
};

PublicKey::PublicKey()
    : impl{std::make_unique<Impl>()}
{}

PublicKey::~PublicKey()
{}

void PublicKey::toPEM(const std::string& filename) const
{}

PublicKey* PublicKey::fromBER(const std::vector<std::uint8_t>& bytes)
{
    auto key = std::make_unique<PublicKey>();
    key->impl->loadKey(bytes);
    return key.release();
}

} // namespace key

} // namespace jeki
