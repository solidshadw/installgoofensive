# InstallGoOffensive

A bash script for security professionals and penetration testers to automatically install the latest version of Go and a curated collection of offensive security tools written in Go.

## Overview

This script automates the installation of:
1. The latest version of Go (with architecture detection for both AMD64 and ARM64)
2. A comprehensive set of Go-based security tools commonly used in penetration testing and bug bounty hunting

## Supported Operating Systems

- Debian-based systems (Ubuntu, Kali Linux, etc.)
- Arch-based systems (Arch Linux, BlackArch, etc.)

## Prerequisites

The script will automatically install the necessary dependencies:
- For Debian-based systems: `build-essential`, `libpcap-dev`
- For Arch-based systems: `base-devel`

## Installation

1. Clone the repository:
```bash
git clone https://github.com/solidshadw/installgoofensive.git
cd installgoofensive
```

2. Make the script executable:
```bash
chmod +x install-tool.sh
```

3. Run the script:
```bash
./install-tool.sh
```

## Included Tools

| Tool | Description | Repository |
|------|-------------|------------|
| nuclei | Fast and customizable vulnerability scanner | [projectdiscovery/nuclei](https://github.com/projectdiscovery/nuclei) |
| subfinder | Subdomain discovery tool | [projectdiscovery/subfinder](https://github.com/projectdiscovery/subfinder) |
| naabu | Fast port scanner | [projectdiscovery/naabu](https://github.com/projectdiscovery/naabu) |
| gowitness | Web screenshot utility | [sensepost/gowitness](https://github.com/sensepost/gowitness) |
| httpx | HTTP toolkit for probing web servers | [projectdiscovery/httpx](https://github.com/projectdiscovery/httpx) |
| notify | Notification utility for workflows | [projectdiscovery/notify](https://github.com/projectdiscovery/notify) |
| assetfinder | Find domains and subdomains related to a given domain | [tomnomnom/assetfinder](https://github.com/tomnomnom/assetfinder) |
| waybackurls | Fetch URLs from the Wayback Machine | [tomnomnom/waybackurls](https://github.com/tomnomnom/waybackurls) |
| gf | Wrapper around grep for pattern matching | [tomnomnom/gf](https://github.com/tomnomnom/gf) |
| shortscan | Security scanner for cloud services | [bitquark/shortscan](https://github.com/bitquark/shortscan) |
| anew | Tool for adding lines to a file only if they don't already exist | [tomnomnom/anew](https://github.com/tomnomnom/anew) |
| simplehttpserver | Simple HTTP server | [projectdiscovery/simplehttpserver](https://github.com/projectdiscovery/simplehttpserver) |
| ffuf | Fast web fuzzer | [ffuf/ffuf](https://github.com/ffuf/ffuf) |
| amass | Network mapping of attack surfaces and external asset discovery | [owasp-amass/amass](https://github.com/owasp-amass/amass) |
| cloudrecon | Cloud infrastructure reconnaissance tool | [g0ldencybersec/CloudRecon](https://github.com/g0ldencybersec/CloudRecon) |
| gau | Get All URLs | [lc/gau](https://github.com/lc/gau) |
| gospider | Fast web spider | [jaeles-project/gospider](https://github.com/jaeles-project/gospider) |
| kerbrute | Kerberos bruteforce utility | [ropnop/kerbrute](https://github.com/ropnop/kerbrute) |
| aws-enumerator | AWS enumeration tool | [shabarkin/aws-enumerator](https://github.com/shabarkin/aws-enumerator) |
| gron | Make JSON greppable | [tomnomnom/gron](https://github.com/tomnomnom/gron) |
| qsreplace | Query string replacement utility | [tomnomnom/qsreplace](https://github.com/tomnomnom/qsreplace) |

## Features

- **Architecture Detection**: Automatically detects and installs the appropriate Go version for your system architecture (AMD64 or ARM64)
- **Path Management**: Adds Go to your PATH automatically
- **Tool Installation**: Installs tools to both `$HOME/go/bin` and `/usr/local/bin` for system-wide availability
- **Error Handling**: Provides clear feedback on which tools were successfully installed and which failed
- **Idempotent**: Can be run multiple times without duplicating installations

## Caveats and Troubleshooting

- **Shell Restart**: After installation, you may need to restart your shell or source your shell configuration file to use Go:
  ```bash
  source ~/.bashrc  # or ~/.zshrc if using zsh
  ```

- **Permission Issues**: If you encounter permission errors, ensure you have sudo privileges.

- **Tool-Specific Issues**:
  - Some tools may require additional configuration after installation
  - For amass, the script uses the `@master` version tag instead of `@latest` due to specific requirements

## Customization

You can easily add more tools to the script by adding additional `install_go_tool` lines with the appropriate parameters:

```bash
install_go_tool "tool_name" "github.com/author/repo" "binary_name"
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- All the authors of the included security tools
- The Go team for creating an excellent programming language
