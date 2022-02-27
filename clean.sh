#!/bin/bash

#	This is a very simple script that removes some querries from the pihole querry every time this was executed.
#	This removes them in both the long term querry log, the 24-hour log and the recent 100 querries.

# Check user root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root. (Did you forgot sudo?)"
  exit 1
fi

rmQuery () {
        sqlite3 /etc/pihole/pihole-FTL.db "delete from query_storage where domain in (select id from domain_by_id where domain like '$1');"
}

echo Script Started at $(date)
echo 'Both code should be a 0. If not there is a problem.'
# Stops FTL, So that we are not writing to a live database.
systemctl stop pihole-FTL
echo stop code = $?
cd /etc/pihole
# Starts removing querries.

# Remove whatever ends with "in-addr.arpa"
rmQuery '%in-addr.arpa'

# Remove whatever contains "ip6.arpa"
rmQuery '%ip6.arpa%'

# Remove "empty"
rmQuery 'empty'

echo [✓] Part 1 ok.
# You may add Part 2 here.

# Restart FTL
systemctl restart pihole-FTL
echo restart code = $?
echo [✓] Done.
echo Script Ended at $(date)
