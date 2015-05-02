#!/usr/bin/env bash
# Used as a default file to source to set an environment at Bloomberg. This will have to be modified for differet parts of the organizations.
export PIP_CERT=/etc/ssl/certs/ca-certificates.crt
export PIP_PROXY=http://proxy.bloomberg.com:80
export http_proxy=http://proxy.bloomberg.com:80
export https_proxy=http://proxy.bloomberg.com:80
export GIT_SSL_NO_VERIFY=true
export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export no_proxy='localhost,127.0.0.0/8,127.0.1.1,127.0.1.1*,local.home,192.0.0.0/8,10.0.0.0/8,172.0.0.0/8,100.0.0.0/8'
