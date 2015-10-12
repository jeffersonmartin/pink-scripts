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

# Script Meta Data
SCRIPT_TITLE='Laravel Package Creator'
SCRIPT_DIR='laravel'
SCRIPT_FILE='package-create.sh'

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

#################################################
###       MAKE CHANGES ABOVE THIS LINE        ###
#################################################

# Define Variables for Syntax Highlighting Colors
C_DEFAULT='\033[m'
C_WHITE='\033[1m'
C_BLACK='\033[30m'
C_RED='\033[31m'
C_GREEN='\033[32m'
C_YELLOW='\033[33m'
C_BLUE='\033[34m'
C_PURPLE='\033[35m'
C_CYAN='\033[36m'
C_LIGHTGRAY='\033[37m'
C_DARKGRAY='\033[1;30m'
C_LIGHTRED='\033[1;31m'
C_LIGHTGREEN='\033[1;32m'
C_LIGHTYELLOW='\033[1;33m'
C_LIGHTBLUE='\033[1;34m'
C_LIGHTPURPLE='\033[1;35m'
C_LIGHTCYAN='\033[1;36m'

#
# Output - Script Header
#

printf "${C_PURPLE}\n"
printf "   /**\n"
printf "    *\n"
printf "    ${C_PURPLE}*   ${C_PURPLE}${SCRIPT_TITLE}\n"
printf "    ${C_PURPLE}*   \n"
printf "    ${C_PURPLE}*   ${C_DEFAULT}@package${C_PURPLE} jeffersonmartin/pink-scripts/${SCRIPT_DIR}/${SCRIPT_FILE}\n"
printf "    ${C_PURPLE}*   ${C_DEFAULT}@author${C_PURPLE}  github.com/jeffersonmartin\n"
printf "    ${C_PURPLE}*   \n"
printf "    */\n"
printf "    \n${C_DEFAULT}"

#
# Output - Path Confirmation
#

printf "        ${C_DARKGRAY}Package will be created in the following directory:${C_DEFAULT}\n"
printf "        ${C_DARKGRAY}${GITHUB_LOCAL_PATH}/${GITHUB_ACCOUNT}/${GITHUB_REPO}/packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}${C_DEFAULT}"
printf "\n\n"

#
# Validation - Check for CLI Arguments
#

# If Package Name Provided (in CLI argument)
if [ "${PACKAGE_NAME}" != "" ]; then

    printf "        ${C_DEFAULT}${C_DARKGRAY}All command-line arguments were provided. No wizard will be necessary.${C_DEFAULT}\n"

fi

# If package name NOT provided, start wizard
if [ "${PACKAGE_NAME}" == "" ]; then

    # Prompt User for package name
    printf "${C_LIGHTYELLOW}"
    read -p "        What is the new package name?  "  PACKAGE_NAME
    printf "${C_DEFAULT}\n"

fi

# If package name NOT provided, restart wizard with error message.
if [ "${PACKAGE_NAME}" == "" ]; then

    printf "${C_LIGHTRED}        Ouch! Pay attention to what you're doing!  ${DEFAULT}\n\n"
    printf "${C_LIGHTYELLOW}"
    read -p "        What is the new package name?  "  PACKAGE_NAME
    printf "${C_DEFAULT}\n"

fi

# If package name is still not provided, terminate script
if [ "${PACKAGE_NAME}" == "" ]; then

    printf "${C_LIGHTRED}        Don't blame me. I'm an interpreter.\n"
    printf "        This script has been terminated.${C_DEFAULT}\n\n"

fi

# If package name is provided, execute script
if [ "${PACKAGE_NAME}" != "" ]; then
    printf "\n        ${C_LIGHTGREEN}Creating new package '${PACKAGE_VENDOR}/${PACKAGE_NAME}' ${C_DEFAULT}\n\n"

    printf "${C_PURPLE}        Step 1. Creating Directory Structure in Laravel App\n"
    mkdir -p ${GITHUB_LOCAL_PATH}/${GITHUB_ACCOUNT}/${GITHUB_REPO}/packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/
    printf ${C_DEFAULT}"          Created /packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/\n"

    DIRECTORY='Commands'
    mkdir -p ${GITHUB_LOCAL_PATH}/${GITHUB_ACCOUNT}/${GITHUB_REPO}/packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}
    printf "          Created /packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}\n"

    DIRECTORY='Controllers'
    mkdir -p ${GITHUB_LOCAL_PATH}/${GITHUB_ACCOUNT}/${GITHUB_REPO}/packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}
    printf "          Created /packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}\n"

    DIRECTORY='Controllers/Api'
    mkdir -p ${GITHUB_LOCAL_PATH}/${GITHUB_ACCOUNT}/${GITHUB_REPO}/packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}
    printf "          Created /packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}\n"

    DIRECTORY='Controllers/Web'
    mkdir -p ${GITHUB_LOCAL_PATH}/${GITHUB_ACCOUNT}/${GITHUB_REPO}/packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}
    printf "          Created /packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}\n"

    DIRECTORY='Migrations'
    mkdir -p ${GITHUB_LOCAL_PATH}/${GITHUB_ACCOUNT}/${GITHUB_REPO}/packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}
    printf "          Created /packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}\n"

    DIRECTORY='Models'
    mkdir -p ${GITHUB_LOCAL_PATH}/${GITHUB_ACCOUNT}/${GITHUB_REPO}/packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}
    printf "          Created /packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}\n"

    DIRECTORY='Providers'
    mkdir -p ${GITHUB_LOCAL_PATH}/${GITHUB_ACCOUNT}/${GITHUB_REPO}/packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}
    printf "          Created /packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}\n"

    DIRECTORY='Repository'
    mkdir -p ${GITHUB_LOCAL_PATH}/${GITHUB_ACCOUNT}/${GITHUB_REPO}/packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}
    printf "          Created /packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}\n"

    DIRECTORY='Views'
    mkdir -p ${GITHUB_LOCAL_PATH}/${GITHUB_ACCOUNT}/${GITHUB_REPO}/packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}
    printf "          Created /packages/${PACKAGE_VENDOR}/${PACKAGE_NAME}/${DIRECTORY}\n"

    printf "\n        ${C_LIGHTGREEN}Package created. May the force be with you!${C_DEFAULT}\n"
    printf "\n"

fi

