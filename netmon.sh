#!/bin/sh

gateway=`netstat -r | awk '"default" == $1 { print $2 }'`

googledns="8.8.8.8"

if [ -z "$gateway" ]
then
  echo "FAIL no local network"
  exit 2
fi

if ! testnet $gateway
then
  echo "FAIL cannot reach local gateway"
  exit 2
fi

if ! testnet $googledns
then
  echo "FAIL cannot reach internet"
  exit 2
fi

# if network is up, then test services

testdns $googledns
testdns $gateway
testdns localhost

testntp $gateway
testntp localhost
