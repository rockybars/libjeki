# ----------------------------------------------------------------------------
# Define the current LibJeki version number
# ----------------------------------------------------------------------------
set(LibJeki_VERSION_FILE "${CMAKE_SOURCE_DIR}/src/base/include/jeki/base.h")
if(NOT EXISTS "${LibJeki_VERSION_FILE}")
    message(FATAL_ERROR "Cannot find base module headers.")
endif()

FILE(STRINGS "${LibJeki_VERSION_FILE}" LibJeki_VERSION_PARTS REGEX "#define JEKI_.+_VERSION[ ]+[0-9]+" )

string(REGEX REPLACE ".+JEKI_MAJOR_VERSION[ ]+([0-9]+).*" "\\1" LibJeki_VERSION_MAJOR "${LibJeki_VERSION_PARTS}")
string(REGEX REPLACE ".+JEKI_MINOR_VERSION[ ]+([0-9]+).*" "\\1" LibJeki_VERSION_MINOR "${LibJeki_VERSION_PARTS}")
string(REGEX REPLACE ".+JEKI_PATCH_VERSION[ ]+([0-9]+).*" "\\1" LibJeki_VERSION_PATCH "${LibJeki_VERSION_PARTS}")

set(LibJeki_VERSION "${LibJeki_VERSION_MAJOR}.${LibJeki_VERSION_MINOR}.${LibJeki_VERSION_PATCH}")
set(LibJeki_SOVERSION "${LibJeki_VERSION_MAJOR}.${LibJeki_VERSION_MINOR}")

if(WIN32)
    # Postfix of DLLs:
    set(LibJeki_DLLVERSION "${LibJeki_VERSION_MAJOR}${LibJeki_VERSION_MINOR}${LibJeki_VERSION_PATCH}")
    set(LibJeki_DEBUG_POSTFIX "d")
else()
    # Postfix of so's:
    set(LibJeki_DLLVERSION "")
    set(LibJeki_DEBUG_POSTFIX "")
endif()


