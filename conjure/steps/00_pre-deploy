#!/bin/bash

. /usr/share/conjure-up/hooklib/common.sh

if [[ $JUJU_PROVIDERTYPE =~ "lxd" ]]; then

    profilename=$(juju switch | cut -d: -f2)
    debug "processing lxd - profile: $profilename"
    sed "s/##MODEL##/$profilename/" $SCRIPTPATH/lxd-profile.yaml | lxc profile edit "juju-$profilename"

    RET=$?
    if [ $RET -ne 0 ]; then
        exposeResult "Failed to update lxd profile: $profilename" $RET "false"
    else
        exposeResult "Complete" 0 "true"
    fi

fi

exposeResult "Finished post bootstrap tasks..." 0 "true"
