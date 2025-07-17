#!/usr/bin/env bash

set -eu

DOVECOT_IMAGE=${DOVECOT_IMAGE-dovecot/dovecot}
VERSION=${VERSION:-2.4.1}

##
# latest
for stage in "-root" "-dev" ""; do
	docker manifest rm $DOVECOT_IMAGE:latest-2.4$stage || true
	docker manifest rm $DOVECOT_IMAGE:latest$stage || true
	docker manifest create $DOVECOT_IMAGE:latest-2.4$stage \
		--amend $DOVECOT_IMAGE:$VERSION$stage-amd64 \
		--amend $DOVECOT_IMAGE:$VERSION$stage-arm64
	docker manifest push $DOVECOT_IMAGE:latest-2.4$stage
	docker manifest create $DOVECOT_IMAGE:latest$stage \
                --amend $DOVECOT_IMAGE:$VERSION$stage-amd64 \
                --amend $DOVECOT_IMAGE:$VERSION$stage-arm64
	docker manifest push $DOVECOT_IMAGE:latest$stage
done
