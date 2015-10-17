#!/bin/bash
set -e
NEXUS_NAME=${NEXUS_NAME:-nexus}
NEXUS_VOLUME=${NEXUS_VOLUME:-nexus-volume}
NEXUS_IMAGE_NAME=${NEXUS_IMAGE_NAME:-openfrontier/nexus}
SONATYPE_WORK=/sonatype-work

#Create nexus volume.
if [ -z "$(docker ps -a | grep ${NEXUS_VOLUME})" ]; then
    docker run \
    --name ${NEXUS_VOLUME} \
    ${NEXUS_IMAGE_NAME} \
    mkdir ${SONATYPE_WORK}/plugin-repository
    echo "Create nexus volume."
fi

#Start nexus
docker run \
--name ${NEXUS_NAME} \
-p 8081:8081 \
--volumes-from ${NEXUS_VOLUME} \
-e CONTEXT_PATH=/nexus \
-d ${NEXUS_IMAGE_NAME}
