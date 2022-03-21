#!/bin/bash

# Setup DOI parameters 
# https://guides.dataverse.org/en/latest/installation/config.html#doi-baseurlstring
if [ "${doi_authority}" ]; then
    if [ "${doi_protocol}" = "hdl" ]; then
      curl -X DELETE http://localhost:8080/api/admin/settings/:DoiProvider
      asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddataverse.handlenet.admcredfile\=${doi_handle_admcredfile}"
      asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddataverse.handlenet.index\=${doi_handle_index}"
      asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddataverse.fqdn\=${fqdn}"
      asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddataverse.siteUrl\=${siteurl}"
      curl -X PUT -d ${doi_protocol} http://localhost:8080/api/admin/settings/:Protocol
      curl -X PUT -d ${doi_authority} http://localhost:8080/api/admin/settings/:Authority
      curl -X PUT -d ${doi_handle_handleauthhandle} http://localhost:8080/api/admin/settings/:HandleAuthHandle
      if [ "${doi_shoulder}" ]; then
                curl -X PUT -d "${doi_shoulder}/" http://localhost:8080/api/admin/settings/:Shoulder
      fi
    else
      curl -X PUT -d ${doi_authority} http://localhost:8080/api/admin/settings/:Authority
      curl -X PUT -d ${doi_provider} http://localhost:8080/api/admin/settings/:DoiProvider
      asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddoi.username\=${doi_username}"
      asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddoi.password\=${doi_password}"
      asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddoi.dataciterestapiurlstring\=${dataciterestapiurlstring}"
      asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options "-Ddoi.baseurlstring\=${baseurlstring}"
      if [ "${doi_shoulder}" ]; then
                curl -X PUT -d "${doi_shoulder}/" "$SERVER/admin/settings/:Shoulder"
      fi
    fi
fi
