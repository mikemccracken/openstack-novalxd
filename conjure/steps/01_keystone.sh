#!/bin/bash
#
# Description: Setup Identity Service

. /usr/share/conjure-up/hooklib/common.sh

check_keystone() {
    $(unitStatus keystone 0)
}
while [ check_keystone != "active" ]
do
    debug openstack "Waiting on keystone to be active"
    sleep 3
done
