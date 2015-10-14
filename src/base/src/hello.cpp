#include "jeki/hello.h"
#include <botan/botan.h>

namespace jeki {

namespace hello {

    std::string version() {

        return Botan::version_string();
    }
}

}
