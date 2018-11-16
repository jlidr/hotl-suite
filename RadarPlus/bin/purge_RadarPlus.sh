#!/bin/bash
#
# Script to be run from cron to clean out old data files from the /radarplus tree.
# 
###############################################################################
PATH=/usr/local/bin:/bin:$PATH
export PATH
umask 0000

cd /tmp

echo "$0 looking for files to clean up... " | datelogin /radarplus/logs/remove_files.

# Cleanup files in /radarplus/ excluding "special" directories
if [ -d /radarplus ]
then
     find /radarplus -type f -not -path "/radarplus/logs/*" -not -path "/radarplus/etc/*" -mtime +3 -exec /usr/local/bin/log_and_remove.sh {} \;
fi

# Files in backup and Pub are owned by LDM. (15 minutely)
if [ -d /radarplus/noQC ]
then
     find /radarplus/noQC -type f -mmin 15 -exec /usr/local/bin/log_and_remove.sh {} \;
fi

if [ -d /radarplus/backup ]
then
     find /radarplus/backup -type f -mmin +300 -exec /usr/local/bin/log_and_remove.sh {} \;
fi

if [ -d /radarplus/Pub ]
then
     #  Leave the files around for 4 days in case globalRadarQC needs to debug something.
     find /radarplus/Pub -type f -mmin +5760 -exec /usr/local/bin/log_and_remove.sh {} \;
fi

# Files and directories in noQC/Image are owned by wsi_svc
if [ -d /radarplus/noQC/Image/ ]
then
     find /radarplus/noQC/Image/* -type d -mmin +120 -empty -delete
fi

# Purge dated log files
deloldfiles 7d  /radarplus/logs/*.??????

exit 0
