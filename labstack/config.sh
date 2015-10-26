#!/bin/bash

# Pink Scripts
# github.com/jeffersonmartin/pink-scripts/
#
# The pink-scripts are for development and sysadmin tasks on
# Mac OS X and Ubuntu linux. Each script can be executed
# using the terminal by executing the file. If you do
# not specify any command-line arguments, you will
# be prompted with a wizard to fill in. You can
# pass arguments to avoid the wizard for a
# silent execution using a cron job or
# executed from another script.

# Environment Variables

#################################################
###       MAKE CHANGES BELOW THIS LINE        ###
#################################################

# DEVELOPER NOTE: These variables do not have
# error checking so proper integer values are
# important.

# Specify whether the Worldwide NOC exists yet
# Values: 0 No, 1 Yes
ENV_WW_NOC_EXISTS='0'

# Specify the cell number that you're deploying
# Values: Integer between 1-9
ENV_CELL_NUMBER='1'

# Specify the number of racks in the cell
# Values: Integer between 1-9
ENV_RACK_COUNT='6'

#################################################
###       MAKE CHANGES ABOVE THIS LINE        ###
#################################################

# Script Meta Data
SCRIPT_TITLE='Build Ubuntu Config for Cell Agent VM'
SCRIPT_DIR='labstack'
SCRIPT_FILE='build-ubuntu-cell-agent.sh'

# Usage
# ~/Sites/jeffersonmartin/pink-scripts/laravel/package-create.sh [PACKAGENAME]

#################################################
###       MAKE CHANGES BELOW THIS LINE        ###
#################################################

# You need to change these values based on your local development
# environment.
#
# During execution, these variables will be concatenated into
# the local path of your Laravel application that you will
# be developing your packages in.
#
# GITHUB_LOCAL_PATH / GITHUB_ACCOUNT / GITHUB_REPO / app
# Example: ~/Sites/bridgedlabs/laravel/app

# Default Values for Wizard
GITHUB_LOCAL_PATH='/Users/jefferson/Sites'
GITHUB_ACCOUNT='bridgedlabs'
GITHUB_REPO='laravel'
PACKAGE_VENDOR='bridgedlabs'
PACKAGE_NAME=$1