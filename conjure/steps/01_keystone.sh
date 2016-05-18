#!/bin/bash
#
# Description: Setup Identity Service

. /usr/share/conjure-up/hooklib/common.sh

check_keystone() {
    unitStatus keystone 0
}

while [ $(check_keystone) != "active" ]; do sleep 5; done
exposeResult "Keystone is active" 0 "true"
