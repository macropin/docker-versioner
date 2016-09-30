#!/usr/bin/env bash

# Generate Build Version from buildids service and git tag

set -e

DIR=${1:-$(pwd)}  # directory that contains the git repo w/ tags

pushd ${DIR} 1> /dev/null

GIT_VERSION=$(git describe --always --tags --long)
PROJECT=$(basename $(pwd))
SHA256=$(echo "${PROJECT}${GIT_VERSION}" | sha256sum | awk '{ print $1 }')
BUILDID=$(curl -s https://buildids.panubo.vgrd.net/id/${SHA256})
VERSION="${GIT_VERSION}-${BUILDID}"

popd 1> /dev/null

echo "Version Tag is: $VERSION"
echo $VERSION > version/tag
echo $BUILDID > version/buildid
echo $PROJECT > version/project
echo $GIT_VERSION > version/git_version
