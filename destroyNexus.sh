#!/bin/bash

NEXUS_NAME=${NEXUS_NAME:-nexus}
NEXUS_VOLUME=${NEXUS_VOLUME:-nexus-volume}

echo "Removing ${NEXUS_NAME}..."
docker stop ${NEXUS_NAME} &> /dev/null
docker rm -v ${NEXUS_NAME} &> /dev/null

echo "Removing ${NEXUS_VOLUME}..."
docker rm -v ${NEXUS_VOLUME} &> /dev/null

