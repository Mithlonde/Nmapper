<h2 class="menu-header" id="main">
<a href="https://github.com/Mithlonde/Mithlonde">Root</a>&#xA0;&#xA0;&#xA0;
<a href="https://github.com/Mithlonde/Mithlonde/blob/main/blog/index.md">Blog</a>&#xA0;&#xA0;&#xA0;
<a href="https://github.com/Mithlonde/Mithlonde/blob/main/projects/index.md">Projects</a>&#xA0;&#xA0;&#xA0;
<a href="https://github.com/Mithlonde/Mithlonde/blob/main/projects/index.md">~/Nmapper</a>&#xA0;&#xA0;&#xA0;
<a href="https://github.com/Mithlonde/Mithlonde/blob/main/all-writeups.md">Writeups</a>&#xA0;&#xA0;&#xA0;
</h2>

### Hi there 👋
└─$ cat projects/nmapper.md

## Nmapper
I created a script that automates my intial Nmap reconnaissance tasks by scanning for all open ports, then set an environment variable named `ports` to scan all services on all open ports found.

-   **-p-**: scan all ports
-   **--min-rate**: set high scanning rate
-   **-sC**: run default nmap scripts
-   **-sV**: detect service version
-   **-oN**: write output to nmap file

**Nmapper PoC example screenshot**:
[![image](https://raw.githubusercontent.com/Mithlonde/Mithlonde/main/thm/images/internal-3.png)

## Usage
**IMPORTANT NOTE**: Before running this script, set the $IP environment variable to the IP address of the target (`export IP=10.10.10.10`) and create a folder named 'scans' (`mkdir scans`). Or use [FileForge](https://github.com/Mithlonde/FileForge).

Also, for ease of use, you may want to add the following to your aliases:
alias nmapper='/path/to/nmapper.zsh'
alias nmapper2='/path/to/nmapper2.zsh'

## To-Do List
1. [ ] Edit nmapper so when -Pn is required, it will automatically run nmapper2.zsh
	Note to trigger in nmap scan:
	"Note: Host seems down. If it is really up, but blocking our ping probes, try -Pn"
2. [ ] Solve port order issue
	Currently, service scan writes port in incorrect order:
	"Method: nmap -p135,139,3389,445,8080 -sCV 192.168.219.43 -Pn -oN scans/services.nmap"
