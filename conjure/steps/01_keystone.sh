#!/bin/bash
#
# Description: Setup Identity Service

. /usr/share/conjure-up/hooklib/common.sh

keystone_status=$(unitStatus keystone 0)
while [ $keystone_status != "active" ]
do
    exposeResult "Waiting for Keystone..." 1 "false"
    sleep 3
done
