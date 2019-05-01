#!/bin/bash

### Invoke as: bash scan.sh <target>

OPTS="-Pn -Tpolite --reason"
TARGET=${1:-eduroamuk-probe.dev.ja.net}

### Generate a random payload
PAYLOAD_N=$(($RANDOM + 1000))
let "PAYLOAD_N %= 30000"
PAYLOAD=$(echo ${PAYLOAD_N} | xxd -g 0 -ps)

### Run nmap
nmap ${OPTS} --data ${PAYLOAD} -sT -sU -p T:21,22,80,143,220,406,443,465,587,636,993,995,1194,1494,3128,3389,3653,5900,8080,10000,U:123,500,1194,3653,4500,7000-7007,10000 ${TARGET}

### Disabled as nothing listening at the moment
# nmap ${OPTS} -sO -p 41,47,50,51 ${TARGET}
