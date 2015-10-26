#!/bin/bash

#
# DHCP Reservation Generator for Cell
# Labstack
#
# Sample Usage:
# /etc/dhcp/generate_labstack_dhcp_reservations.sh <cell-number> > /etc/dhcp/labstack_dhcp_reservations.conf
#

# Define cell number from command line argument
CELL=$1

# loop through racks 1-9
for ((rack=1; rack<=9; rack++)); do

    # loop through nodes 2-55
    for ((node=2; node<=55; node++)); do

        NODE_LEADING=$node
        if [ $node -lt 10 ]; then
            NODE_LEADING="0${node}"
        fi

        # loop through pods 10-29
        for ((pod=10; pod<=29; pod++)); do

            # Output DHCP Reservation Stanza
            printf "host pod${CELL}${rack}${NODE_LEADING}${pod} {\n"
            printf "    hardware ethernet 02:${CELL}${rack}:${NODE_LEADING}:${pod}:00:11;\n";
            printf "    fixed-address 10.1${CELL}${rack}.${node}.${pod};\n";
            printf "    option domain-name \"pod${CELL}${rack}${NODE_LEADING}${pod}.cell${CELL}.labstack.local\";\n";
            printf "}\n"
            printf "\n"

        done

    done

done
