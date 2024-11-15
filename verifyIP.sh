#!/bin/bash
verify_ip() {
    ip="$1"
    if ping -c 1 "$ip" &> /dev/null
    then
        echo "IP $ip is valid."
    else
        echo "IP $ip is not valid."
    fi
}

while read line; do
    ip=$(echo $line | awk '{print $1}')
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        verify_ip $ip
    fi
done < /etc/hosts
