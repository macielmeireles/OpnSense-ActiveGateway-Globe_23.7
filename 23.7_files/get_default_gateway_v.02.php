<?php

/*
 * OpnSense Active Gateway Globe Script
 * Version: 0.2 (beta)
 * Date: 01/11/2023
 * Author: Maciel Meireles
 * GitHub: https://github.com/macielmeireles/OpnSense-ActiveGateway-Globe
 * Comment: This script retrieves the active gateway and exports it in JSON format.
 */

require_once("guiconfig.inc");
require_once("interfaces.inc");
header('Content-Type: application/json');

$down_gateways = isset($config['system']['gw_switch_default']) ? return_down_gateways() : [];
$gateways = new \OPNsense\Routing\Gateways();
$default_gwv4 = $gateways->getDefaultGW($down_gateways, 'inet');
$default_gwv6 = $gateways->getDefaultGW($down_gateways, 'inet6');
$default_gwv4_name = $default_gwv4['name'];
$default_gwv6_name = $default_gwv6['name'];

// $a_gateways = array_values($gateways->gatewaysIndexedByName(true, false, true)); // Not used 

echo json_encode(array(
    "default_gwv4" => $default_gwv4_name,
    "default_gwv6" => $default_gwv6_name 
    // "down_gateways" => $down_gateways, 	// Not used 
    // "a_gateways" => $a_gateways 		// Not used 
));

