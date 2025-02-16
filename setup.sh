#!/usr/bin/env bash
set -euo pipefail

# input
CID_VERSION="$1"
CID_DIR="${RUNNER_TOOL_CACHE}/cid-${CID_VERSION}"

# installation
echo "::group::Installation"
DOWNLOAD_URL=https://github.com/cidverse/cid/releases/download/${CID_VERSION}/linux_amd64
if [ "$CID_VERSION" = "latest" ]; then
    DOWNLOAD_URL=https://github.com/cidverse/cid/releases/latest/download/linux_amd64
fi

echo "Downloading from $DOWNLOAD_URL ..."
mkdir -p $CID_DIR/bin
export PATH=$CID_DIR/bin:$PATH
curl -L -s -o $CID_DIR/bin/cid $DOWNLOAD_URL
chmod 755 $CID_DIR/bin/cid
echo "::endgroup::"

# test
echo "::group::Test"
cid version
echo "::endgroup::"

# catalog
echo "::group::Catalog"
cid catalog update
cid catalog list
cid executables update
echo "::endgroup::"

# output
echo "::group::Output"

echo "Setting: CID_VERSION=$CID_VERSION"
echo "CID_VERSION=$CID_VERSION" >> $GITHUB_ENV

echo "Adding Path: $CID_DIR/bin"
echo "$CID_DIR/bin" >> $GITHUB_PATH

echo "::endgroup::"
