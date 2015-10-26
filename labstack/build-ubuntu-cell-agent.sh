#!/bin/bash

# Include config file with your environment variables
source config.sh

# ---------------------------------------------------------
#
# Pre-Requisite Build Instructions for Virtual Machine
#
# Use ubuntu-14.04.3-server-amd64.iso
#
# Disk Size: 1,000GB (1 TB) Thin Provision
# Network Adapters: Add 2 NICs (Total 3 NICs)
# Disconnect First 2 NICs, set 3rd NIC to v2000
#
# If using VMware Fusion, add new custom network
# [X] Allow virtual machines to ... NAT
# [X] Connect the host MAC to this network
# [X] Provide ... DHCP
# Subnet IP: 10.200.0.0
# Subnet Mask: 255.255.0.0
#
# Ubuntu ISO Installation Steps
# ------------------------------
#
# Language: English
# <action> Install Ubuntu Server
#
# Language: English English
# Select a Location: United States
# Detect keyboard layout: No
# Country of Origin: English (US)
# Keyboard Layout: English (US)
# Hostname: ubuntu (default)
# Full Name for the new user: 'Labstack Administrator'
# Username for your account: 'labstack'
# Password: L@bStack!
# Encrypt your home directory: No
# Timezone: America/Los_Angeles
# Partitioning: Guided - use entire disk and set up LVM
# Disk to Partition: (default)
# Amount of Volume Group to Use: (default)
# Automatic Updates: No Automatic Updates
#
# Software to Install:
# + OpenSSH server
#
# GRUB Boot loader: Yes
#
#
# First Boot
# ------------------------------
# ubuntu login: labstack
# Password: L@bStack!
#
# ~$ sudo passwd root
# [sudo] Password for labstack: L@bStack!
# New Password: L@bStack!
# Confirm: L@bStack!
#
# ~$ logout
#
# ubuntu login: root
# Password: L@bStack!
#
# ~# ping google.com
#
# ~# halt
#
# Create Snapshot of Powered off VM
# ---------------------------------------------------------

# Define Variables for Syntax Highlighting Colors
COLOR_DEFAULT='\033[m'
COLOR_WHITE='\033[1m'
COLOR_BLACK='\033[30m'
COLOR_RED='\033[31m'
COLOR_GREEN='\033[32m'
COLOR_YELLOW='\033[33m'
COLOR_BLUE='\033[34m'
COLOR_PURPLE='\033[35m'
COLOR_CYAN='\033[36m'
COLOR_LIGHTGRAY='\033[37m'
COLOR_DARKGRAY='\033[1;30m'
COLOR_LIGHTRED='\033[1;31m'
COLOR_LIGHTGREEN='\033[1;32m'
COLOR_LIGHTYELLOW='\033[1;33m'
COLOR_LIGHTBLUE='\033[1;34m'
COLOR_LIGHTPURPLE='\033[1;35m'
COLOR_LIGHTCYAN='\033[1;36m'

#
# Check if the bash shell script is being run by root
#

if [[ $EUID -ne 0 ]]; then

    printf "\n${COLOR_CYAN}"
    printf "                                     /~\                           \n"
    printf "                                    |o o)      Ouch! Pay attention to what you're doing!\n"
    printf "                                    _\=/_                          \n"
    printf "                    ___        #   /  _  \   #                     \n"
    printf "                   /() \        \\//|/.\|\\//                      \n"
    printf "                 _|_____|_       \/  \_/  \/                       \n"
    printf "                | | === | |         |\ /|                          \n"
    printf "                |_|  O  |_|-----<   \_ _/                          \n"
    printf "                 ||  O  ||          | | |                          \n"
    printf "                 ||__*__||          | | |                          \n"
    printf "                |~ \___/ ~|         []|[]                          \n"
    printf "                /=\ /=\ /=\         | | |                          \n"
    printf "________________[_]_[_]_[_]________/_]_[_\_________________________\n"
    printf "${COLOR_CYAN}"
    printf "\n"
    printf "${COLOR_LIGHTRED}This script must be run as root.${COLOR_DEFAULT}\n"
    printf "\n"
    exit 1
fi

#
# Output - Script Header
#

printf "\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "\n"
printf "   ${COLOR_PURPLE}${SCRIPT_TITLE}${COLOR_DEFAULT}\n"
printf "   \n"
printf "   ${COLOR_PURPLE}${COLOR_DEFAULT}@package${COLOR_PURPLE} jeffersonmartin/pink-scripts/${SCRIPT_DIR}/${SCRIPT_FILE}${COLOR_DEFAULT}\n"
printf "   ${COLOR_PURPLE}${COLOR_DEFAULT}@author${COLOR_PURPLE}  github.com/jeffersonmartin${COLOR_DEFAULT}\n"
printf "\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "\n${COLOR_DEFAULT}"

printf "   ${COLOR_DARKGRAY}This script will deploy the following Labstack services:${COLOR_DEFAULT}\n"
printf "   ${COLOR_DARKGRAY}Labstack Administration: Admin UI, Job Controller${COLOR_DEFAULT}\n"
printf "   ${COLOR_DARKGRAY}Cell Services: Router, Web Server, Database, File Server, DHCP, DNS${COLOR_DEFAULT}\n"
printf "\n"

#
# Output - Confirmation of Variables
#

printf "   ${COLOR_DEFAULT}defining variables from ${COLOR_PURPLE}config.sh${COLOR_DEFAULT}. does this look correct?${COLOR_DEFAULT}\n"
printf "   ${COLOR_DEFAULT}cell #:    ${COLOR_PURPLE}${ENV_CELL_NUMBER}\n"
printf "   ${COLOR_DEFAULT}rack #s:   ${COLOR_PURPLE}"

# Loop through incrementing rack numbers with leading cell number
for ((i=1; i<=${ENV_RACK_COUNT}; i++)); do
   printf "${ENV_CELL_NUMBER}$i "
done

printf "${COLOR_DEFAULT}\n\n"

printf "   ${COLOR_LIGHTRED}press CTRL+C to abort the mission within 10 seconds${COLOR_DEFAULT}\n"

# Perform a 10 second countdown
    printf "   "
    sleep 1
    printf "10..."
    sleep 1
    printf "9..."
    sleep 1
    printf "8..."
    sleep 1
    printf "7..."
    sleep 1
    printf "6..."
    sleep 1
    printf "5..."
    sleep 1
    printf "4..."
    sleep 1
    printf "3..."
    sleep 1
    printf "2..."
    sleep 1
    printf "1... \n\n"
    sleep 1

printf "   ${COLOR_GREEN}in the words of Lando Calrissian, here goes nothing!${COLOR_DEFAULT}\n\n"

printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "\n"

#
#
# Configure Hostname
#
#

    # Local File Copy: Hostname configuration
#    cp templates/etc/hostname /etc/hostname
    printf "${COLOR_DARKGRAY}/etc/hostname${COLOR_DEFAULT}\n"

    # Find and replace {ENV_CELL_NUMBER} in configuration template
#    sed -i s/{ENV_CELL_NUMBER}/${ENV_CELL_NUMBER}/g /etc/hostname
    printf "${COLOR_DEFAULT}hostname set as ${COLOR_PURPLE}cell${ENV_CELL_NUMBER}-agent${COLOR_DEFAULT}\n"
    printf "${COLOR_GREEN}hostname configured${COLOR_DEFAULT}\n"
    printf "\n"

#
#
# Configure Network Interfaces
#
#

    printf "${COLOR_DARKGRAY}/etc/network/interfaces${COLOR_DEFAULT}\n"

    # Local File Copy: Network interface configuration
#    cp templates/etc/network/interfaces /etc/network/interfaces

    # Find and replace {ENV_CELL_NUMBER} in configuration template
#    sed -i s/{ENV_CELL_NUMBER}/${ENV_CELL_NUMBER}/g /etc/network/interfaces

    printf "${COLOR_DEFAULT}eth0 configured for ${COLOR_PURPLE}v1000_OOB${COLOR_DEFAULT}\n"
    printf "   ip address       ${COLOR_PURPLE}10.100.${ENV_CELL_NUMBER}0.1 /16${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}interface down${COLOR_DEFAULT}"
#    ifdown eth0
#    ifup eth0
    printf "${COLOR_DEFAULT}...up${COLOR_DEFAULT}\n"

    printf "${COLOR_DEFAULT}eth1 configured for ${COLOR_PURPLE}v1${ENV_CELL_NUMBER}00_CELL${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}ip address       ${COLOR_PURPLE}10.1${ENV_CELL_NUMBER}0.0.1 /16${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}dns server       ${COLOR_PURPLE}10.1${ENV_CELL_NUMBER}0.0.1${COLOR_DEFAULT} (cell${ENV_CELL_NUMBER}-agent)${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}dns domain       ${COLOR_PURPLE}cell${ENV_CELL_NUMBER}.labstack.local${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}interface down${COLOR_DEFAULT}"
#    ifdown eth1
#    ifup eth1
    printf "${COLOR_DEFAULT}...up${COLOR_DEFAULT}\n"

    printf "${COLOR_DEFAULT}eth2 configured for ${COLOR_PURPLE}v2000_WEB${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}ip address       ${COLOR_PURPLE}10.200.${ENV_CELL_NUMBER}0.1 /16${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}dns server       ${COLOR_PURPLE}8.8.8.8${COLOR_DEFAULT} (google)${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}dns server       ${COLOR_PURPLE}208.67.222.222${COLOR_DEFAULT} (opendns)${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}interface down${COLOR_DEFAULT}"
#    ifdown eth2
#    ifup eth2
    printf "${COLOR_DEFAULT}...up${COLOR_DEFAULT}\n"

    printf "${COLOR_GREEN}network interfaces configured${COLOR_DEFAULT}\n"
    printf "\n"

#
#
# Configure IP Forwarding for Basic Routing
#
#

    # Uncomment IP Forwarding
    printf "${COLOR_DARKGRAY}/etc/sysctl.conf${COLOR_DEFAULT}\n"
#    sed -i s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g /etc/sysctl.conf
    printf "${COLOR_GREEN}ip forwarding (routing) enabled${COLOR_DEFAULT}\n"
    printf "\n"

#
#
# Aptitude Packages
#
#

    printf "\n"
    printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
    printf "${COLOR_PURPLE}   aptitude packages${COLOR_DEFAULT}\n"
    printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
    printf "\n${COLOR_DEFAULT}"

#
#
# Update apt-get repositories
#
#

    printf "${COLOR_DARKGRAY}apt-get update${COLOR_DEFAULT}\n"
#    apt-get update
    printf "${COLOR_GREEN}aptitude repositories updated${COLOR_DEFAULT}\n"
    printf "\n"

#
#
# Upgrade existing aptitude packages
#
#

    printf "${COLOR_DARKGRAY}apt-get upgrade${COLOR_DEFAULT}\n"
#    apt-get -y upgrade
    printf "${COLOR_GREEN}existing aptitude packages upgraded${COLOR_DEFAULT}\n"
    printf "\n"

#
#
# Install new aptitude packages
#
#

    PackageList=(

        # System Administration
        "open-vm-tools"
        "htop"
        "expect"

        # Package Management
        "git"

        # Web Server
        "apache2"
        "php5"
        "php5-mysql"
        "php5-mcrypt"
        "mysql-client"
        "mysql-server"

        # File Server
        "samba"

        # DHCP
        "isc-dhcp-server"

        # DNS
        "bind9"

    )

    # Pre-set variables for MySQL root password prompt
#    debconf-set-selections <<< 'mysql-server mysql-server/root_password password L@bStack!'
#    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password L@bStack!'

    # Loop through package names for installation
    for Package in "${PackageList[@]}"
    do
        printf "${COLOR_DARKGRAY}apt-get install ${Package}${COLOR_DEFAULT}\n"
    #    apt-get -y install ${Package}
        printf "${COLOR_GREEN}${Package} package and dependencies installed${COLOR_DEFAULT}\n"
        printf "\n"
    done

#
#
# Apache2 & PHP
#
#

    printf "\n"
    printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
    printf "${COLOR_PURPLE}   apache2 & php configuration${COLOR_DEFAULT}\n"
    printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
    printf "\n${COLOR_DEFAULT}"

    printf "${COLOR_DARKGRAY}/etc/apache2/mod-available${COLOR_DEFAULT}\n"

    # Enable alias module
#    a2enmod alias
    printf "${COLOR_DEFAULT}alias module enabled${COLOR_DEFAULT}\n"

    # Enable ldap module
#    a2enmod ldap
    printf "${COLOR_DEFAULT}ldap module enabled${COLOR_DEFAULT}\n"

    # Enable php5 module
#    a2enmod php5
    printf "${COLOR_DEFAULT}php5 module enabled${COLOR_DEFAULT}\n"

    # Enable rewrite module
#    a2enmod rewrite
    printf "${COLOR_DEFAULT}rewrite module enabled${COLOR_DEFAULT}\n"

    # Enable sed module
#    a2enmod sed
    printf "${COLOR_DEFAULT}sed module enabled${COLOR_DEFAULT}\n"

    # Enable ssl module
#    a2enmod ssl
    printf "${COLOR_DEFAULT}ssl module enabled${COLOR_DEFAULT}\n"

    # Enable vhost alias module
#    a2enmod vhost_alias
    printf "${COLOR_DEFAULT}vhost_alias module enabled${COLOR_DEFAULT}\n"

    printf "${COLOR_GREEN}apache modules enabled${COLOR_DEFAULT}\n"
    printf "\n"


    printf "${COLOR_DARKGRAY}creating directory structure${COLOR_DEFAULT}\n"
#    mkdir /srv/labstack/
    printf "${COLOR_DEFAULT}created /srv/labstack${COLOR_DEFAULT}\n"
#    mkdir /srv/labstack/apache
    printf "${COLOR_DEFAULT}created /srv/labstack/apache${COLOR_DEFAULT}\n"
#    mkdir /srv/labstack/apache/admin
    printf "${COLOR_DEFAULT}created /srv/labstack/apache/admin${COLOR_DEFAULT}\n"
#    mkdir /srv/labstack/apache/script
    printf "${COLOR_DEFAULT}created /srv/labstack/apache/script${COLOR_DEFAULT}\n"
#    mkdir /srv/labstack/ssl/
    printf "${COLOR_DEFAULT}created /srv/labstack/ssl${COLOR_DEFAULT}\n"
#    mkdir /srv/labstack/mysql
    printf "${COLOR_DEFAULT}created /srv/labstack/mysql${COLOR_DEFAULT}\n"
#    mkdir /srv/labstack/mysql/backup
    printf "${COLOR_DEFAULT}created /srv/labstack/mysql/backup${COLOR_DEFAULT}\n"
#    mkdir /srv/labstack/file/
    printf "${COLOR_DEFAULT}created /srv/labstack/file${COLOR_DEFAULT}\n"
#    mkdir /srv/labstack/file/public
    printf "${COLOR_DEFAULT}created /srv/labstack/file/public${COLOR_DEFAULT}\n"
#    mkdir /srv/labstack/file/private
    printf "${COLOR_DEFAULT}created /srv/labstack/file/private${COLOR_DEFAULT}\n"

    #@todo proper folder permissions

    # Verbose Footer
    printf "${COLOR_GREEN}labstack directories created${COLOR_DEFAULT}\n"
    printf "\n"



    # Verbose Header
    printf "${COLOR_DARKGRAY}/etc/apache2/sites-available/${COLOR_DEFAULT}\n"

    # Local File Copy: Apache Virtual Host Config for Labstack
#    cp templates/etc/apache2/sites-available/labstack.conf /etc/apache2/sites-available/labstack.conf
    printf "${COLOR_DEFAULT}created virtual host configuration file labstack.conf${COLOR_DEFAULT}\n"

    # Find and replace {ENV_CELL_NUMBER} in configuration template
#    sed -i s/{ENV_CELL_NUMBER}/${ENV_CELL_NUMBER}/g /etc/apache2/sites-enabled/labstack.conf
    printf "${COLOR_DEFAULT}virtual host config created for ${COLOR_PURPLE}http://admin.cell${ENV_CELL_NUMBER}.labstack.local${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}virtual host config created for ${COLOR_PURPLE}https://admin.cell${ENV_CELL_NUMBER}.labstack.local${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}virtual host config created for ${COLOR_PURPLE}http://file.cell${ENV_CELL_NUMBER}.labstack.local${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}virtual host config created for ${COLOR_PURPLE}http://script.cell${ENV_CELL_NUMBER}.labstack.local${COLOR_DEFAULT}\n"

    # Enable virtual host configuration file for ~/sites-enabled/
#    a2ensite labstack
    printf "${COLOR_DEFAULT}virtual host configuration enabled${COLOR_DEFAULT}\n"

    # Verbose Footer
    printf "${COLOR_GREEN}virtual hosts configured${COLOR_DEFAULT}\n"
    printf "\n"


    # Verbose Header
    printf "${COLOR_DARKGRAY}/srv/labstack/ssl/${COLOR_DEFAULT}\n"

    # Create directory for SSL keys
#    mkdir -p /srv/labstack/ssl
    printf "${COLOR_DEFAULT}directory created${COLOR_DEFAULT}\n"

    # Local File Copy: Apache SSL Certificates for Labstack
#    cp templates/etc/apache2/ssl/labstack-apache* /srv/labstack/ssl/
    printf "${COLOR_DEFAULT}copied pre-created self-signed certificate to directory${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}copied pre-created self-signed private key to directory${COLOR_DEFAULT}\n"

    # Verbose Footer
    printf "${COLOR_GREEN}self-signed ssl certificates created${COLOR_DEFAULT}\n"
    printf "\n"

#
#
# PHP Configuration
#
#

    #Verbose Header
    printf "${COLOR_DARKGRAY}/etc/php5/mod-available${COLOR_DEFAULT}\n"

    # Enable mcrypt
#    php5enmod mcrypt
    printf "${COLOR_DEFAULT}mcrypt module enabled${COLOR_DEFAULT}\n"

    # Enable mysql
#    php5enmod mysql
    printf "${COLOR_DEFAULT}mysql module enabled${COLOR_DEFAULT}\n"

    # Enable mysqli
#    php5enmod mysqli
    printf "${COLOR_DEFAULT}mysqli module enabled${COLOR_DEFAULT}\n"

    # Verbose Footer
    printf "${COLOR_GREEN}php modules enabled${COLOR_DEFAULT}\n"

    printf "\n"

    # Verbose Header
    printf "${COLOR_DARKGRAY}/etc/php5/apache2/php.ini${COLOR_DEFAULT}\n"

    # Enable PHP short tags
#    sed -i s/short_open_tag = Off/short_open_tag = On/g /etc/php5/apache2/php.ini
    printf "${COLOR_DEFAULT}short_open_tag set to on${COLOR_DEFAULT}\n"

    # Verbose Footer
    printf "${COLOR_GREEN}php configuration updated${COLOR_DEFAULT}\n"

    printf "\n"

    # Restart Apache Service
    printf "${COLOR_DARKGRAY}restarting apache2 service${COLOR_DEFAULT}\n"
#    service apache2 restart
    printf "${COLOR_GREEN}apache2 service restarted${COLOR_DEFAULT}\n"


printf "\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "${COLOR_PURPLE}   mysql configuration${COLOR_DEFAULT}\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "\n${COLOR_DEFAULT}"

#
# mysql secure installation
#
# @author github.com/coderua/mysql_secure.sh
#

    # Verbose Header
    printf "${COLOR_DARKGRAY}mysql_secure_installation${COLOR_DEFAULT}\n"

    # Define variable for mysql_secure_installation with expect parameters
    SECURE_MYSQL=$(expect -c "
    set timeout 3
    spawn mysql_secure_installation
    expect \"Enter current password for root (enter for none):\"
    send \"L@bStack!\r\"
    expect \"root password?\"
    send \"y\r\"
    expect \"New password:\"
    send \"L@bStack!\r\"
    expect \"Re-enter new password:\"
    send \"L@bStack!\r\"
    expect \"Remove anonymous users?\"
    send \"y\r\"
    expect \"Disallow root login remotely?\"
    send \"y\r\"
    expect \"Remove test database and access to it?\"
    send \"y\r\"
    expect \"Reload privilege tables now?\"
    send \"y\r\"
    expect eof
    ")

    # Execute mysql_secure_installation
#    echo "${SECURE_MYSQL}"
    printf "${COLOR_GREEN}mysql_secure_installation complete${COLOR_DEFAULT}\n"
    printf "\n"

#
# creating mysql databases and users
#

    # Verbose Header
    printf "${COLOR_DARKGRAY}creating mysql databases and users${COLOR_DEFAULT}\n"

    # Create labstack_db database table
    #@todo
    printf "${COLOR_DEFAULT}${COLOR_PURPLE}labstack_db${COLOR_DEFAULT} database created${COLOR_DEFAULT}\n"

    # Create labstack_admin database user
    #@todo
    printf "${COLOR_DEFAULT}${COLOR_PURPLE}labstack_admin${COLOR_DEFAULT} user created with password ${COLOR_PURPLE}L@bStack!${COLOR_DEFAULT}\n"

    # Grant user privileges for labstack table to labstack_admin
    #@todo
    printf "${COLOR_DEFAULT}labstack_admin user granted privileges to labstack_db table${COLOR_DEFAULT}\n"

    # Create labstack_apache database user
    #@todo
    printf "${COLOR_DEFAULT}labstack_apache user created${COLOR_DEFAULT}\n"

    # Grant user privileges for labstack table to labstack_apache
    #@todo
    printf "${COLOR_DEFAULT}labstack_apache user granted privileges to labstack_db table${COLOR_DEFAULT}\n"

    # Create labstack_cron database user
    #@todo
    printf "${COLOR_DEFAULT}labstack_cron user created${COLOR_DEFAULT}\n"

    # Grant user privileges for labstack table to labstack_cron
    #@todo
    printf "${COLOR_DEFAULT}labstack_cron user granted privileges to labstack_db table${COLOR_DEFAULT}\n"

    # Verbose Footer
    printf "${COLOR_GREEN}databases and users created${COLOR_DEFAULT}\n"
    printf "\n"

#
# creating scheduled backups
#

    # Verbose Header
    printf "${COLOR_DARKGRAY}creating scheduled backups${COLOR_DEFAULT}\n"

    # Local File Copy: MySQL Backup Script
#    cp templates/srv/labstack/mysql/mysql-backup-script.sh /srv/labstack/mysql/mysql-backup-script.sh
    printf "${COLOR_DEFAULT}backup script created${COLOR_DEFAULT}\n"

    # Set permissions on mysql backup script
#    chmod 777 /srv/labstack/mysql/mysql-backup-script.sh

    # Create nightly database backup job
#    crontab /srv/labstack/mysql/crontab-mysql-backup-nightly
    printf "${COLOR_DEFAULT}cron job scheduled for daily backup at 11:00pm (23:00 hrs)${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}backups are located in ${COLOR_PURPLE}/srv/labstack/mysql/backup/${COLOR_DEFAULT}\n"

    # Verbose Footer
    printf "${COLOR_GREEN}database backup scheduled${COLOR_DEFAULT}\n"
    printf "\n"

printf "\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "${COLOR_PURPLE}   samba file server configuration${COLOR_DEFAULT}\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "\n${COLOR_DEFAULT}"

    # Verbose Header
    printf "${COLOR_DARKGRAY}/etc/samba${COLOR_DEFAULT}\n"

    # Local File Copy: Samba Configuration
#    cp templates/etc/samba/smb.conf /etc/samba/smb.conf
    printf "${COLOR_DEFAULT}created new smb.conf configuration file${COLOR_DEFAULT}\n"
    printf "\n"
    printf "${COLOR_DEFAULT}created ${COLOR_PURPLE}public${COLOR_DEFAULT} fileshare${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}available via ${COLOR_PURPLE}"'\\\\'"file.cell${ENV_CELL_NUMBER}.labstack.local\public${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}available via ${COLOR_PURPLE}http://file.cell${ENV_CELL_NUMBER}.labstack.local${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}available via ${COLOR_PURPLE}[sftp] labstack:L@bStack!@file.cell${ENV_CELL_NUMBER}.labstack.local:/srv/labstack/file/public/${COLOR_DEFAULT}\n"
    printf "\n"
    printf "${COLOR_DEFAULT}created ${COLOR_PURPLE}private${COLOR_DEFAULT} cifs fileshare${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}available via ${COLOR_PURPLE}"'\\\\'"file.cell${ENV_CELL_NUMBER}.labstack.local\private${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}available via ${COLOR_PURPLE}http://file.cell${ENV_CELL_NUMBER}.labstack.local:8080${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}available via ${COLOR_PURPLE}[sftp] labstack:L@bStack!@file.cell${ENV_CELL_NUMBER}.labstack.local:/srv/labstack/file/private/${COLOR_DEFAULT}\n"
    printf "\n"
    printf "${COLOR_DEFAULT}created ${COLOR_PURPLE}users${COLOR_DEFAULT} cifs fileshare${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}available via ${COLOR_PURPLE}"'\\\\'"file.cell${ENV_CELL_NUMBER}.labstack.local\users${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}available via ${COLOR_PURPLE}[sftp] labstack:L@bStack!@file.cell${ENV_CELL_NUMBER}.labstack.local:/srv/labstack/file/users/${COLOR_DEFAULT}\n"
    printf "\n"
    printf "${COLOR_GREEN}samba configuration complete${COLOR_DEFAULT}\n"
    printf "\n"

    # Restart samba Service
    printf "${COLOR_DARKGRAY}restarting samba service${COLOR_DEFAULT}\n"
#    service samba restart
    printf "${COLOR_GREEN}samba service restarted${COLOR_DEFAULT}\n"


printf "\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "${COLOR_PURPLE}   dhcp server configuration${COLOR_DEFAULT}\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "\n${COLOR_DEFAULT}"

    # Verbose Header
    printf "${COLOR_DARKGRAY}/etc/dhcp${COLOR_DEFAULT}\n"

    # Local File Copy: DHCP Configuration
#    cp templates/etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf

    # Find and replace {ENV_CELL_NUMBER} in configuration template
#    sed -i s/{ENV_CELL_NUMBER}/${ENV_CELL_NUMBER}/g /etc/dhcp/dhcpd.conf
    printf "${COLOR_DEFAULT}created new dhcpd.conf configuration file${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}providing leases for ${COLOR_PURPLE}v1${ENV_CELL_NUMBER}00_CELL${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}starting ip       ${COLOR_PURPLE}10.1${ENV_CELL_NUMBER}0.211.2 /16${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}ending ip         ${COLOR_PURPLE}10.1${ENV_CELL_NUMBER}0.239.2 /16${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}dns servers       ${COLOR_PURPLE}10.1${ENV_CELL_NUMBER}0.0.1${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}                  ${COLOR_PURPLE}10.1${ENV_CELL_NUMBER}0.0.251${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}domain suffix     ${COLOR_PURPLE}cell${ENV_CELL_NUMBER}.labstack.local${COLOR_DEFAULT}\n"
    printf "   ${COLOR_DEFAULT}gateway           ${COLOR_PURPLE}10.1${ENV_CELL_NUMBER}0.0.1${COLOR_DEFAULT}\n"

    # Use shell script to generate DHCP reservations file
#    /etc/dhcp/generate_labstack_dhcp_reservations.sh <cell-number> > /etc/dhcp/labstack_dhcp_reservations.conf
    printf "${COLOR_DEFAULT}generated dhcp reservations file${COLOR_DEFAULT}\n"

    printf "${COLOR_GREEN}dhcp configuration complete${COLOR_DEFAULT}\n"
    printf "\n"

    # Restart dhcp Service
    printf "${COLOR_DARKGRAY}restarting dhcp service${COLOR_DEFAULT}\n"
#    service isc-dhcp-server restart
    printf "${COLOR_GREEN}dhcp service restarted${COLOR_DEFAULT}\n"


printf "\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "${COLOR_PURPLE}   dns server configuration${COLOR_DEFAULT}\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "\n${COLOR_DEFAULT}"

    # Verbose Header
    printf "${COLOR_DARKGRAY}/etc/bind${COLOR_DEFAULT}\n"

    # Local File Copy: DNS Bind Configuration
    #@todo

    # Find and replace {ENV_CELL_NUMBER} in configuration template
    #@todo

    printf "${COLOR_DEFAULT}@todo${COLOR_DEFAULT}\n"

    printf "${COLOR_GREEN}dns configuration complete${COLOR_DEFAULT}\n"
    printf "\n"

    # Restart dhcp Service
    printf "${COLOR_DARKGRAY}restarting dns service${COLOR_DEFAULT}\n"
    #@todo
    printf "${COLOR_GREEN}dns service restarted${COLOR_DEFAULT}\n"


printf "\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "${COLOR_PURPLE}   laravel configuration${COLOR_DEFAULT}\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "\n${COLOR_DEFAULT}"

    # Verbose Header
    printf "${COLOR_DARKGRAY}install php composer ${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}@todo${COLOR_DEFAULT}\n"
    printf "${COLOR_GREEN}complete${COLOR_DEFAULT}\n"
    printf "\n"

    # Verbose Header
    printf "${COLOR_DARKGRAY}git clone bridgedlabs/laravel${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}@todo${COLOR_DEFAULT}\n"
    printf "${COLOR_GREEN}complete${COLOR_DEFAULT}\n"
    printf "\n"

    # Verbose Header
    printf "${COLOR_DARKGRAY}add bridgedlabs/labstack-admin to composer file ${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}@todo${COLOR_DEFAULT}\n"
    printf "${COLOR_GREEN}complete${COLOR_DEFAULT}\n"
    printf "\n"

    # Verbose Header
    printf "${COLOR_DARKGRAY}compile laravel for https://admin.cell${ENV_CELL_NUMBER}.labstack.local ${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}@todo${COLOR_DEFAULT}\n"
    printf "${COLOR_GREEN}complete${COLOR_DEFAULT}\n"
    printf "\n"

    # Verbose Header
    printf "${COLOR_DARKGRAY}git clone bridgedlabs/lumen${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}@todo${COLOR_DEFAULT}\n"
    printf "${COLOR_GREEN}complete${COLOR_DEFAULT}\n"
    printf "\n"

    # Verbose Header
    printf "${COLOR_DARKGRAY}add bridgedlabs/labstack-script to composer file ${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}@todo${COLOR_DEFAULT}\n"
    printf "${COLOR_GREEN}complete${COLOR_DEFAULT}\n"
    printf "\n"

    # Verbose Header
    printf "${COLOR_DARKGRAY}compile lumen for http://script.cell${ENV_CELL_NUMBER}.labstack.local:8080 ${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}@todo${COLOR_DEFAULT}\n"
    printf "${COLOR_GREEN}complete${COLOR_DEFAULT}\n"
    printf "\n"

    # Verbose Header
    printf "${COLOR_DARKGRAY}build database using laravel migration ${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}@todo${COLOR_DEFAULT}\n"
    printf "${COLOR_GREEN}complete${COLOR_DEFAULT}\n"
    printf "\n"

    # Verbose Header
    printf "${COLOR_DEFAULT}You can use the web interface to configure your environment.${COLOR_DEFAULT}\n"
    printf "${COLOR_PURPLE}https://admin.cell${ENV_CELL_NUMBER}.labstack.local${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}Username: ${COLOR_PURPLE}admin${COLOR_DEFAULT}\n"
    printf "${COLOR_DEFAULT}Password: ${COLOR_PURPLE}labstack${COLOR_DEFAULT}\n"
    printf "\n"


printf "\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "${COLOR_PURPLE}   script complete${COLOR_DEFAULT}\n"
printf "${COLOR_PURPLE}   please reboot to complete the installation${COLOR_DEFAULT}\n"
printf "${COLOR_DARKGRAY}----------------------------------------------------------------------${COLOR_DEFAULT}\n"
printf "\n${COLOR_DEFAULT}"





