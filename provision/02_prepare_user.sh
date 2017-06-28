#!/bin/bash

########################################################################################################################
# Configure un virtualenv avec pip.
echo '====== VIRTUALENV'
mkdir -p ~/.ICE
virtualenv --no-download ~/.ICE
echo '
source ~/.ICE/bin/activate
' >> ~/.bashrc
source ~/.bashrc

########################################################################################################################
# Configure GIT
echo '====== GIT'
git config --global http.sslVerify false
git config --global credential.helper store
git config --global core.autocrlf input
