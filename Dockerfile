FROM alpine

MAINTAINER Matthew Slowe <matthew.slowe@jisc.ac.uk>

COPY eduroam-test.sh ./
RUN apk update && apk upgrade && apk add nmap vim bash && chmod +x ./eduroam-test.sh

ENTRYPOINT /bin/bash ./eduroam-test.sh