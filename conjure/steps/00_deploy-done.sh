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
              "mysql" \
              "nova-cloud-controller" \
              "nova-compute" \
              "openstack-dashboard" \
              "rabbitmq-server")

checkUnitsForErrors $services

if [ $(unitStatus nova-cloud-controller 0) != "active" ]; then
    exposeResult "OpenStack not ready yet" 0 "false"
fi

exposeResult "Applications ready" 0 "true"
