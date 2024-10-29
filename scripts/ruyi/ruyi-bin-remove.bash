#!/bin/bash

SELF_PATH=$(realpath $(dirname $0)/../../)

~/.local/bin/ruyi self clean --distfiles --installed-pkgs --progcache --repo --telemetry
rm -rf ~/.local/share/ruyi/ ~/.local/state/ruyi/ ~/.cache/ruyi/

rm -f ~/.local/bin/ruyi

rm -f "$SELF_PATH"/rit.bash_env/ruyi_ruyi-bin-install.pre
rm -f "$SELF_PATH"/rit.bash_env/ruyi_ruyi-bin-install.post

