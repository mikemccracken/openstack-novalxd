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

checkUnitsForErrors $services
checkUnitsForActive $services

exposeResult "Applications ready" 0 "true"
