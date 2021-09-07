#!/bin/bash
timestamp()
{
 date +"%Y-%m-%d %T"
}


a=$(/bin/netstat -tulpn | awk '{print $7}' |  grep polkadot | wc -l )
if test $a = "0"
then
 echo "$(timestamp): Polkadot Validator Down" >> /var/log/polkamonitor.log
 /usr/local/bin/polkadot --name $POLKADOT_NAME --validator --key $POLKADOT_KEY --base-path /data &>> /var/log/polkamonitor.log
fi

# Every Minute a check, add the following cron-job
# * * * * *   /root/restartSubstrate.sh  > /dev/null 2>&1
# crontab -e
# grep cron /var/log/syslog

# https://tutorialinux.com/securing-ssh-with-sshguard/
# https://andschwa.com/post/configuring-sshguard-on-ubuntu-server/
#  service sshguard restart
