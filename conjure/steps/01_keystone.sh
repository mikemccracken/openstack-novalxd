#!/bin/bash
#
# Description: Setup Identity Service

. /usr/share/conjure-up/hooklib/common.sh

keystone_status=$(unitStatus keystone 0)
while [ $keystone_status != "active" ]
do
    debug openstack "Waiting on keystone to be active"
    sleep 3
done
