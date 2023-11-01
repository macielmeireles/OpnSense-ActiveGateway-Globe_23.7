#!/bin/sh

# OpnSense Active Gateway Globe Script
# Version: 0.3 (beta)
# Date: 01/11/2023
# Author: Maciel Meireles
# GitHub: https://github.com/macielmeireles/OpnSense-ActiveGateway-Globe
# Comment: This script downloads two files, the first one monitors the active gateway and the second one modifies the original widget file of OpnSense.

# Define the names of the files to be downloaded
gateway_file="get_default_gateway_v.02.php"
widget_file="script_change_widget_v0.5.php"

# Define the base URL
base_url="https://raw.githubusercontent.com/macielmeireles/OpnSense-ActiveGateway-Globe/main/"

# Define the full URLs of the files to be downloaded
gateway_url="${base_url}${gateway_file}"
widget_url="${base_url}${widget_file}"

# Change to the desired directory
cd /usr/local/www/widgets/widgets/

# Download the files and rename them
fetch -o get_default_gateway.php $gateway_url
fetch -o script_change_widget.php $widget_url

# Execute the PHP script
php script_change_widget.php
