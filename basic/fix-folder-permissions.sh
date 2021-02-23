##!/bin/sh

# exit immediately if a command exits with a non-zero status
set -e

RUNTIME_DATA=./researchspace
BLAZEGRAPH_DATA=./blazegraph
CANTALOUPE_CACHE=./cantaloupe
FCREPO_DATA=./fcrepo

echo "Creating storage folders"

mkdir -p ${RUNTIME_DATA}/data/images/file
mkdir -p ${RUNTIME_DATA}/data/tmp/file

echo "Changing ownership of the ResearchSpace runtime-data folder: ${RUNTIME_DATA}"

# change ownership of the runtime-data folder to uid/guid that is used inside researchspace docker container
chown -R 100:0 ${RUNTIME_DATA}

# make sure that folder has correct write permissions and new files that are created inside the folder inherit ownership
chmod -R g+ws ${RUNTIME_DATA}

echo "Creating blazegraph journal folder: ${BLAZEGRAPH_DATA}"
# create folder for blazegraph journal file
mkdir -p ${BLAZEGRAPH_DATA}
# change ownership of the blazegraph data folder to uid/guid that is used inside blazegraph docker container
chown -R 999:999 ${BLAZEGRAPH_DATA}
# make sure that folder has correct write permissions and new files that are created inside the folder inherit ownership
chmod -R g+ws ${BLAZEGRAPH_DATA}


echo "Creating fcrepo data folder: ${FCREPO_DATA}"
# create folder for blazegraph journal file
mkdir -p ${FCREPO_DATA}
# change ownership of the blazegraph data folder to uid/guid that is used inside blazegraph docker container
chown -R 999:999 ${FCREPO_DATA}
# make sure that folder has correct write permissions and new files that are created inside the folder inherit ownership
chmod -R g+ws ${FCREPO_DATA}


echo "Creating cantaloupe cache folder: ${CANTALOUPE_CACHE}"
mkdir -p ${CANTALOUPE_CACHE}
# change ownership of the cantaloupe cache folder to uid/guid that is used inside cantaloupe docker container
chown -R 101:65534 ${CANTALOUPE_CACHE}
# make sure that folder has correct write permissions and new files that are created inside the folder inherit ownership
chmod -R g+ws ${CANTALOUPE_CACHE}
