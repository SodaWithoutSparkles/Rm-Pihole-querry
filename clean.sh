#!/bin/sh

#####################################################################################################################
#																													#
#	This is a very simple script that removes some querries from the pihole querry every time this was executed.	#
#	This removes them in both the long term querry log, the 24-hour log and the recent 100 querries.				#
#																													#
#####################################################################################################################

# Prints the date every echo. Add a "#" before the following line to remove it.
alias echo='echo $(date)'
echo Script Started, both code should be a 0. If not there is a problem.
# Stops FTL, So that we are not writing to a live database.
systemctl stop pihole-FTL
echo stop code = $?
cd /etc/pihole
# Starts removing querries.

# Remove whatever ends with "in-addr.arpa"
sqlite3 pihole-FTL.db "delete from queries where domain like '%in-addr.arpa';"
# Remove whatever contains "ip6.arpa"
sqlite3 pihole-FTL.db "delete from queries where domain like '%ip6.arpa%';"
# Remove "empty"
sqlite3 pihole-FTL.db "delete from queries where domain like 'empty';"
echo [✓] Part 1 ok.
# You may add Part 2 here.

# Restart FTL
systemctl restart pihole-FTL
echo restart code = $?
echo [✓] Done.
echo Script Ended