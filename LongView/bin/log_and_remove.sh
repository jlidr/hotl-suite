#!/bin/bash
#
# log_and_remove 
#   Record the name of a file before deleting it
#
################################################################################
PATH=/usr/local/bin:/bin:$PATH
export PATH

umask 0000
(
  echo "Deleting: $1" 
  rm -f $1
) 2>&1 | datelogin /radarplus/logs/remove_files.

exit 0


