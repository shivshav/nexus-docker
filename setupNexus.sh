#!/bin/bash
BASEDIR=$(readlink -f $(dirname $0))
set -e

LDAP_SERVER=${1:-openldap}
SLAPD_DOMAIN=${2:-demo.com}
LDAP_ACCOUNTBASE=${3:-ou=accounts,dc=demo,dc=com}
NEXUS_NAME=${4:-nexus}

NEXUS_CONFIG_DIR=/sonatype-work/conf

LDAP_CONFIG_NAME=ldap.xml
SECURITY_CONFIG_NAME=security.xml
SECURITY_CONFIG_EXTRA_NAME=security-configuration.xml
##Convert FQDN to LDAP base DN
#SLAPD_TMP_DN=".${SLAPD_DOMAIN}"
#while [ -n "${SLAPD_TMP_DN}" ]; do
#SLAPD_DN=",dc=${SLAPD_TMP_DN##*.}${SLAPD_DN}"
#SLAPD_TMP_DN="${SLAPD_TMP_DN%.*}"
#done
#SLAPD_DN="${SLAPD_DN#,}"
#
#
#LDAP_ACCOUNTBASE="$( cut -d ',' -f 1 <<< "$LDAP_ACCOUNTBASE" )"
#
## Create configs from template
#echo "Creating template files..."
#sed -e "s/{SLAPD_DN}/${SLAPD_DN}/g" ${BASEDIR}/${LDAP_CONFIG_NAME}.template > ${BASEDIR}/${LDAP_CONFIG_NAME}
#sed -i "s/{LDAP_HOST}/${LDAP_SERVER}/g" ${BASEDIR}/${LDAP_CONFIG_NAME}
#sed -i "s/{LDAP_ACCOUNTBASE}/${LDAP_ACCOUNTBASE}/g" ${BASEDIR}/${LDAP_CONFIG_NAME}
#
## Copy over relevant configs
#echo "Copying over Nexus configurations..."
#docker cp ${BASEDIR}/${LDAP_CONFIG_NAME} ${NEXUS_NAME}:${NEXUS_CONFIG_DIR}
#docker cp ${BASEDIR}/${SECURITY_CONFIG_NAME} ${NEXUS_NAME}:${NEXUS_CONFIG_DIR}
#docker cp ${BASEDIR}/${SECURITY_CONFIG_EXTRA_NAME} ${NEXUS_NAME}:${NEXUS_CONFIG_DIR}
#
#docker exec -iu root nexus chown -R nexus:nexus ${NEXUS_CONFIG_DIR}/
#
#echo "Restarting ${NEXUS_NAME} container..."
#docker restart ${NEXUS_NAME}
echo "Finished setting up Nexus!"
