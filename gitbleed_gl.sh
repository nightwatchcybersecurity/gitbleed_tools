#!/bin/bash
#
# Processes Gitlab repos
#
# Usage:
#   ./gitbleed_gl.sh [org/repo]
#
# Example:
#   ./gitbleed_gl.sh nwcs/junit_ui_bug
#

./gitbleed.sh https://gitlab.com/$1.git $1