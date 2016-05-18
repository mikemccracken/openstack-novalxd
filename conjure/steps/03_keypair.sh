#!/bin/bash
#
# Description: Import ssh keypairs

. /usr/share/conjure-up/hooklib/common.sh

if [[ $JUJU_PROVIDERTYPE =~ "lxd" ]]; then

    if [ ! -f $HOME/.ssh/id_rsa.pub ]; then
        debug openstack "(post) adding keypair"
        if ! ssh-keygen -N '' -f $HOME/.ssh/id_rsa; then
            debug openstack "(post) Error attempting to create $HOME/.ssh/id_rsa.pub to be added OpenStack"
        fi

    fi
    . $SCRIPTPATH/novarc
    if ! openstack keypair show ubuntu-keypair > /dev/null 2>&1; then
        while ! openstack keypair create --public-key $HOME/.ssh/id_rsa.pub ubuntu-keypair > /dev/null 2>&1; do sleep 5; done
        exposeResult "Adding SSH Keypair..." 0 "true"
    fi
fi
