#!/bin/bash
#
# Validate applications are started

. /usr/share/conjure-up/hooklib/common.sh

services=("keystone" \
              "glance" \
              "neutron-api" \
              "neutron-gateway" \
              "ceph-mon" \
              "ceph-osd" \
              "ceph-radosgw" \
              "cinder" \
              "mysql" \
              "nova-cloud-controller" \
              "nova-compute" \
              "openstack-dashboard" \
              "rabbitmq-server")

check_error() {
    for i in "${services[@]}"
    do
        if [ $(unitStatus $i 0) = "error" ]; then
            debug "$i, gave a charm error."
            exposeResult "Error with $i, please check juju status" 1 "false"
        fi
    done
}


check_active() {
    for i in "${services[@]}"
    do
        debug "Checking agent state of $i: $(unitStatus $i 0)"
        if [ $(unitStatus $i 0) != "active" ]; then
            exposeResult "$i not quite ready yet" 0 "false"
        fi
    done
}

check_error
check_active

exposeResult "All services started and ready" 0 "true"
