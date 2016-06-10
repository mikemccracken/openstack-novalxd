#!/bin/bash

. /usr/share/conjure-up/hooklib/common.sh

. $SCRIPTPATH/novarc
if [[ $JUJU_PROVIDERTYPE =~ "lxd" ]]; then

    if [ ! -f $SSHPUBLICKEY ]; then
        debug "Adding ssh public key $SSHPUBLICKEY"
        . $SCRIPTPATH/novarc
        if ! openstack keypair show ubuntu-keypair > /dev/null 2>&1; then
            while ! openstack keypair create --public-key $HOME/.ssh/id_rsa.pub ubuntu-keypair > /dev/null 2>&1; do sleep 5; done
            exposeResult "Added SSH Keypair" 0 "true"
        fi
    else
        exposeResult "Unable to add public ssh key, maybe ssh-keygen needs to be run." 1 "false"
    fi
fi
