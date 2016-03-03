FROM openfrontier/nexus

MAINTAINER shiv <shiv@demo.com>

ENV SONATYPE_WORK=${SONATYPE_WORK:-/sonatype-work}
ENV LDAP_SERVER openldap
ENV LDAP_ACCOUNTBASE ou=accounts,dc=demo,dc=com

RUN mkdir -p $SONATYPE_WORK
#docker cp ${BASEDIR}/${LDAP_CONFIG_NAME} ${NEXUS_NAME}:${NEXUS_CONFIG_DIR}
COPY ldap.xml.template /

#docker cp ${BASEDIR}/${SECURITY_CONFIG_NAME} ${NEXUS_NAME}:${NEXUS_CONFIG_DIR}
COPY security.xml $SONATYPE_WORK/conf/

#docker cp ${BASEDIR}/${SECURITY_CONFIG_EXTRA_NAME} ${NEXUS_NAME}:${NEXUS_CONFIG_DIR}
COPY security-configuration.xml $SONATYPE_WORK/conf/

#RUN chown -R nexus:nexus $SONATYPE_WORK/conf

USER root 

COPY nexus-start.sh /nexus-start.sh
COPY first-run.sh /first-run.sh

RUN chmod +x /nexus-start.sh /first-run.sh

CMD ["/nexus-start.sh"]
