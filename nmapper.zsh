#!/usr/bin/env zsh
#
# Version:              2.1
# Nmapper Author:     	Mithlonde
# Creation Date:        06/03/2024
# Website:              https://github.com/Mithlonde/Nmapper
#
# Before running this script, set the $IP environment variable to the IP address of the target and create a folder named 'scans'.

# Define color and formatting variables
C=$(printf '\033')
WHITE="${C}[1;37m"
YELLOW="${C}[1;33m"
RED="${C}[1;31m"
BLUE="${C}[1;96m"
NC="${C}[0m" # Neutral Color

CWD=$(echo "$PWD" | sed "s|^$HOME|~|")
echo_command="${RED}$(whoami)@$(hostname)${NC}:${WHITE}${CWD}${NC}\$"

function nmapper {

	echo ""
	echo "    ▄   █▀▄▀█ ██   █ ▄▄  █ ▄▄  ▄███▄   █▄▄▄▄ "
	echo "     █  █ █ █ █ █  █   █ █   █ █▀   ▀  █  ▄▀ "
	echo " ██   █ █ ▄ █ █▄▄█ █▀▀▀  █▀▀▀  ██▄▄    █▀▀▌  "
	echo " █ █  █ █   █ █  █ █     █     █▄   ▄▀ █  █  "
	echo " █  █ █    █     █  █     █    ▀███▀     █   "
	echo " █   ██   ▀     █    ▀     ▀            ▀    "
	echo "               ▀                             "
	echo "       Network Reconnaissance Automator      "
	echo "                by Mithlonde                 "
	echo ""

    # Define the Nmap command as a string variable
    port_scan="nmap -p- --min-rate 10000 $IP -oN scans/all-ports.nmap"
	udp_scan="sudo nmap -p161,162 -sUCV $IP -oN scans/snmp.nmap"
	full_scan="nmap -sCV $IP -oN scans/full-scan.nmap"

    # Execute a ping scan to check host availability
    ping_check=$(nmap -sn --min-rate 10000 $IP)

    # Check if the ping scan output contains the indication that the host seems down
    if echo "$ping_check" | grep -q "Note: Host seems down"; then
        # Add the -Pn option to the Nmap command if the host seems down
		echo "${YELLOW}[+] ${WHITE}Checking if host is up...${NC}"
		echo -e "$echo_command ${BLUE}nmap -sn --min-rate 10000 $IP${NC}" 
		echo "Note: Host seems down. If it is really up, but blocking our ping probes, try -Pn"
		echo "${YELLOW}Adding -Pn option to nmap commands...${NC}"
		echo ""
        port_scan+=" -Pn"
    fi

    # Running addiotional scans
	echo "${YELLOW}[+] ${WHITE}Scanning for all open ports...${NC}"
    echo "$echo_command ${BLUE}$port_scan${NC}"
	eval "$port_scan"
	echo ""
	echo "Output saved to scans/all-ports.nmap"

	# Extract ports and assign them to the $ports variable
    ports=$(cat scans/all-ports.nmap | grep "open" | grep -v "filtered" | cut -d "/" -f 1 | sort -nu | xargs | tr ' ' ',')
	num_ports=$(echo "$ports" | tr ',' '\n' | wc -l)
	services_scan="nmap -p$ports -sCV $IP -oN scans/services.nmap"
	echo "${YELLOW}Done. Found $num_ports open port(s)${NC}"
	echo ""

    # If host is down, add -Pn option to services_scan command
    if echo "$ping_check" | grep -q "Note: Host seems down"; then
        services_scan+=" -Pn"
		udp_scan+=" -Pn"
		full_scan+=" -Pn"
    fi

	echo "${YELLOW}[+] ${WHITE}Scanning services on all open ports...${NC}"
	echo "$echo_command ${BLUE}$services_scan${NC}"
	eval "$services_scan"
	echo ""
	echo "Output saved to scans/all-services.nmap"

	echo ""
	echo "${YELLOW}[+] ${WHITE}Additional scans you can try:${NC}"
	echo "${YELLOW}[!] Optional: ${NC}Scanning UDP SNMP on port 161,162${NC}"
	echo "${NC}Command: ${BLUE}$udp_scan${NC}"

	echo "${YELLOW}[!] Optional: ${NC}Run a another full scan in the background if preferred${NC}"
	echo "${NC}Command: ${BLUE}$full_scan${NC}"
	echo ""
    echo -e "${YELLOW}Happy hunting!${NC}"
}

nmapper
