FROM openfrontier/nexus

MAINTAINER shiv <shiv@demo.com>


ENV SONATYPE_WORK=${SONATYPE_WORK:-/sonatype-work}
ENV LDAP_SERVER openldap
ENV LDAP_ACCOUNTBASE ou=accounts,dc=demo,dc=com

USER root

#docker cp ${BASEDIR}/${LDAP_CONFIG_NAME} ${NEXUS_NAME}:${NEXUS_CONFIG_DIR}
COPY ldap.xml.template /

RUN mkdir -p $SONATYPE_WORK/conf

#docker cp ${BASEDIR}/${SECURITY_CONFIG_NAME} ${NEXUS_NAME}:${NEXUS_CONFIG_DIR}
COPY security.xml security-configuration.xml $SONATYPE_WORK/conf/

#docker cp ${BASEDIR}/${SECURITY_CONFIG_EXTRA_NAME} ${NEXUS_NAME}:${NEXUS_CONFIG_DIR}
#COPY  $SONATYPE_WORK/conf/

# chown will not work after a VOLUME declaration (which is in original Nexus Dockerfile)
#RUN chown -R nexus:nexus $SONATYPE_WORK/conf/security.xml

#USER root 

COPY nexus-start.sh /nexus-start.sh
COPY first-run.sh /first-run.sh


#RUN chown -R nexus:nexus $SONATYPE_WORK
RUN chown nexus:nexus /nexus-start.sh /first-run.sh 
#RUN chmod +x /nexus-start.sh /first-run.sh

#USER nexus

CMD ["/nexus-start.sh"]
