#!/usr/bin/env bash

set -eu

DOVECOT_IMAGE=${DOVECOT_IMAGE-dovecot/dovecot}
VERSION=${VERSION:-2.4.1}

## create manifests
#
for stage in "-root" "-dev" ""; do
	docker push $DOVECOT_IMAGE:$VERSION$stage-amd64
	docker push $DOVECOT_IMAGE:$VERSION$stage-arm64
	docker manifest rm $DOVECOT_IMAGE:$VERSION$stage || true
        docker manifest create $DOVECOT_IMAGE:$VERSION$stage \
		--amend $DOVECOT_IMAGE:$VERSION$stage-amd64 \
		--amend $DOVECOT_IMAGE:$VERSION$stage-arm64
	docker manifest push $DOVECOT_IMAGE:$VERSION$stage
done
