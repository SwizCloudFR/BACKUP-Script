#!/bin/bash
UUID=$(dbus-uuidgen)
SPACESDIRECTORY=/database
host=localhost
database=YOUR DATABASE NAME
user=YOUR DATABASE USER
password=YOUR DATABASE PASSWORD
echo "Save Unique ID: ${UUID}"

if [ ! -d "/home/database" ];then
echo -ne  "No Directory, Creation in progress..."
mkdir /home/database
echo -ne "Created.\r"
fi
echo -ne "Dump Database.\r"
sudo mysqldump --user=${user} --password=${password} --host=${host} ${database} --result-file=/home/database/dump-${UUID}-$(date +%F-%H)h.sql 2>&1
echo -ne 'Dump Database #####                     (33%)\r'
sleep 1
echo -ne 'Dump Database #############             (66%)\r'
sleep 1
echo -ne 'Dump Database #######################   (100%)\r'
echo -ne '\n'
echo -ne "Send to DigitalOcean Spaces.\r"
rclone copy /home/database/dump-${UUID}-$(date +%F-%H)h.sql YOUR_CONF_NAME:YOUR_NAME_SPACES${SPACESDIRECTORY} --log-file=/var/log/rclone.log
echo -ne 'Send to DigitalOcean Spaces. #####                     (33%)\r'
sleep 1
echo -ne 'Send to DigitalOcean Spaces. #############             (66%)\r'
sleep 1
echo -ne 'Send to DigitalOcean Spaces. #######################   (100%)\r'
echo -ne '\n'
echo -ne "Backup successfully completed.\n"
