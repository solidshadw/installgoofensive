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
echo ""

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

        # Determine the user's shell
        current_shell=$(ps -p $$ -ocomm=)

        if [[ "$current_shell" == *"bash"* ]]; then
            # User is using bash
            echo "User is using bash"
            shellrc_file="$HOME/.bashrc"
        elif [[ "$current_shell" == *"zsh"* ]]; then
            # User is using zsh
            echo "User is using zsh"    
            shellrc_file="$HOME/.zshrc"
        else
            echo "Unknown shell. Unable to configure the environment. Please add Go to your PATH manually."
            return 1
        fi

        # Check if the export line is already present in the user's shell configuration file
        if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" "$shellrc_file"; then
            echo 'export PATH=$PATH:/usr/local/go/bin' >> "$shellrc_file"
            source $shellrc_file
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
            if error_message=$(go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest 2>&1 >/dev/null); then
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
                sudo  cp $HOME/go/bin/subfinder /usr/local/bin
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
    if [ ! -x "$HOME/go/bin/naabu" ] && [ ! -x "/usr/local/bin/naabu" ]; then    
        if ! command -v naabu; then
            # Download the latest naabu release
            wget $(curl -s https://api.github.com/repos/projectdiscovery/naabu/releases/latest | grep "browser_download_url" | cut -d '"' -f 4 | grep "_linux_amd64.zip") >/dev/null 2>&1
            # Extract the downloaded zip file
            if error_message=$(unzip -o naabu_*_linux_amd64.zip -d $HOME/go/bin 2>&1 >/dev/null); then
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

# Function to install gowitness url: https://github.com/sensepost/gowitness/wiki/Installation
install_gowitness(){
    echo "---------------------------------------------------------------"
    echo "Installing gowitness..."

    # Check if gowitness is found in ~/go/bin/gowitness
    if [ -x "$HOME/go/bin/gowitness" ]; then
        echo -e "${BLUE}gowitness is already installed in $HOME/go/bin${NC}"
        
        #If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/gowitness" ]; then
             sudo cp "$HOME/go/bin/gowitness" "/usr/local/bin/gowitness"
             echo "gowitness copied to /usr/local/bin"
        fi
    fi

    # Check if gowitness is found in /usr/local/bin/gowitness
    if [ -x "/usr/local/bin/gowitness" ]; then
        echo -e "${BLUE}gowitness is already installed in /usr/local/bin${NC}"
        
        #If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/gowitness" ]; then
            cp "/usr/local/bin/gowitness" "$HOME/go/bin/gowitness"
            echo "gowitness copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/gowitness" ] && [ ! -x "/usr/local/bin/gowitness" ]; then    
        if ! command -v gowitness; then
            if error_message=$(go install github.com/sensepost/gowitness@latest 2>&1 >/dev/null); then
                sudo  cp $HOME/go/bin/gowitness /usr/local/bin
                echo "gowitness installed successfully!"
                successful_tools+=("gowitness")
            else
                echo -e "${RED}Failed to install gowitness.${NC}"
                failed_tools+=("gowitness: $error_message")
            fi
        else
            echo -e "${BLUE}gowitness is already installed${NC}"
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
                sudo  cp $HOME/go/bin/httpx /usr/local/bin
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

# Function to install notify url: https://github.com/projectdiscovery/notify
install_notify(){
    echo "---------------------------------------------------------------"
    echo "Installing notify..."

    # Check if notify is found in ~/go/bin/notify
    if [ -x "$HOME/go/bin/notify" ]; then
        echo -e "${BLUE}notify is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/notify" ]; then
            sudo cp "$HOME/go/bin/notify" "/usr/local/bin/notify"
            echo "notify copied to /usr/local/bin"
        fi
    fi

    # Check if notify is found in /usr/local/bin/notify
    if [ -x "/usr/local/bin/notify" ]; then
        echo -e "${BLUE}notify is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/notify" ]; then
            cp "/usr/local/bin/notify" "$HOME/go/bin/notify"
            echo "notify copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/notify" ] && [ ! -x "/usr/local/bin/notify" ]; then    
        if ! command -v notify; then
            if error_message=$(go install -v github.com/projectdiscovery/notify/cmd/notify@latest 2>&1 >/dev/null); then
                sudo  cp $HOME/go/bin/notify /usr/local/bin
                echo "notify installed successfully!"
                successful_tools+=("notify")
            else
                echo -e "${RED}Failed to install notify.${NC}"
                failed_tools+=("notify: $error_message")
            fi
        else
            echo -e "${BLUE}notify is already installed${NC}"
        fi
        
    fi
}

# # Function to install assetfinder url: https://github.com/tomnomnom/assetfinder
install_assetfinder(){
    echo "---------------------------------------------------------------"
    echo "Installing assetfinder..."

    # Check if assetfinder is found in ~/go/bin/assetfinder
    if [ -x "$HOME/go/bin/assetfinder" ]; then
        echo -e "${BLUE}assetfinder is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/assetfinder" ]; then
            sudo cp "$HOME/go/bin/assetfinder" "/usr/local/bin/assetfinder"
            echo "assetfinder copied to /usr/local/bin"
        fi
    fi

    # Check if assetfinder is found in /usr/local/bin/assetfinder
    if [ -x "/usr/local/bin/assetfinder" ]; then
        echo -e "${BLUE}assetfinder is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/assetfinder" ]; then
            cp "/usr/local/bin/assetfinder" "$HOME/go/bin/assetfinder"
            echo "assetfinder copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/assetfinder" ] && [ ! -x "/usr/local/bin/assetfinder" ]; then    
        if ! command -v assetfinder; then
            if error_message=$(go install -v github.com/tomnomnom/assetfinder@latest 2>&1 >/dev/null); then
                sudo  cp $HOME/go/bin/assetfinder /usr/local/bin
                echo "assetfinder installed successfully!"
                successful_tools+=("assetfinder")
            else
                echo -e "${RED}Failed to install assetfinder.${NC}"
                failed_tools+=("assetfinder: $error_message")
            fi
        else
            echo -e "${BLUE}assetfinder is already installed${NC}"
        fi
        
    fi
}

# # Function to install waybackurls url: https://github.com/tomnomnom/waybackurls
install_waybackurls() {
    echo "---------------------------------------------------------------"
    echo "Installing waybackurls..."

    # Check if waybackurls is found in ~/go/bin/waybackurls
    if [ -x "$HOME/go/bin/waybackurls" ]; then
        echo -e "${BLUE}waybackurls is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/waybackurls" ]; then
            sudo cp "$HOME/go/bin/waybackurls" "/usr/local/bin/waybackurls"
            echo "waybackurls copied to /usr/local/bin"
        fi
    fi

    # Check if waybackurls is found in /usr/local/bin/waybackurls
    if [ -x "/usr/local/bin/waybackurls" ]; then
        echo -e "${BLUE}waybackurls is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/waybackurls" ]; then
            cp "/usr/local/bin/waybackurls" "$HOME/go/bin/waybackurls"
            echo "waybackurls copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/waybackurls" ] && [ ! -x "/usr/local/bin/waybackurls" ]; then    
        if ! command -v waybackurls; then
            if error_message=$(go install -v github.com/tomnomnom/waybackurls@latest 2>&1 >/dev/null); then
                sudo  cp $HOME/go/bin/waybackurls /usr/local/bin
                echo "waybackurls installed successfully!"
                successful_tools+=("waybackurls")
            else
                echo -e "${RED}Failed to install waybackurls.${NC}"
                failed_tools+=("waybackurls: $error_message")
            fi
        else
            echo -e "${BLUE}waybackurls is already installed${NC}"
        fi
        
    fi

}

# # Function to install gf url: https://github.com/tomnomnom/gf
install_gf(){
    echo "---------------------------------------------------------------"
    echo "Installing gf..."

    # Check if gf is found in ~/go/bin/gf
    if [ -x "$HOME/go/bin/gf" ]; then
        echo -e "${BLUE}gf is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/gf" ]; then
            sudo cp "$HOME/go/bin/gf" "/usr/local/bin/gf"
            echo "gf copied to /usr/local/bin"
        fi
    fi

    # Check if gf is found in /usr/local/bin/gf
    if [ -x "/usr/local/bin/gf" ]; then
        echo -e "${BLUE}gf is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/gf" ]; then
            cp "/usr/local/bin/gf" "$HOME/go/bin/gf"
            echo "gf copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/gf" ] && [ ! -x "/usr/local/bin/gf" ]; then    
        if ! command -v gf; then
            if error_message=$(go install -v github.com/tomnomnom/gf@latest 2>&1 >/dev/null); then
                sudo  cp $HOME/go/bin/gf /usr/local/bin
                echo "gf installed successfully!"
                successful_tools+=("gf")
            else
                echo -e "${RED}Failed to install gf.${NC}"
                failed_tools+=("gf: $error_message")
            fi
        else
            echo -e "${BLUE}gf is already installed${NC}"
        fi
        
    fi
}

#Function to install shortscan url: https://github.com/bitquark/shortscan
install_shortscan() {
    echo "---------------------------------------------------------------"
    echo "Installing shortscan..."

    # Check if shortscan is found in ~/go/bin/shortscan
    if [ -x "$HOME/go/bin/shortscan" ]; then
        echo -e "${BLUE}shortscan is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/shortscan" ]; then
            sudo cp "$HOME/go/bin/shortscan" "/usr/local/bin/shortscan"
            echo "shortscan copied to /usr/local/bin"
        fi
    fi

    # Check if shortscan is found in /usr/local/bin/shortscan
    if [ -x "/usr/local/bin/shortscan" ]; then
        echo -e "${BLUE}shortscan is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/shortscan" ]; then
            cp "/usr/local/bin/shortscan" "$HOME/go/bin/shortscan"
            echo "shortscan copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/shortscan" ] && [ ! -x "/usr/local/bin/shortscan" ]; then    
        if ! command -v shortscan; then
            if error_message=$(go install github.com/bitquark/shortscan/cmd/shortscan@latest 2>&1 >/dev/null); then
                sudo  cp $HOME/go/bin/shortscan /usr/local/bin
                echo "shortscan installed successfully!"
                successful_tools+=("shortscan")
            else
                echo -e "${RED}Failed to install shortscan.${NC}"
                failed_tools+=("shortscan: $error_message")
            fi
        else
            echo -e "${BLUE}shortscan is already installed${NC}"
        fi
        
    fi
}

# Function to install anew url: https://github.com/tomnomnom/anew
install_anew() {
    echo "---------------------------------------------------------------"
    echo "Installing anew..."

    # Check if anew is found in ~/go/bin/anew
    if [ -x "$HOME/go/bin/anew" ]; then
        echo -e "${BLUE}anew is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/anew" ]; then
            sudo cp "$HOME/go/bin/anew" "/usr/local/bin/anew"
            echo "anew copied to /usr/local/bin"
        fi
    fi

    # Check if anew is found in /usr/local/bin/anew
    if [ -x "/usr/local/bin/anew" ]; then
        echo -e "${BLUE}anew is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/anew" ]; then
            cp "/usr/local/bin/anew" "$HOME/go/bin/anew"
            echo "anew copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/anew" ] && [ ! -x "/usr/local/bin/anew" ]; then    
        if ! command -v anew; then
            if error_message=$(go install -v github.com/tomnomnom/anew@latest 2>&1 >/dev/null); then
                sudo  cp $HOME/go/bin/anew /usr/local/bin
                echo "anew installed successfully!"
                successful_tools+=("anew")
            else
                echo -e "${RED}Failed to install anew.${NC}"
                failed_tools+=("anew: $error_message")
            fi
        else
            echo -e "${BLUE}anew is already installed${NC}"
        fi
        
    fi
}

# Function to install Go SimpleHTTPServer url: https://github.com/projectdiscovery/simplehttpserver
install_simplehttpserver() {
    echo "---------------------------------------------------------------"
    echo "Installing simplehttpserver..."

    # Check if simplehttpserver is found in ~/go/bin/simplehttpserver
    if [ -x "$HOME/go/bin/simplehttpserver" ]; then
        echo -e "${BLUE}simplehttpserver is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/simplehttpserver" ]; then
            sudo cp "$HOME/go/bin/simplehttpserver" "/usr/local/bin/simplehttpserver"
            echo "simplehttpserver copied to /usr/local/bin"
        fi
    fi

    # Check if simplehttpserver is found in /usr/local/bin/simplehttpserver
    if [ -x "/usr/local/bin/simplehttpserver" ]; then
        echo -e "${BLUE}simplehttpserver is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/simplehttpserver" ]; then
            cp "/usr/local/bin/simplehttpserver" "$HOME/go/bin/simplehttpserver"
            echo "simplehttpserver copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/simplehttpserver" ] && [ ! -x "/usr/local/bin/simplehttpserver" ]; then    
        if ! command -v simplehttpserver; then
            if error_message=$(go install -v github.com/projectdiscovery/simplehttpserver/cmd/simplehttpserver@latest 2>&1 >/dev/null); then
                sudo  cp $HOME/go/bin/simplehttpserver /usr/local/bin
                echo "simplehttpserver installed successfully!"
                successful_tools+=("simplehttpserver")
            else
                echo -e "${RED}Failed to install simplehttpserver.${NC}"
                failed_tools+=("simplehttpserver: $error_message")
            fi
        else
            echo -e "${BLUE}simplehttpserver is already installed${NC}"
        fi
        
    fi

}
# Function to install ffuf url: https://github.com/ffuf/ffuf
install_ffuf() {
    echo "---------------------------------------------------------------"
    echo "Installing ffuf..."

    # Check if ffuf is found in ~/go/bin/ffuf
    if [ -x "$HOME/go/bin/ffuf" ]; then
        echo -e "${BLUE}ffuf is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/ffuf" ]; then
            sudo cp "$HOME/go/bin/ffuf" "/usr/local/bin/ffuf"
            echo "ffuf copied to /usr/local/bin"
        fi
    fi

    # Check if ffuf is found in /usr/local/bin/ffuf
    if [ -x "/usr/local/bin/ffuf" ]; then
        echo -e "${BLUE}ffuf is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/ffuf" ]; then
            cp "/usr/local/bin/ffuf" "$HOME/go/bin/ffuf"
            echo "ffuf copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/ffuf" ] && [ ! -x "/usr/local/bin/ffuf" ]; then    
        if ! command -v ffuf; then
            if error_message=$(go install github.com/ffuf/ffuf/v2@latest 2>&1 >/dev/null); then
                sudo  cp $HOME/go/bin/ffuf /usr/local/bin
                echo "ffuf installed successfully!"
                successful_tools+=("ffuf")
            else
                echo -e "${RED}Failed to install ffuf.${NC}"
                failed_tools+=("ffuf: $error_message")
            fi
        else
            echo -e "${BLUE}ffuf is already installed${NC}"
        fi
        
    fi
}

# Function to install amass from https://github.com/owasp-amass/amass
install_amass() {
    echo "---------------------------------------------------------------"
    echo "Installing amass..."

    # Check if amass is found in ~/go/bin/amass
    if [ -x "$HOME/go/bin/amass" ]; then
        echo -e "${BLUE}amass is already installed in $HOME/go/bin${NC}"
        
        #If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/amass" ]; then
             sudo cp "$HOME/go/bin/amass" "/usr/local/bin/amass"
             echo "amass copied to /usr/local/bin"
        fi
    fi

    # Check if amass is found in /usr/local/bin/amass
    if [ -x "/usr/local/bin/amass" ]; then
        echo -e "${BLUE}amass is already installed in /usr/local/bin${NC}"
        
        #If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/amass" ]; then
            cp "/usr/local/bin/amass" "$HOME/go/bin/amass"
            echo "amass copied to $HOME/go/bin"
        fi
    fi

    #If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/amass" ] && [ ! -x "/usr/local/bin/amass" ]; then    
        if ! command -v amass; then
            if error_message=$(go install -v github.com/owasp-amass/amass/v4/...@master 2>&1 >/dev/null); then
                sudo  cp $HOME/go/bin/amass /usr/local/bin
                echo "amass installed successfully!"
                successful_tools+=("amass")
            else
                echo -e "${RED}Failed to install amass.${NC}"
                failed_tools+=("amass: $error_message")
            fi
        else
            echo -e "${BLUE}amass is already installed${NC}"
        fi
        
    fi
}

install_cloudrecon() {
    echo "---------------------------------------------------------------"
    echo "Installing CloudRecon..."

    # Check if CloudRecon is found in ~/go/bin/cloudrecon
    if [ -x "$HOME/go/bin/cloudrecon" ]; then
        echo -e "${BLUE}CloudRecon is already installed in $HOME/go/bin${NC}"
        
        # If not found in /usr/local/bin, copy it there. So, that you are aware of what go tools you have installed
        if [ ! -x "/usr/local/bin/cloudrecon" ]; then
            sudo cp "$HOME/go/bin/cloudrecon" "/usr/local/bin/cloudrecon"
            echo "CloudRecon copied to /usr/local/bin"
        fi
    fi

    # Check if CloudRecon is found in /usr/local/bin/cloudrecon
    if [ -x "/usr/local/bin/cloudrecon" ]; then
        echo -e "${BLUE}CloudRecon is already installed in /usr/local/bin${NC}"
        
        # If not found in ~/go/bin, copy it there
        if [ ! -x "$HOME/go/bin/cloudrecon" ]; then
            cp "/usr/local/bin/cloudrecon" "$HOME/go/bin/cloudrecon"
            echo "CloudRecon copied to $HOME/go/bin"
        fi
    fi

    # If not installed in either location, install it
    if [ ! -x "$HOME/go/bin/cloudrecon" ] && [ ! -x "/usr/local/bin/cloudrecon" ]; then    
        if ! command -v cloudrecon; then
            if error_message=$(go install github.com/g0ldencybersec/CloudRecon@latest 2>&1 >/dev/null); then
                sudo cp $HOME/go/bin/cloudrecon /usr/local/bin
                echo "CloudRecon installed successfully!"
                successful_tools+=("cloudrecon")
            else
                echo -e "${RED}Failed to install CloudRecon. $error_message${NC}"
                failed_tools+=("cloudrecon: $error_message")
            fi
        else
            echo -e "${BLUE}CloudRecon is already installed${NC}"
        fi
        
    fi
}


# Main script
install_go
install_nuclei
install_subfinder
install_naabu
install_gowitness
install_httpx
install_notify
install_assetfinder
install_waybackurls
install_gf
install_shortscan
install_anew
install_simplehttpserver
install_ffuf
install_amass
install_cloudrecon


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
