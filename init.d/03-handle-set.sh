#!/bin/bash

# Setup Handle.net parameters 
# https://guides.dataverse.org/en/latest/installation/config.html#id76
if [ "${handle_authority}" ]; then
    curl -X PUT -d hdl http://localhost:8080/api/admin/settings/:Protocol
    curl -X PUT -d ${handle_authority} http://localhost:8080/api/admin/settings/:Authority
    curl -X DELETE http://localhost:8080/api/admin/settings/:DoiProvider

    asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddataverse.handlenet.admcredfile\=${handle_admcredfile}"
    
    if [ "${handle_authhandle}" ]; then
        curl -X PUT -d "${handle_authhandle}" http://localhost:8080/api/admin/settings/:HandleAuthHandle
    fi
    if [ "${handle_shoulder}" ]; then
        curl -X PUT -d "${handle_shoulder}/" http://localhost:8080/api/admin/settings/:Shoulder
    fi
    if [ "${handle_admprivphrase}" ]; then
        asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddataverse.handlenet.admprivphrase\=${handle_admprivphrase}"
    fi
    if [ "${handle_index}" ]; then
        asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddataverse.handlenet.index\=${handle_index}"
    fi
fi