# Rm-Pihole-querry (BETA)
Removed unwanted queries every time this script was executed

This is a very simple script that removes some querries from the pihole query every time this was executed. This may help in improving the statics and removes those unwanted querries.

The devs suggest not using it because it would permantly remove some stats that *might* be useful for debugging. Check out [this reddit post](https://www.reddit.com/r/pihole/comments/kacbjl/a_simple_script_to_remove_unwanted_queries_from/) where I post this repo to r/pihole

This removes them in both the long term query log, the 24-hour log and the recent 100 queries.
You may add this to the crontab and execute it every hour or so. Not suggest running it too often, as it needs to restart the pihole service.


## How to install
Create a folder in any place you want. For this, I would be creating it in /etc and naming it pihole_assist. (/etc/pihole_assist)  
Create a file `clean.sh` inside the folder (/etc/pihole_assist/clean.sh) and copy the content of `clean.sh` of this repo and paste it on the `clean.sh` on your local machine.  
Go to the folder you storted `clean.sh` (`cd /etc/pihole_assist`) and use `chmod +x clean.sh` in the terminal (Ctrl+Alt+T) to make it executable.  
Try to execute it by typing `sudo ./clean.sh`.  
You should see something like this (replace test.sh with clean.sh, I was just testing):
![Sample Output](https://github.com/SodaWithoutSparkles/Rm-Pihole-querry/blob/main/sample%20output/Pihole_assist_sample_output.png?raw=true)
Now querries ends with "in-addr.arpa", contains "ip6.arpa", and "empty" should be deleted. Go to the script to add/remove lines to remove your desired querries.  

# Crontab
You may add a crontab to execute this automatically.  
Type `sudo nano crontab -e` to edit.  
In the crontab, move the cursor by using the arrow keys. Move to the last lines and add this line:  
`15 0-5,9,13,17,21 * * * /etc/pihole_assist/clean.sh`  
Sample Crontab (The line pointed by the Red Arrow):  
![Sample Crontab](https://github.com/SodaWithoutSparkles/Rm-Pihole-querry/blob/main/sample%20output/Crontab.png?raw=true)  
This would run the script on 00:15, 01:15, 02:15, 03:15, 04:15, 05:15, 09:15, 13:15, 17:15, 21:15 every day.  
You may use this if you want to monitor the output of the script to track if it worked properly:  
`15 0-5,9,13,17,21 * * * /etc/pihole_assist/clean.sh > /home/pi/clean.log 2>&1`  
This would make a file called `clean.log` in `/hole/pi`.  

