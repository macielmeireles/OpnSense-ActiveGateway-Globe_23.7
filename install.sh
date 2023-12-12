#!/bin/sh

# OpnSense Active Gateway Globe Script
# Version: 0.7 (beta d)
# Date: 12/12/2023
# Author: Maciel Meireles
# GitHub: https://github.com/macielmeireles/OpnSense-ActiveGateway-Globe

# Function to download and compare files
check_and_download_files() {
    if [ ! -f gateways.widget.original.php ]; then
        echo "Downloading the original file for comparison with the local file..."
        fetch -o gateways.widget.original.php $widgetgatewayOriginal_url
        [ $? -ne 0 ] && echo "Failed to download the original file. Please check the URL or your internet connection." && exit 1
    fi

    cmp -s "gateways.widget.original.php" "gateways.widget.php"
    [ $? -eq 0 ] && echo "The files are the same." || echo "The files are different."
}

# Function to print status
print_status() {
    echo "Last Tested Version: $(echo $tested_versions | awk '{print $NF}')"
    echo "Current Version: $current_version"
    check_and_download_files
    if echo "$tested_versions" | grep -q "$current_version"; then
        echo ""
        echo "Status: ✅ Safe - Tested Version"
    else
        echo ""
        echo "Status: ✅ Safe - Version not tested but files are the same"
    fi
}

# Define the tested versions of OPNsense
tested_versions="OPNsense 23.7.7_3 OPNsense 23.7.8_1 OPNsense 23.7.9 OPNsense 23.7.10_1"

# Define the names of the files to be downloaded
gateway_file="get_default_gateway_v.02.php"
widget_file="script_change_widget_v0.5.php"
gatewayoriginal_file="gateways.widget.original_from_OPNsense23.7.9.php"

# Define the base URL
base_url="https://raw.githubusercontent.com/macielmeireles/OpnSense-ActiveGateway-Globe/main/"

# Define the full URLs of the files to be downloaded
gateway_url="${base_url}${gateway_file}"
widget_url="${base_url}${widget_file}"
widgetgatewayOriginal_url="${base_url}${gatewayoriginal_file}"

# Define the URL of the original file to be restored
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
        echo "Restoring..."
        fetch -o gateways.widget.php $original_url
        echo ""
        echo ""
        echo "Restore Complete from Github!"
        ;;
    --check)
        print_status
        ;;
    *)
        print_status
        if echo "$tested_versions" | grep -q "$current_version"; then
            echo "Downloading files..."
            cd /usr/local/www/widgets/widgets/
            fetch -o get_default_gateway.php $gateway_url
            fetch -o script_change_widget.php $widget_url
            echo "Installing..."
            php script_change_widget.php
            echo ""
            echo ""
            echo "Script executed successfully!"
        else
            echo "Status: ❌ Unsafe - Incompatible version\n\nThe script needs to be updated. Please contact the script author."
            exit 1
        fi
        ;;
esac
