#!/bin/bash

scp check_p.sh test.txt roman@192.168.1.101:/home/roman/

host="192.168.1.101"
echo $host
ssh $host <<END
 cd /home/roman
 ls -l

 crontab -l > mycron
 echo "01 00 * * 1-5 bash /home/roman/check_port.sh" >> mycron
 crontab mycron
 rm mycron
 
 exit
END