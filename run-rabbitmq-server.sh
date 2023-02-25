#!/bin/sh

set -eux

readonly curdir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
readonly rabbitmq_version='3.11.9'
readonly rabbitmq_etc="$curdir/rabbitmq_server-$rabbitmq_version/etc/rabbitmq"
readonly rabbitmq_sbin="$curdir/rabbitmq_server-$rabbitmq_version/sbin"

if [ ! -d 'rabbitmq_server-3.11.9' ]
then
    curl -LO "https://github.com/rabbitmq/rabbitmq-server/releases/download/v$rabbitmq_version/rabbitmq-server-generic-unix-$rabbitmq_version.tar.xz"
    tar xf "rabbitmq-server-generic-unix-$rabbitmq_version.tar.xz"
    "$rabbitmq_sbin/rabbitmq-plugins" enable rabbitmq_management
fi

cp -vf "$curdir/rabbitmq.conf" "$rabbitmq_etc/rabbitmq.conf"

"$rabbitmq_sbin/rabbitmq-server"
