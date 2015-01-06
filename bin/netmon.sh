#!/bin/sh

# F is an optional formatter, like nagios2nljson
F=

while getopts "hj" opt
do
  case $opt in
    h)
      cat <<EOF
usage: netmon.sh [-h] [-j]
 -h shows help
 -j prints output in json rows
EOF
      exit
      ;;
    j)
      F=nagios2nljson
      ;;
  esac
done


gateway=`netstat -r | awk '"default" == $1 { print $2 }'`

googledns="8.8.8.8"

# if these fail, everything else fails, so exit early
# and point finger at root cause

if [ -z "$gateway" ]
then
  $F sh -c 'echo "FAIL no local network" ; exit 2'
  exit 2
fi

if ! $F testnet $gateway
then
  exit 2
fi

if ! $F testnet $googledns
then
  exit 2
fi

# if network is up, then test services

$F testdns $googledns
$F testdns $gateway
$F testdns localhost

$F testntp $gateway
$F testntp localhost
