#!/usr/bin/env zsh
#
# Version:              1.1
# Nmapper Author:     	Mithlonde
# Creation Date:        27/03/2023
# Website:              https://github.com/Mithlonde/Nmapper
#
# Before running this script, set the $IP environment variable to the IP address of the target and create a folder named 'scans'.

function nmapper {
	echo "==============================================================="
	echo "Nmapper - Initial Recon"
	echo "by Mithlonde"
	echo "==============================================================="
	echo "Scanning for all open ports"
	echo "[+] Method: nmap -p- --min-rate 10000 $IP -Pn -oN scans/all-ports.nmap"
	nmap -p- --min-rate 10000 $IP -Pn -oN scans/all-ports.nmap && ports=$(cat scans/all-ports.nmap | grep "open" | grep -v "filtered" | cut -d "/" -f 1 | sort -u | xargs | tr ' ' ',')
	echo "Setting environment variable for all open ports found"
	echo "==============================================================="
	echo "Scanning services on all open ports"
	echo "[+] Method: nmap -p$ports -sCV $IP -Pn -oN scans/services.nmap"
	nmap -p$ports -sCV $IP -Pn -oN scans/services.nmap
	echo "==============================================================="
	echo "OPTIONAL: Scanning UDP SNMP on port 161,162"
	echo "[+] Method: sudo nmap -p161,162 -sUCV -Pn $IP -oN scans/snmp.nmap"
	echo "==============================================================="
	echo "OPTIONAL: Run a full scan in the background if required:"
	echo "[+] Method: nmap -sCV $IP -Pn -oN scans/full-scan.nmap"
	echo "==============================================================="
	echo "3..2..1.."
	echo "Intel retrieved"
	echo ""
	echo "Happy hunting!"

}
	
nmapper
