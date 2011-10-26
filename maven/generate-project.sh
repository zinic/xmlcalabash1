#!/bin/bash

# Because I don't want to get into a situation where I have to manually
# copy and merge project files I wrote this script to create maven projects
# out of Calabash's source.

# Configuration Variables
[ -z "${POM_SOURCES}" ] && POM_SOURCES="./maven-sources"

[ -z "${CALABASH_ROOT}" ] && CALABASH_ROOT=".."
[ -z "${TARGET_DIR}" ] && TARGET_DIR="./calabash-maven"

[ -z "${EXCLUSIONS_FILE}" ] && EXCLUSIONS_FILE="./exclusions"

# Constants
CORE="/core"

MVN_MAIN_JAVA="/src/main/java"
MVN_MAIN_RESOURCES="/src/main/resources"

MVN_TEST_JAVA="/src/test/java"
MVN_TEST_RESOURCES="/src/test/resources"

function createDirectories {
   mkdir -p "${TARGET_DIR}${CORE}${MVN_MAIN_JAVA}"
   mkdir -p "${TARGET_DIR}${CORE}${MVN_MAIN_RESOURCES}"
   mkdir -p "${TARGET_DIR}${CORE}${MVN_TEST_JAVA}"
   mkdir -p "${TARGET_DIR}${CORE}${MVN_TEST_RESOURCES}"
}

function copyMavenModels {
   cp "${POM_SOURCES}/parent.pom.xml" "${TARGET_DIR}/pom.xml"
   cp "${POM_SOURCES}/core.pom.xml" "${TARGET_DIR}${CORE}/pom.xml"
}

function copyCalabashProject {
   cp -rT "${CALABASH_ROOT}/src/" "${TARGET_DIR}${CORE}${MVN_MAIN_JAVA}"
   cp -rT "${CALABASH_ROOT}/resources/" "${TARGET_DIR}${CORE}${MVN_MAIN_RESOURCES}"
   
   cp -r "${CALABASH_ROOT}/test/com" "${TARGET_DIR}${CORE}${MVN_TEST_JAVA}"
}

function processExclusions {
   if [ -e "${EXCLUSIONS_FILE}" ]; then
      while read exclusion; do
         rm -v "${TARGET_DIR}${CORE}${MVN_MAIN_JAVA}${exclusion}" > /dev/null 2>&1
      done < "${EXCLUSIONS_FILE}"
   fi
}

function cleanAll {
   rm -rf "${TARGET_DIR}"
}

function printUsage {
   echo "Usage: generate-project.sh [clean]"
   exit 1;
}

if [ $# -eq 1 ]; then
   if [ "$1" == "clean" ]; then
      cleanAll
   else
      printUsage
   fi
else
   createDirectories
   copyMavenModels
   copyCalabashProject
   processExclusions
fi
