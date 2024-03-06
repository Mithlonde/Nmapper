<h2 class="menu-header" id="main">
<a href="https://github.com/Mithlonde/Mithlonde">Root</a>&#xA0;&#xA0;&#xA0;
<a href="https://github.com/Mithlonde/Mithlonde/blob/main/blog/index.md">Blog</a>&#xA0;&#xA0;&#xA0;
<a href="https://github.com/Mithlonde/Mithlonde/blob/main/projects/index.md">Projects</a>&#xA0;&#xA0;&#xA0;
<a href="https://github.com/Mithlonde/Mithlonde/blob/main/projects/index.md">~/Nmapper</a>&#xA0;&#xA0;&#xA0;
<a href="https://github.com/Mithlonde/Mithlonde/blob/main/all-writeups.md">Writeups</a>&#xA0;&#xA0;&#xA0;
</h2>

### Hi there 👋

# 👾 Mithlonde
└─$ cat projects/nmapper.md

## Nmapper
I created a script that automates my intial Nmap reconnaissance tasks by scanning for all open ports, then set an environment variable named `ports` to scan all services on all open ports found.

-   **-p-**: scan all ports
-   **--min-rate**: set high scanning rate
-   **-sC**: run default nmap scripts
-   **-sV**: detect service version
-   **-oN**: write output to nmap file

**Nmapper PoC example screenshot**:
![nmapper1](https://github.com/Mithlonde/Nmapper/assets/88001670/05adc8a7-aefa-406d-b4de-d399cfccbb2e)

**Nmapper will automatically add `-Pn` option if required**:
![nmapper2](https://github.com/Mithlonde/Nmapper/assets/88001670/58f5de93-45dc-40db-94a7-7edd764963ed)

## Usage
**IMPORTANT NOTE**: Before running this script, set the $IP environment variable to the IP address of the target (`export IP=10.10.10.10`) and create a folder named 'scans' (`mkdir scans`). Or use [FileForge](https://github.com/Mithlonde/FileForge).

Also, for ease of use, you may want to add the following to your aliases:
alias nmapper='/path/to/nmapper.zsh'
