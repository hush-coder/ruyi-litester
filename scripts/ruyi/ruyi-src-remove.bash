#!/bin/bash

SELF_PATH=$(realpath $(dirname $0)/../../)

TMP_DIR="/tmp/rit-script-ruyi-src-install"

~/.local/bin/ruyi self clean --distfiles --installed-pkgs --progcache --repo --telemetry
rm -rf ~/.local/share/ruyi/ ~/.local/state/ruyi/ ~/.cache/ruyi/

rm -rf "$TMP_DIR" ~/.local/bin/ruyi

rm -f "$SELF_PATH"/rit.bash_env/ruyi_ruyi-src-install.pre
rm -f "$SELF_PATH"/rit.bash_env/ruyi_ruyi-src-install.post

