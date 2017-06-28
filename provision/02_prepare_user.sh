#!/bin/bash

########################################################################################################################
# Configure l'accès au web passant par le proxy EDF. NNI et password SESAME à utiliser.
echo '====== PROXY'
# Le script du proxy
echo '
#!/bin/sh -x

export login=${LOGIN}
export password=${PASSWORD}
export url=pcyvipncp2n.edf.fr

unset http_proxy
unset https_proxy   

curl --max-time 5 -k https://$login:$password@authpcy.edf.fr/?cfru=aHR0cDovL3d3dy5nb29nbGUuZnIv

export http_proxy=http://$login:$password@$url:3128
export https_proxy=$http_proxy
export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
' > ~/proxy.sh

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
