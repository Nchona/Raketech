#!/bin/bash
# Script to setup WordPress and install WP Offload Media plugin on the docker image
cd /path/to/wordpress
composer require deliciousbrains/wp-offload-media
wp plugin activate wp-offload-media
