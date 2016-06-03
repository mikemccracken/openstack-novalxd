#!/bin/bash
#
# Validate applications are started

. /usr/share/conjure-up/hooklib/common.sh

if [ $(unitStatus keystone 0) = "error" ]; then
    exposeResult "Error with keystone, please check juju status" 1 "false"
fi

if [ $(unitStatus keystone 0) != "active" ]; then
    exposeResult "keystone not quite ready yet" 0 "false"
fi

exposeResult "All services started and ready" 0 "true"
