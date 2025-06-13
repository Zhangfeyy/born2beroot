# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fzhang <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/10 18:30:29 by fzhang            #+#    #+#              #
#    Updated: 2025/06/10 18:30:34 by fzhang           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

architecture=$(uname -a)
echo "#Architecture: $architecture"
physical_p=$(lscpu | grep "Socket(s):" | awk '{print $2}')
echo "Physical CPUs: $physical_p"
virtual_p=$(lscpu | grep "CPU(s)" | head -n 1 | awk '{print $2}')
echo "Virtual CPUs: $virtual_p"
ram_used=$(free -m | grep "Mem" | awk '{print $3}' )
ram_ttl=$(free -m | grep "Mem" | awk '{print $2}' )
ram_usage=$(echo "scale=2; $ram_used * 100 / $ram_ttl" | bc )
#echo here is for bc, because it reads from stdin
echo "Memory Usage: $ram_used/($ram_ttl)MB($ram_usage%)"
storage_used=$(df -BG --total | grep "total" | awk '{print $3}')
storage_ttl=$(df -BG --total | grep "total" | awk '{print $4}')
storage_percentage=$(df -BG --total | grep "total" | awk '{print $5}')
echo "Disk Usage: $storage_used/($storage_ttl)GB($storage_percentage)"
cpu_uti=$(top -b -n1 | grep "%Cpu(s)" | awk -F'ni,' '{print $2}' | awk -F'id,' '{print $1}')
cpu_percentage=$(echo "scale=1; 100 - $cpu_uti" | bc)
echo "CPU load: $cpu_percentage%"
reboot=$(who -b | awk '{print $3,$4}')
echo "reboot: $reboot"
lvm="No"
if lsblk | grep -w "lvm" > /dev/null ; then
	lvm="Yes"
fi
echo "LVM Use: $lvm"
net_con=$#Connections TCP : 1 ESTABLISHED