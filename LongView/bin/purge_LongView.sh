#!/bin/bash
#
# Script to be run from cron to clean out old data files from the /longview tree.
# 
###############################################################################
PATH=/usr/local/bin:/bin:$PATH
export PATH
umask 0000

cd /tmp

echo "$0 looking for files to clean up... " | datelogin /longview/logs/remove_files.

# Cleanup files in /longview/ excluding "special" directories
if [ -d /longview ]
then
     find /longview -type f -not -path "/longview/logs/*" -not -path "/longview/etc/*" -mtime +3 -exec /usr/local/bin/log_and_remove.sh {} \;
fi

# Files in Pub are owned by LDM.
if [ -d /longview/Pub ]
then
     find /longview/Pub -type f -mmin +1440 -exec /usr/local/bin/log_and_remove.sh {} \;
fi

# Purge dated log files
deloldfiles 7d  /longview/logs/*.??????

exit 0
