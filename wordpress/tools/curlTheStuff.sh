#!/bin/bash

set -euo pipefail

if [ ! -f "./wp-cli.phar" ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
fi

if [ ! -f "./wordpress.tar.gz" ]; then
	curl https://wordpress.org/latest.tar.gz --output wordpress.tar.gz
fi