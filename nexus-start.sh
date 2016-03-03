#!/bin/bash
set -e

FIRST_RUN=first-run.sh
if [[ -x /$FIRST_RUN ]]; then
    /$FIRST_RUN
fi

chown -R nexus:nexus ${SONATYPE_WORK}

echo "Start up nexus."
exec su -s /bin/bash -c "java \
  -Dnexus-work=${SONATYPE_WORK} -Dnexus-webapp-context-path=${CONTEXT_PATH} \
  -Xms${MIN_HEAP} -Xmx${MAX_HEAP} \
  -cp 'conf/:lib/*' \
  ${JAVA_OPTS} \
  org.sonatype.nexus.bootstrap.Launcher ${LAUNCHER_CONF}" nexus 
