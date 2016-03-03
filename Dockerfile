FROM openfrontier/nexus

MAINTAINER shiv <shiv@demo.com>

ENV SONATYPE_WORK=${SONATYPE_WORK:-/sonatype-work}
ENV LDAP_SERVER openldap
ENV LDAP_ACCOUNTBASE ou=accounts,dc=demo,dc=com

USER root

# Copy over the parameterized ldap config file template
COPY ldap.xml.template /

# Create the config directory and add relevant files
RUN mkdir -p $SONATYPE_WORK/conf
COPY security.xml security-configuration.xml $SONATYPE_WORK/conf/

# Copy over start script and first time config script
COPY nexus-start.sh first-run.sh /
RUN chown nexus:nexus /nexus-start.sh /first-run.sh 

CMD ["/nexus-start.sh"]
