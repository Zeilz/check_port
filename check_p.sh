#!/bin/bash

while IFS= read -r line; do
    IFS=':' read -ra ip_port <<< $line
    echo ip - ${ip_port[0]} port - ${ip_port[1]}   
    result=$(nc -zv -w3 ${ip_port[0]} ${ip_port[1]} 2>&1 | grep succeeded) 
    if ["$result" = ""]; then
        echo port ${ip_port[1]} is closed on ${ip_port[0]}
        curl -X POST -H "Content-Type: application/json" -d '{"failed": "${ip_port[0]}:${ip_port[1]}",}' https://example/contact
    else
        echo port ${ip_port[1]} is open on ${ip_port[0]}
    fi
done < test.txt
