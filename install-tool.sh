#!/bin/bash

echo ""
echo ""
echo "                    ' _ ._  _ , _ ._'"
echo "                    '(_  (   )_  .__)'"
echo "                  '( (  (    )   )  ) _)'"
echo "                 '(__ (_   (_ . _) _) ,__)'"
echo "                      ~~\ '' . /~~"
echo "                     ,::: ;   ; :::,"
echo "                    ':::::::::::::::'"
echo "_______________jgs______/_ __ \_______________________"
echo "|                                                      |"
echo "| Installing latest GO version and GO Offensive tools  |"
echo "|                                                      |"
echo "| Bash Script to bring your favorite go tools with you |"
echo "|______________________________________________________|"
echo ""
echo ""
echo ""

# Initialize arrays to store the names of tools that failed or succeeded in installing
failed_tools=()
successful_tools=()

# ANSI color codes
RED='\033[0;31m'  # Red color
NC='\033[0m'      # No color
GREEN='\033[0;32m' # Green color
BLUE='\033[0;34m'  # Blue color

# Function to install Go
install_go() {
    echo "---------------------------------------------------------------"
    echo "Installing Go..."
    if ! command -v /usr/local/go/bin/go &> /dev/null; then
        wget https://go.dev/dl/$(curl -s https://go.dev/dl/ | grep -o 'go[0-9]*\.[0-9]*\.[0-9]*\.linux-amd64\.tar\.gz' | head -n 1) >/dev/null 2>&1
        sudo tar -C /usr/local -xzf go*.linux-amd64.tar.gz
        rm go*.linux-amd64.tar.gz

        current_shell=$(ps -p $$ -ocomm=)
        shellrc_file=""

        if [[ "$current_shell" == *"bash"* ]]; then
            shellrc_file="$HOME/.bashrc"
        elif [[ "$current_shell" == *"zsh"* ]]; then
            shellrc_file="$HOME/.zshrc"
        else
            echo "Unknown shell. Add Go to your PATH manually."
            return 1
        fi

        if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" "$shellrc_file"; then
            echo 'export PATH=$PATH:/usr/local/go/bin' >> "$shellrc_file"
            source "$shellrc_file"
        fi

        echo "Go installed successfully!"
        go version
    else
        echo -e "${BLUE}Go is already installed${NC}"
        go version
    fi
}

# Function to install a Go tool
install_go_tool() {
    local tool_name=$1
    local tool_repo=$2
    local tool_binary=$3

    echo "---------------------------------------------------------------"
    echo "Installing $tool_name..."

    if [ -x "$HOME/go/bin/$tool_binary" ]; then
        echo -e "${BLUE}$tool_name is already installed in $HOME/go/bin${NC}"
        if [ ! -x "/usr/local/bin/$tool_binary" ]; then
            sudo cp "$HOME/go/bin/$tool_binary" "/usr/local/bin/$tool_binary"
            echo "$tool_name copied to /usr/local/bin"
        fi
    elif [ -x "/usr/local/bin/$tool_binary" ]; then
        echo -e "${BLUE}$tool_name is already installed in /usr/local/bin${NC}"
        if [ ! -x "$HOME/go/bin/$tool_binary" ]; then
            cp "/usr/local/bin/$tool_binary" "$HOME/go/bin/$tool_binary"
            echo "$tool_name copied to $HOME/go/bin"
        fi
    else
        if error_message=$(go install "$tool_repo@latest" 2>&1 >/dev/null); then
            sudo cp "$HOME/go/bin/$tool_binary" "/usr/local/bin"
            echo "$tool_name installed successfully!"
            successful_tools+=("$tool_name")
        else
            echo -e "${RED}Failed to install $tool_name.${NC}"
            failed_tools+=("$tool_name: $error_message")
        fi
    fi
}

# Main script
install_go

install_go_tool "nuclei" "github.com/projectdiscovery/nuclei/v3/cmd/nuclei" "nuclei"
install_go_tool "subfinder" "github.com/projectdiscovery/subfinder/v2/cmd/subfinder" "subfinder"
install_go_tool "naabu" "github.com/projectdiscovery/naabu/v2/cmd/naabu" "naabu"
install_go_tool "gowitness" "github.com/sensepost/gowitness" "gowitness"
install_go_tool "httpx" "github.com/projectdiscovery/httpx/cmd/httpx" "httpx"
install_go_tool "notify" "github.com/projectdiscovery/notify/cmd/notify" "notify"
install_go_tool "assetfinder" "github.com/tomnomnom/assetfinder" "assetfinder"
install_go_tool "waybackurls" "github.com/tomnomnom/waybackurls" "waybackurls"
install_go_tool "gf" "github.com/tomnomnom/gf" "gf"
install_go_tool "shortscan" "github.com/bitquark/shortscan/cmd/shortscan" "shortscan"
install_go_tool "anew" "github.com/tomnomnom/anew" "anew"
install_go_tool "simplehttpserver" "github.com/projectdiscovery/simplehttpserver/cmd/simplehttpserver" "simplehttpserver"
install_go_tool "ffuf" "github.com/ffuf/ffuf/v2" "ffuf"
install_go_tool "amass" "github.com/owasp-amass/amass/v4/...@master" "amass"
install_go_tool "cloudrecon" "github.com/g0ldencybersec/CloudRecon" "CloudRecon"

echo ""
echo ""
echo ""
# Check which tools failed to install and display the list
if [ ${#successful_tools[@]} -eq 0 ]; then
    echo "No tools were successfully installed."
else
    echo -e "The following tools ${GREEN}successfully${NC} installed:"
    for tool_success in "${successful_tools[@]}"; do
        echo -e "${GREEN}$tool_success${NC}"
    done
fi

if [ ${#failed_tools[@]} -eq 0 ]; then
    echo "No tools failed to install."
else
    echo -e "The following tools ${RED}failed${NC} to install:"
    for tool_error in "${failed_tools[@]}"; do
        echo -e "${RED}$tool_error${NC}"
    done
fi
echo ""
echo ""
echo ""
