#!/bin/bash

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

# Function to install Go
install_go() {
    # Check if Go is already installed
    if ! command -v go; then
        echo "Installing Go..."
        # Download the latest stable Go version from the official website
        wget https://go.dev/dl/$(curl -s https://go.dev/dl/ | grep -o 'go[0-9]*\.[0-9]*\.[0-9]*\.linux-amd64\.tar\.gz' | head -n 1)
        # Extract and install Go
        sudo tar -C /usr/local -xzf go*.linux-amd64.tar.gz
        # Add Go binaries to PATH
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
        source ~/.bashrc
	export PATH=$PATH:/usr/local/go/bin
        # Clean up the downloaded tar.gz file
        rm go*.linux-amd64.tar.gz
        echo "Go installed successfully!"
	go version
    else
        echo "Go is already installed."
    fi
}

# Function to install naabu
install_naabu() {
   if ! command -v naabu; then
       echo "Installing naabu..."
       # Download the latest naabu release
       wget $(curl -s https://api.github.com/repos/projectdiscovery/naabu/releases/latest | grep "browser_download_url" | cut -d '"' -f 4 | grep "_linux_amd64.zip")
       # Extract the downloaded zip file
       unzip naabu_*_linux_amd64.zip -d $HOME/go/bin
       # Move naabu binary to /usr/local/bin (you may need sudo)
       sudo cp $HOME/go/bin/naabu /usr/local/bin/
       # Clean up
       rm naabu_*_linux_amd64.zip
       echo "naabu installed successfully!"
   else
	echo "Naabu already installed"

   fi
}

tui-header
tui-title "some text of yours"
tui-header

# Function to install nuclei
install_nuclei() {
    echo "Installing nuclei..."
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
    sudo cp $HOME/go/bin/nuclei /usr/local/bin
    echo "nuclei installed successfully!"
}

# Function to install subfinder
install_subfinder() {
    echo "Installing subfinder..."
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    sudo cp $HOME/go/bin/subfinder /usr/local/bin
    echo "subfinder installed successfully!"
}

# Main script
install_go
install_naabu
install_nuclei
install_subfinder

echo "All tools installed successfully!"
