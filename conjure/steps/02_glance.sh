#!/bin/bash
#
# Description: Import Glance Images

. /usr/share/conjure-up/hooklib/common.sh

glance_status=$(unitStatus glance 0)
while [ $glance_status != "active" ]
do
    debug openstack "Waiting for Glance to be active"
    sleep 3
done

if [[ $JUJU_PROVIDERTYPE =~ "lxd" ]]; then
    imagetype=root.tar.xz
    diskformat=raw
    imagesuffix="-lxd"
else
    imagetype=disk1.img
    diskformat=root-tar
    imagesuffix=""
fi

mkdir -p $HOME/glance-images || true
if [ ! -f $HOME/glance-images/xenial-server-cloudimg-amd64-$imagetype ]; then
    debug openstack "(post) downloading xenial image..."
    wget -qO ~/glance-images/xenial-server-cloudimg-amd64-$imagetype https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-$imagetype
fi
if [ ! -f $HOME/glance-images/trusty-server-cloudimg-amd64-$imagetype ]; then
    debug openstack "(post) downloading trusty image..."
    wget -qO ~/glance-images/trusty-server-cloudimg-amd64-$imagetype https://cloud-images.ubuntu.com/trusty/current/trusty-server-cloudimg-amd64-$imagetype
fi

. $SCRIPTPATH/novarc
if ! glance image-list --property-filter name="trusty$imagesuffix" | grep -q "trusty$imagesuffix" ; then
    debug openstack "(post) importing trusty$imagesuffix"
    glance image-create --name="trusty$imagesuffix" \
           --container-format=bare \
           --disk-format=$diskformat \
           --property architecture="x86_64" \
           --visibility=public --file=$HOME/glance-images/trusty-server-cloudimg-amd64-$imagetype > /dev/null 2>&1
fi
if ! glance image-list --property-filter name="xenial$imagesuffix" | grep -q "xenial$imagesuffix" ; then
    debug openstack "(post) importing xenial$imagesuffix"
    glance image-create --name="xenial$imagesuffix" \
           --container-format=bare \
           --disk-format=$diskformat \
           --property architecture="x86_64" \
           --visibility=public --file=$HOME/glance-images/xenial-server-cloudimg-amd64-$imagetype > /dev/null 2>&1
fi
