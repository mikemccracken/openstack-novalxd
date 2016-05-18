#!/bin/bash
#
# Description: Display Horizon

. /usr/share/conjure-up/hooklib/common.sh

dashboard_address() {
    unitAddress openstack-dashboard 0
}

while [ $(dashboard_address) = "null" ]; do sleep 5; done

exposeResult "Login to Horizon: http://$(dashboard_address)/horizon l: admin p: openstack" 0 "true"
