#!/bin/bash

function certs () {

OPENSSL=$(which openssl)
CERT_DIR="./certs"

if [ ! -d $CERT_DIR ]; then
  mkdir $CERT_DIR
else 
  echo "$CERT_DIR: already exits ..."
fi

if [ ${OPENSSL} ]; then

  cd ${CERT_DIR}
  sudo ${OPENSSL} genrsa 2048 > ca-key.pem 
  sudo ${OPENSSL} req -new -x509 -nodes -days 3600 -key ca-key.pem -out ca.pem
  sudo ${OPENSSL} req -newkey rsa:2048 -days 3600 -nodes -keyout key.pem -out server-req.pem
  sudo ${OPENSSL} rsa -in key.pem -out key.pem
  sudo ${OPENSSL} x509 -req -in server-req.pem -days 3600 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out cert.pem

else
  echo "${OPENSSL}: command not found!"
  exit 1;
fi

}

$@