#!/bin/bash
#
# Description: Display Horizon

dashboard_address=$(unitAddress openstack-dashboard 0)
while [ $dashboard_address = "null" ]
do
    debug openstack "Waiting for the dashboard to become available"
    sleep 5
done

exposeResult "Login to Horizon: http://$dashboard_address/horizon l: admin p: openstack" 0 "true"
