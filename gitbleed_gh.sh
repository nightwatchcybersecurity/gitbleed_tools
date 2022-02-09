#!/bin/bash
#
# Processes Github repos
#
# Usage:
#   ./gitbleed_gh.sh [org/repo]
#
# Example:
#   ./gitbleed_gh.sh nightwatchcybersecurity/gitbleed_tools
#

./gitbleed.sh https://github.com/$1.git $1