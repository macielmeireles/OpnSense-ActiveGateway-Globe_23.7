#!/usr/local/bin/php
<?php
/*
 * OpnSense Active Gateway Globe Script
 * Version: 0.5 (beta)
 * Date: 01/11/2023
 * Author: Maciel Meireles
 * Comment: This script adds a globe icon next to the active gateway name in the OpnSense widget.
 */

// Define the file paths
$originalFile = '/usr/local/www/widgets/widgets/gateways.widget.php';
$backupFile = '/usr/local/www/widgets/widgets/gateways.widget_bak01.php';

// Create a backup of the original file
if (!copy($originalFile, $backupFile)) {
    echo "Failed to create a backup of $originalFile.\n";
    exit(1);
}

// New JavaScript Code Block
$newCode = '
<script>
$(window).on("load", function() {
    function fetch_gateway_statuses(){
        ajaxGet("/api/routes/gateway/status", {}, function(data, status) {
            if (data.items !== undefined) {
                $.getJSON("/widgets/widgets/get_default_gateway.php", function(defaultGatewayData) {
                    var default_gwv4 = defaultGatewayData.default_gwv4;
                    var default_gwv6 = defaultGatewayData.default_gwv6;
                    $.each(data.items, function(key, gateway) {
                        let $gw_item = $("#gateways_widget_gw_"+gateway.name);
                        if ($gw_item.length == 0) {
                            $gw_item = $("<tr>").attr("id", "gateways_widget_gw_"+gateway.name);
                            $gw_item.append($("<td/>").append(
                              "<small><strong>~</strong><br/><div>~</div></small>")
                            );
                            $gw_item.append($("<td class=\"text-nowrap\"/>").text("~"));
                            $gw_item.append($("<td class=\"text-nowrap\"/>").text("~"));
                            $gw_item.append($("<td class=\"text-nowrap\"/>").text("~"));
                            $gw_item.append(
                                $("<td/>").append(
                                    $("<span class=\"label label-default\"/>").text("Unknown")
                                )
                            );
                            $("#gateway_widget_table").append($gw_item);
                            $gw_item.hide();
                        }
                        if (gateway.name == default_gwv4 || gateway.name == default_gwv6 ) {
                            $gw_item.find("td:eq(0) > small > strong").text(gateway.name+" 🌎");
                        } else {
                            $gw_item.find("td:eq(0) > small > strong").text(gateway.name);
                        }
                        $gw_item.find("td:eq(0) > small > div").text(gateway.address);
                        $gw_item.find("td:eq(1)").text(gateway.delay);
                        $gw_item.find("td:eq(2)").text(gateway.stddev);
                        $gw_item.find("td:eq(3)").text(gateway.loss);
                        let status_color;
                        switch (gateway.status) {
                          case "force_down":
                          case "down":
                            status_color = "danger";
                            break;
                          case "loss":
                          case "delay":
                          case "delay+loss":
                            status_color = "warning";
                            break;
                          case "none":
                            status_color = "success";
                            break;
                          default:
                            status_color = "default";
                            break;
                        }
                        $gw_item.find("td:eq(4) > span").removeClass("label-danger label-warning label-success label-default");
                        if (status_color != "") {
                            $gw_item.find("td:eq(4) > span")
                              .addClass("label label-" + status_color)
                              .text(gateway.status_translated);
                        }
                        let show_item = $("#gatewaysinvert").val() == "yes" ? false  : true;
                        if ($("#gatewaysfilter").val() && $("#gatewaysfilter").val().includes(gateway.name)) {
                            show_item = !show_item;
                        }
                        if (show_item) {
                            $gw_item.show();
                        }
                    });
                });
            }
        });
        setTimeout(fetch_gateway_statuses, 5000);
    }
    fetch_gateway_statuses();
});
</script>
';

// Read the file content, remove the existing JavaScript code block, and insert the new one
$content = preg_replace('/<script>.*?<\/script>/s', $newCode, file_get_contents($originalFile));

// Write the content back to the file
file_put_contents($originalFile, $content);
?>
