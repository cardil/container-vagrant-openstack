#!/usr/bin/env bash

set -Eeuo pipefail

GITHUB_EVENT_NAME="${GITHUB_EVENT_NAME:?Missing event name}"

VERSION=noop
PUSH=true

if [[ "$GITHUB_REF" == refs/tags/* ]]; then
  VERSION="${GITHUB_REF#refs/tags/}"
elif [[ "$GITHUB_REF" == refs/heads/* ]]; then
  VERSION="${GITHUB_REF#refs/heads/}"
  if [[ "${VERSION}" == bugfix/* ]] || [[ "${VERSION}" == hotfix/* ]] || [[ "${VERSION}" == feature/* ]]; then
    PUSH=false
  fi
  VERSION="$(echo "${VERSION}" | sed -r 's#/+#-#g')"
  if [[ "${VERSION}" == 'master' ]]; then
    VERSION='latest'
  fi
elif [[ "$GITHUB_REF" == refs/pull/* ]]; then
  VERSION="pr-${GITHUB_REF#refs/pull/}"
  VERSION="${VERSION%/*}"
fi

TAGS="${VERSION}"

{
  echo "version=${VERSION}"
  echo "tags=${TAGS}"
  echo "created=$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
  echo "push=${PUSH}"
} >> "$GITHUB_OUTPUT"
