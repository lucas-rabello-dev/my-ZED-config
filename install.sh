#!/bin/bash
set -e

# install font
echo "Installing the font"

sudo dnf install fontconfig -y

curl -O https://raw.githubusercontent.com/loadedk/nerd-font-fedora-script/main/nerd-font-installer.sh
chmod +x nerd-font-installer.sh
./nerd-font-installer.sh

echo "Installing the languages and LSPs"

echo "Installing Rust and LSP"
sudo dnf install curl gcc -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

echo "Installing Go"
curl -LO https://go.dev/dl/go1.25.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.25.5.linux-amd64.tar.gz
export PATH="/usr/local/go/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH" 

echo "Installing Gopls"
go install golang.org/x/tools/gopls@latest


echo "Installing NASM and Linker (GNU) "
sudo dnf install nasm binutils -y

echo "Installing asm-lsp (LSP for assembly)"
cargo install asm-lsp

sudo dnf install clang clang-tools-extra -y

sudo dnf install gcc gcc-c++ gdb make -y

# copy files
echo "copying files"

rm -f ~/.config/zed/settings.json
cp settings.jsonc ~/.config/zed/

mkdir -p ~/.config/asm-lsp
cp .asm-lsp.toml ~/.config/asm-lsp

echo "Finish"
echo "Restart your terminal"