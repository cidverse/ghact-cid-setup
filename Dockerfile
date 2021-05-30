# Container image that runs your code
FROM alpine:3.13

RUN apk add --no-cache curl bash

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY setup.sh /setup.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/setup.sh"]
