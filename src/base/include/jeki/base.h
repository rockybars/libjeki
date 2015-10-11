//
// LibJeki
// Copyright (C) 2015, Dhi Aurrahman <diorahman@rockybars.com>

#ifndef JEKI_H
#define JEKI_H

#define JEKI_MAJOR_VERSION 0
#define JEKI_MINOR_VERSION 0
#define JEKI_PATCH_VERSION 1

#define JEKI_AUX_STR_EXP(__A) #__A
#define JEKI_AUX_STR(__A) JEKI_AUX_STR_EXP(__A)
#define JEKI_VERSION JEKI_AUX_STR(JEKI_MAJOR_VERSION) "." JEKI_AUX_STR(JEKI_MINOR_VERSION) "." JEKI_AUX_STR(JEKI_PATCH_VERSION)

#endif
