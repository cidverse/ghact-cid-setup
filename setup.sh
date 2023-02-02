#!/usr/bin/env bash
set -euo pipefail

# input
CID_VERSION=$1

# installation
echo "::group::Installation"
DOWNLOAD_URL=https://github.com/cidverse/cid/releases/download/$CID_VERSION/linux_amd64
echo "Downloading from $DOWNLOAD_URL ..."
mkdir -p $RUNNER_TOOL_CACHE/cid/bin
export PATH=$RUNNER_TOOL_CACHE/cid/bin:$PATH
curl -L -s -o $RUNNER_TOOL_CACHE/cid/bin/cid $DOWNLOAD_URL
chmod 755 $RUNNER_TOOL_CACHE/cid/bin/cid
echo "::endgroup::"

# test
echo "::group::Test"
cid version
echo "::endgroup::"

# catalog
echo "::group::Catalog"
cid catalog update
echo "::endgroup::"

# output
echo "::group::Output"

echo "Setting: CID_VERSION=$CID_VERSION"
echo "CID_VERSION=$CID_VERSION" >> $GITHUB_ENV

echo "Adding Path: $RUNNER_TOOL_CACHE/cid/bin"
echo "$RUNNER_TOOL_CACHE/cid/bin" >> $GITHUB_PATH

echo "::endgroup::"
