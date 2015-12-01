#!/bin/bash
set -e
NEXUS_NAME=${1:-nexus}
NEXUS_VOLUME=${2:-nexus-volume}
NEXUS_IMAGE_NAME=${3:-openfrontier/nexus}
LDAP_NAME=${4:-openldap}

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
--link ${LDAP_NAME}:${LDAP_NAME} \
-p 8081:8081 \
--volumes-from ${NEXUS_VOLUME} \
-e CONTEXT_PATH=/nexus \
-d ${NEXUS_IMAGE_NAME}
