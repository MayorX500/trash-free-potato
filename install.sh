#!/usr/bin/env bash

set -o nounset  # exit on uninitialised variable
set -o errexit  # exit on error
#set -o xtrace   # debug mode

# install.sh - Install script for Visual Paradign
#
# Jurgen Verhasselt - https://gitlab.com/sjugge/docker/visual-paradigm 
# Miguel Gomes - https://github.com/MayorX500/trash-free-potato

wget -q https://www.visual-paradigm.com/downloads/vp17.0/Visual_Paradigm_Linux64.sh --show-progress
chmod +x Visual_Paradigm_Linux64.sh

if [ -f "/usr/local/bin/Visual_Paradigm" ]; then
	Visual_Paradigm
else
	./Visual_Paradigm_Linux64.sh
	rm -f Visual_Paradigm_Linux64.sh
fi

