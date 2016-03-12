#!/bin/bash

NEXUS_PLUGIN_PATH=${SONATYPE_WORK}/plugin-repository
P2_PLUGIN_PATH=/opt/sonatype/nexus
P2_BRIDGE_PLUGIN=nexus-p2-bridge-plugin-${NEXUS_VERSION}
P2_REPO_PLUGIN=nexus-p2-repository-plugin-${NEXUS_VERSION}

LDAP_CONFIG_NAME=ldap.xml
LDAP_ACCOUNTBASE="$( cut -d ',' -f 1 <<< "$LDAP_ACCOUNTBASE" )"

echo "Doing first run configuration..."

echo "Setup p2 plugins."
rm -f ${NEXUS_PLUGIN_PATH}/${P2_BRIDGE_PLUGIN}
rm -f ${NEXUS_PLUGIN_PATH}/${P2_REPO_PLUGIN}
mkdir -p ${NEXUS_PLUGIN_PATH}
ln -s ${P2_PLUGIN_PATH}/${P2_BRIDGE_PLUGIN} ${NEXUS_PLUGIN_PATH}/${P2_BRIDGE_PLUGIN}
ln -s ${P2_PLUGIN_PATH}/${P2_REPO_PLUGIN}   ${NEXUS_PLUGIN_PATH}/${P2_REPO_PLUGIN}


# Getting LDAP Base Dn from FQDN
SLAPD_TMP_DN=".${OPENLDAP_ENV_SLAPD_DOMAIN}"
while [ -n "${SLAPD_TMP_DN}" ]; do
    SLAPD_DN=",dc=${SLAPD_TMP_DN##*.}${SLAPD_DN}"
    SLAPD_TMP_DN="${SLAPD_TMP_DN%.*}"
done
SLAPD_DN="${SLAPD_DN#,}"

# Create configs from template
CONF_DIR=$SONATYPE_WORK/conf
echo "Creating template files..."
sed "s/{SLAPD_DN}/${SLAPD_DN}/g" /${LDAP_CONFIG_NAME}.template > ${CONF_DIR}/${LDAP_CONFIG_NAME}
sed -i "s/{LDAP_HOST}/${LDAP_SERVER}/g" ${CONF_DIR}/${LDAP_CONFIG_NAME}
sed -i "s/{LDAP_ACCOUNTBASE}/${LDAP_ACCOUNTBASE}/g" ${CONF_DIR}/${LDAP_CONFIG_NAME}

# Remove the first-run file after running once
rm /first-run.sh
