##!/bin/sh

# exit immediately if a command exits with a non-zero status
set -e

RUNTIME_DATA=./researchspace
BLAZEGRAPH_DATA=./blazegraph

echo "Changing ownership of the ResearchSpace runtime-data folder: ${RUNTIME_DATA}"

# change ownership of the runtime-data folder to uid/guid that is used inside researchspace docker container
chown -R 100:0 ${RUNTIME_DATA}

# make sure that folder has correct write permissions and new files that are created inside the folder inherit ownership
chmod -R g+ws ${RUNTIME_DATA}

echo "Creating blazegraph journal folder: ${BLAZEGRAPH_DATA}"

# create folder for blazegraph journal file
mkdir ${BLAZEGRAPH_DATA}

# change ownership of the blazegraph data folder to uid/guid that is used inside blazegraph docker container
chown -R 999:999 ${BLAZEGRAPH_DATA}

# make sure that folder has correct write permissions and new files that are created inside the folder inherit ownership
chmod -R g+ws ${RUNTIME_DATA}

