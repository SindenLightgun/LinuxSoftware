#!/bin/bash

LOCKFILE=/tmp/LightgunMono.exe.lock

if [ -e $LOCKFILE ]; then
    DETAILS=$(sudo cat ${LOCKFILE})
    if [ "$DETAIL" != "" ]; then
        sudo kill $DETAILS
        echo "" > $LOCKFILE
        sleep 2
    fi
fi
