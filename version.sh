#!/usr/bin/env bash

# Generate Build Version from buildids service and git tag or hash

set -e

DIR=${1:-$(pwd)}  # directory that contains the git repo
pushd ${DIR} 1> /dev/null

if [ "$2" == "continuous" ]; then
    GIT_VERSION=$(git rev-parse --short HEAD)
    PROJECT=$(basename $(pwd))
    SHA256=$(echo "${PROJECT}" | sha256sum | awk '{ print $1 }')
    BUILDID=$(curl -s https://buildids.panubo.vgrd.net/id/${SHA256})
    VERSION="${GIT_VERSION}-${BUILDID}"
    echo "Version Tag is: $VERSION (continuous)"
else
    GIT_VERSION=$(git describe --always --tags --long)
    PROJECT=$(basename $(pwd))
    SHA256=$(echo "${PROJECT}${GIT_VERSION}" | sha256sum | awk '{ print $1 }')
    BUILDID=$(curl -s https://buildids.panubo.vgrd.net/id/${SHA256})
    VERSION="${GIT_VERSION}-${BUILDID}"
    echo "Version Tag is: $VERSION (regular)"
fi

popd 1> /dev/null
echo $VERSION > version/tag
echo $BUILDID > version/buildid
echo $PROJECT > version/project
echo $GIT_VERSION > version/git_version
