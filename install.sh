#!/bin/sh

# OpnSense Active Gateway Globe Script
# Version: 0.4 (beta)
# Date: 06/11/2023
# Author: Maciel Meireles
# GitHub: https://github.com/macielmeireles/OpnSense-ActiveGateway-Globe

# Define the correct version of OPNsense
correct_version="OPNsense 23.7.7_3"

# Define the names of the files to be downloaded
gateway_file="get_default_gateway_v.02.php"
widget_file="script_change_widget_v0.5.php"

# Define the base URL
base_url="https://raw.githubusercontent.com/macielmeireles/OpnSense-ActiveGateway-Globe/main/"

# Define the full URLs of the files to be downloaded
gateway_url="${base_url}${gateway_file}"
widget_url="${base_url}${widget_file}"

# Define the URL of the original file
original_url="https://raw.githubusercontent.com/opnsense/core/master/src/www/widgets/widgets/gateways.widget.php"

# Get the current version of OPNsense
current_version=$(opnsense-version)

# Check the provided option
case "$1" in
    --help)
        echo "- To install, use: ./install"
        echo "- To restore, use: ./install --restore"
        echo "- To check the version, use: ./install --check"
        ;;
    --restore)
        # Download the original file
        fetch -o gateways.widget.php $original_url
        echo ""
        echo ""
        echo "Restore Complete from Github!"
        ;;
    --check)
        # Check if the current version is the correct version
        if [ "$current_version" != "$correct_version" ]; then
            echo "The current version of OPNsense ($current_version) is not the correct version ($correct_version). Please update OPNsense."
        else
            echo "The current version of OPNsense ($current_version) is the correct version."
        fi
        ;;
    *)
        # Check if the current version is the correct version
        if [ "$current_version" != "$correct_version" ]; then
            echo "The current version of OPNsense ($current_version) is not the correct version ($correct_version). Please update OPNsense before running this script."
            exit 1
        fi

        # Change to the desired directory
        cd /usr/local/www/widgets/widgets/

        # Download the files and rename them
        fetch -o get_default_gateway.php $gateway_url
        fetch -o script_change_widget.php $widget_url

        # Execute the PHP script
        php script_change_widget.php
        echo ""
        echo ""
        echo "Script executed successfully!"
        ;;
esac
