#!/bin/bash

set ${CI:+-x} -euo pipefail

# /*
# Install MergerFS
# */
/run/build_files/github-release-install.sh trapexit/mergerfs "fc$(rpm -E %fedora).$(uname -m)"
