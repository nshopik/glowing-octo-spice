#!/bin/sh
## pktgen.conf -- configuration for send on devices 

modprobe pktgen

pgset() {
    local result

    echo $1 > $PGDEV

    result=`cat $PGDEV | fgrep "Result: OK:"`
    if [ "$result" = "" ]; then
         cat $PGDEV | fgrep Result:
    fi
}

pg() {
    echo inject > $PGDEV
    cat $PGDEV
}

## Settings for pktgen params

echo "Adding devices to run". 

PGDEV=/proc/net/pktgen/kpktgend_0
pgset "rem_device_all"

pgset "add_device eth0"
## max_before_softirq is obsoleted -- Do not use
#pgset "max_before_softirq 10000"

## Configure the individual devices
echo "Configuring devices"
PGDEV=/proc/net/pktgen/eth0
pgset "clone_skb 10000"
pgset "pkt_size 128"
pgset "dst 192.168.20.25" 
pgset "dst_mac 00:00:00:00:01:02"
pgset "count 1000000"
pgset "delay 0"

# Time to run

PGDEV=/proc/net/pktgen/pgctrl

echo "Running... ctrl^C to stop"

pgset "start" 

echo "Done"
