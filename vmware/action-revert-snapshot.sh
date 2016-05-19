#!/bin/bash

# Pink Scripts (Vmware)
# github.com/jeffersonmartin/pink-scripts/vmware
#
# The pink-scripts are for development and sysadmin tasks on
# Mac OS X and Ubuntu linux. Each script can be executed
# using the terminal by executing the file. If you do
# not specify any command-line arguments, you will
# be prompted with a wizard to fill in. You can
# pass arguments to avoid the wizard for a
# silent execution using a cron job or
# executed from another script.
#
# Dependencies:
# - vmware-cmd

# Script Meta Data
SCRIPT_TITLE='Revert Virtual Machine to Snapshot'
SCRIPT_DIR='vmware'
SCRIPT_FILE='action-revert-snapshot.sh'

# Input Parameters:
# $1   ESXi IP Address or DNS Hostname (Ex. 10.100.81.2)
# $2   ESXi Username (Ex. root)
# $3   ESXi Password (Ex. scale2Fast)
# $4   ESXi Datastore Name (Ex. n8102-vm)
# $5   VM Filename (Ex. sandbox-vm)
#
# Usage:
# ./action-revert-snapshot.sh 10.100.81.2 root scale2Fast n8102-vm sandbox-vm
#

# Define Variables from Input Paramaters
ESX_HOST=$1
ESX_USER=$2
ESX_PASS=$3
ESX_DATASTORE=$4
ESX_VMFILE=$5

# Define Variables for Syntax Highlighting Colors
C_DEFAULT='\033[m'
C_RED='\033[1;31m'
C_GREEN='\033[1;32m'
C_YELLOW='\033[1;33m'
C_BLUE='\033[1;34m'
C_PURPLE='\033[1;35m'
C_CYAN='\033[1;36m'

#
# Output - Script Action Confirmation
#

printf "\n"
printf "${C_GREEN}Reverting virtual machine ${ESX_VMFILE} on host ${ESX_HOST}.${C_DEFAULT}\n"
printf "\n\n"

#
# Execute Command (with returned output)
#

# export PERL_LWP_SSL_VERIFY_HOSTNAME=0
# /usr/bin/vmware-cmd -H $1 -U $2 -P $3 -v "/vmfs/volumes/$4/$5/$5.vmx" revertsnapshot