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
echo ""b

# Initialize an array to store the names of tools that failed to install
failed_tools=()
successful_tools=()

# ANSI color codes
RED='\033[0;31m'  # Red color
NC='\033[0m'      # No color
GREEN='\033[0;32m' # Green color
BLUE='\033[0;34m'

# Function to install Go

install_go() {
    echo "---------------------------------------------------------------"
    echo "Installing Go..."
    if ! command -v /usr/local/go/bin/go; then
        # Download the latest stable Go version from the official website
        wget https://go.dev/dl/$(curl -s https://go.dev/dl/ | grep -o 'go[0-9]*\.[0-9]*\.[0-9]*\.linux-amd64\.tar\.gz' | head -n 1) >/dev/null 2>&1
        # Extract and install Go
        sudo tar -C /usr/local -xzf go*.linux-amd64.tar.gz
      # Check if the export line is already present in .bashrc
        if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" ~/.bashrc; then
            echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
            source ~/.bashrc
        fi
        # Check if the export line is already present in .zshrc
        if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" ~/.zshrc; then
            echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
            source ~/.zshrc
        fi
        # Clean up the downloaded tar.gz file
        rm go*.linux-amd64.tar.gz
        echo "Go installed successfully!"
            go version
    else
        echo -e "${BLUE}Go is already installed${NC}"
        go version
    fi
}

# # Function to install nuclei url: https://github.com/projectdiscovery/nuclei
install_nuclei() {
    echo "---------------------------------------------------------------"
    echo "Installing nuclei..."
    
    # Check if nuclei is installed in ~/go/bin/nuclei
    if [ -x "$HOME/go/bin/nuclei" ]; then
        echo -e "${BLUE}nuclei is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/nuclei" ]; then
            sudo cp "$HOME/go/bin/nuclei" "/usr/local/bin/nuclei"
            echo "nuclei copied to /usr/local/bin"
        fi
    fi

    # Check if nuclei is installed in /usr/local/bin/nuclei
    if [ -x "/usr/local/bin/nuclei" ]; then
        echo -e "${BLUE}nuclei is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/nuclei" ]; then
            cp "/usr/local/bin/nuclei" "$HOME/go/bin/nuclei"
            echo "nuclei copied to $HOME/go/bin"
        fi
    fi

    # If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/nuclei" ] && [ ! -x "/usr/local/bin/nuclei" ]; then
        if ! command -v nuclei; then
            if error_message=$(go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest 2>&1 >/dev/null); then
                sudo cp $HOME/go/bin/nuclei /usr/local/bin
                echo "nuclei installed successfully!"
                successful_tools+=("nuclei")
            else
                echo -e "${RED}Failed to install nuclei.${NC}"
                failed_tools+=("nuclei: $error_message")
            fi
        else
            echo -e "${BLUE}nuclei is already installed${NC}"
        fi
    fi
}

# # Function to install subfinder url: https://github.com/projectdiscovery/subfinder

install_subfinder() {
    echo "---------------------------------------------------------------"
    echo "Installing subfinder..."

    # Check if subfinder is found in ~/go/bin/subfinder
    if [ -x "$HOME/go/bin/subfinder" ]; then
        echo -e "${BLUE}subfinder is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/subfinder" ]; then
            sudo cp "$HOME/go/bin/subfinder" "/usr/local/bin/subfinder"
            echo "subfinder copied to /usr/local/bin"
        fi
    fi

    # Check if subfinder is found in /usr/local/bin/subfinder
    if [ -x "/usr/local/bin/subfinder" ]; then
        echo -e "${BLUE}subfinder is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/subfinder" ]; then
            cp "/usr/local/bin/subfinder" "$HOME/go/bin/subfinder"
            echo "subfinder copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/subfinder" ] && [ ! -x "/usr/local/bin/subfinder" ]; then    
        if ! command -v subfinder; then
            if error_message=$(go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest 2>&1 >/dev/null); then
                udo cp $HOME/go/bin/subfinder /usr/local/bin
                echo "subfinder installed successfully!"
                successful_tools+=("subfinder")
            else
                echo -e "${RED}Failed to install subfinder.${NC}"
                failed_tools+=("subfinder: $error_message")
            fi
        else
            echo -e "${BLUE}subfinder is already installed${NC}"
        fi
        
    fi
}

# Function to install naabu
install_naabu() {
    echo "---------------------------------------------------------------"
    echo "Installing naabu..."

 # Check if naabu is found in ~/go/bin/naabu
    if [ -x "$HOME/go/bin/naabu" ]; then
        echo -e "${BLUE}naabu is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/naabu" ]; then
            sudo cp "$HOME/go/bin/naabu" "/usr/local/bin/naabu"
            echo "naabu copied to /usr/local/bin"
        fi
    fi

    # Check if naabu is found in /usr/local/bin/naabu
    if [ -x "/usr/local/bin/naabu" ]; then
        echo -e "${BLUE}naabu is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/naabu" ]; then
            cp "/usr/local/bin/naabu" "$HOME/go/bin/naabu"
            echo "naabu copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/subfinder" ] && [ ! -x "/usr/local/bin/subfinder" ]; then    
        if ! command -v naabu; then
            # Download the latest naabu release
            wget $(curl -s https://api.github.com/repos/projectdiscovery/naabu/releases/latest | grep "browser_download_url" | cut -d '"' -f 4 | grep "_linux_amd64.zip") >/dev/null 2>&1
            # Extract the downloaded zip file
            if error_message=$(unzip naabu_*_linux_amd64.zip -d $HOME/go/bin 2>&1 >/dev/null); then
                # Move naabu binary to /usr/local/bin (you may need sudo)
                sudo cp $HOME/go/bin/naabu /usr/local/bin/
                # Clean up
                rm naabu_*_linux_amd64.zip
                echo "naabu installed successfully!"
                successful_tools+=("naabu")
            else
                echo -e "${RED}Failed to install naabu.${NC}"
                failed_tools+=("naabu: $error_message")
            fi
        else
           echo -e "${BLUE}naabu is already installed${NC}"
         fi
    fi
}

# # Function to install httpx url: https://github.com/projectdiscovery/httpx

install_httpx() {
    echo "---------------------------------------------------------------"
    echo "Installing httpx..."

    # Check if httpx is found in ~/go/bin/httpx
    if [ -x "$HOME/go/bin/httpx" ]; then
        echo -e "${BLUE}httpx is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/httpx" ]; then
            sudo cp "$HOME/go/bin/httpx" "/usr/local/bin/httpx"
            echo "httpx copied to /usr/local/bin"
        fi
    fi

    # Check if httpx is found in /usr/local/bin/httpx
    if [ -x "/usr/local/bin/httpx" ]; then
        echo -e "${BLUE}httpx is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/httpx" ]; then
            cp "/usr/local/bin/httpx" "$HOME/go/bin/httpx"
            echo "httpx copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/httpx" ] && [ ! -x "/usr/local/bin/httpx" ]; then    
        if ! command -v httpx; then
            if error_message=$(go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest 2>&1 >/dev/null); then
                udo cp $HOME/go/bin/httpx /usr/local/bin
                echo "httpx installed successfully!"
                successful_tools+=("httpx")
            else
                echo -e "${RED}Failed to install httpx.${NC}"
                failed_tools+=("httpx: $error_message")
            fi
        else
            echo -e "${BLUE}httpx is already installed${NC}"
        fi
        
    fi
}

# # Function to install notify url: https://github.com/projectdiscovery/notify
# install_notify() {
#     echo "---------------------------------------------------------------"
#     echo "Installing notify..."
#     go install -v github.com/projectdiscovery/notify/cmd/notify@latest
#     sudo cp $HOME/go/bin/notify /usr/local/bin
#     echo "notify installed successfully!"
#     successful_tools+=("notify")
# }

# # Function to install assetfinder url: https://github.com/tomnomnom/assetfinder
# install_assetfinder() {
#     echo "---------------------------------------------------------------"
#     echo "Installing assetfinder..."
#     go install github.com/tomnomnom/assetfinder@latest
#     sudo cp $HOME/go/bin/assetfinder /usr/local/bin
#     echo "assetfinder installed successfully!"
#     successful_tools+=("assetfinder")
# }

# # Function to install waybackurls url: https://github.com/tomnomnom/waybackurls
# install_waybackurls() {
#     echo "---------------------------------------------------------------"
#     echo "Installing waybackurls..."
#     go install github.com/tomnomnom/waybackurls@latest
#     sudo cp $HOME/go/bin/waybackurls /usr/local/bin
#     echo "waybackurls installed successfully!"
#     successful_tools+=("waybackurls")
# }

# # Function to install gf url: https://github.com/tomnomnom/gf
# install_gf() {
#     echo "---------------------------------------------------------------"
#     echo "Installing gf..."
#     go install github.com/tomnomnom/gf@latest
#     sudo cp $HOME/go/bin/gf /usr/local/bin
#     echo "gf installed successfully!"
#     successful_tools+=("gf")
# }

# # Function to install shortscan url: https://github.com/bitquark/shortscan
# install_shortscan() {
#     echo "---------------------------------------------------------------"
#     echo "Installing IIS shortscan..."
#     go install github.com/bitquark/shortscan/cmd/shortscan@latest
#     sudo cp $HOME/go/bin/shortscan /usr/local/bin
#     echo "shortscan installed successfully!"
#     successful_tools+=("shortscan")
# }

# # Function to install anew url: https://github.com/tomnomnom/anew
# install_anew() {
#     echo "---------------------------------------------------------------"
#     echo "Installing anew..."
#     go install -v github.com/tomnomnom/anew@latest
#     sudo cp $HOME/go/bin/anew /usr/local/bin
#     echo "anew installed successfully!"
#     successful_tools+=("anew")
# }

# # Function to install Go SimpleHTTPServer url: https://github.com/projectdiscovery/simplehttpserver
# install_simplehttpserver() {
#     echo "---------------------------------------------------------------"
#     echo "Installing simplehttpserver..."
#     go install -v github.com/projectdiscovery/simplehttpserver/cmd/simplehttpserver@latest
#     sudo cp $HOME/go/bin/simplehttpserver /usr/local/bin
#     echo "simplehttpserver installed successfully!"
#     successful_tools+=("simplehttpserver")
# }

# # Function to install ffuf url: https://github.com/ffuf/ffuf
# install_ffuf() {
#     echo "---------------------------------------------------------------"
#     echo "Installing ffuf..."
#     go install github.com/ffuf/ffuf/v2@latest
#     sudo cp $HOME/go/bin/ffuf /usr/local/bin
#     echo "ffuf installed successfully!"
#     successful_tools+=("ffuf")
# }

# // Function to install amass from https://github.com/owasp-amass/amass
# install_amass() {
#     echo "---------------------------------------------------------------"
#     echo "Installing amass..."
#     go install -v github.com/owasp-amass/amass/v4/...@master
#     sudo cp $HOME/go/bin/amass /usr/local/bin
#     echo "amass installed successfully!"
#     successful_tools+=("amass")
# }
  

# Main script
install_go
install_nuclei
install_subfinder
install_naabu
# install_gowitness
# install_httpx
# install_notify
# install_assetfinder
# install_waybackurls
# install_gf
# install_shortscan
# install_anew
# install_simplehttpserver
# install_ffuf
# install_amass


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