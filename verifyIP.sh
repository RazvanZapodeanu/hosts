#!/bin/bash
verify_dns_association() {
    host_name=$1
    ip_address=$2
    dns_server=$3

    resolved_ip=$(dig +short "$host_name" @"$dns_server")
    if [ "$resolved_ip" == "$ip_address" ]; then
        echo "The IP $ip_address is correctly associated with $host_name."
    else
        echo "The IP $ip_address is not correctly associated with $host_name."
    fi
}

while read line; do
    host=$(echo $line | awk '{print $2}')
    ip=$(echo $line | awk '{print $1}')

    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        verify_dns_association $host $ip "8.8.8.8"
    fi
done < /etc/hosts

