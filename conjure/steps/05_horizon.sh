#!/bin/bash
#
# Title: Display Horizon

. /usr/share/conjure-up/hooklib/common.sh

exposeResult "Login to Horizon: http://$(dashboard_address)/horizon l: admin p: openstack" 0 "true"
