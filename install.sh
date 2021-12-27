#!/bin/bash

# set the hostname
echo "Enter the name for the computer:"
read newhostname
sudo scutil --set HostName $newhostname

xcode-select --install

# install brew and brew cask
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts

sudo chown -R $USER /usr/local/*
export PATH="/usr/local/bin:$PATH"

# install all software
## python
sudo easy_install -U Pygments
sudo easy_install httpcode

## terminal
brew install coreutils
brew install direnv
brew install exiftool
brew install fzf
brew install git
brew install jid
brew install mas
brew install node
brew install nvm
mkdir ~/.nvm
brew install the_silver_searcher
brew install tree
brew install yarn

## browsers
brew install --cask firefox
brew install --cask firefox-developer-edition
brew install --cask google-chrome
# brew install --cask blisk
# brew install --cask brave
# brew install --cask firefox-beta
# brew install --cask google-chrome-canary
# brew install --cask opera
# brew install --cask opera-beta
# brew install --cask opera-developer
# brew install --cask safari-technology-preview
# brew install --cask servo
# brew install --cask vivaldi
# brew install --cask webkit-nightly

## applications
brew install --cask aerial
brew install --cask alfred
brew install --cask authy
brew install --cask discord
brew install --cask iterm2
brew install --cask itsycal
brew install --cask kap
brew install --cask keepingyouawake
brew install --cask notion
brew install --cask numi
brew install --cask rectangle
brew install --cask runcat
brew install --cask runjs
brew install --cask shottr
brew install --cask sip
brew install --cask slack
brew install --cask transmit
brew install --cask visual-studio-code
brew install --cask vlc
# brew install --cask tunnelbear
# brew install --cask atom
# brew install --cask betterzipql
# brew install --cask docker
# brew install --cask lacona
# brew install --cask mou
# brew install --cask sublime-text
# brew install --cask tunnelblick

## finder preview
brew install --cask qlcolorcode
brew install --cask qlimagesize
brew install --cask qlmarkdown
brew install --cask qlprettypatch
brew install --cask qlstephen
brew install --cask qlvideo
brew install --cask quicklook-csv
brew install --cask quicklook-json
brew install --cask quicklookase
brew install --cask suspicious-package
brew install --cask webpquicklook

## fonts
brew install --cask font-fira-code

printf "\n==== Install Dank Mono font ====\n\n"

## app store
mas install 990588172 ## Gestimer
mas install 507257563 ## Sip
mas install 1429033973 ## Runcat

# open background applications
open -a alfred\ 4
open -a gestimer
open -a itsycal
open -a keepingyouawake
open -a rectangle
open -a runcat
open -a sip

## node
npm i -g npm
# npm i -g bower
npm i -g caniuse-cmd
npm i -g code-stats
npm i -g diff-so-fancy
npm i -g eslint
npm i -g git-bc
# npm i -g grunt-cli
npm i -g gulp-cli
npm i -g how2
npm i -g http-server
npm i -g nodemon
npm i -g ntl
npm i -g pageres-cli
npm i -g sloc
npm i -g space-hogs
npm i -g stylelint
npm i -g stylestats
npm i -g tldr
npm i -g webpack
npm i -g webpagetest
npm i -g yo

# remove last login message in terminal
touch ~/.hushlogin

# generate and print public ssh-key
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""
printf "\n\n\n==== Generated SSH Public key ====\n`cat ~/.ssh/id_rsa.pub`\n===========\n\n"

printf "\n\n\n==== Login on NPM ====\n"
# configure npm
npm adduser

# setup works folders
cd ~
mkdir works
cd works

# clone and setup dotfiles
git clone https://github.com/gcmznt/dotfiles.git
cd dotfiles
## init z submodule
git submodule init
git submodule update

# configure git
cp ~/works/dotfiles/.gitconfig ~/.gitconfig

# bootstrap bash_profile
cp ~/works/dotfiles/.bash_profile_home_example ~/.bash_profile
sed -i '' 's/giko/'$(whoami)'/g' ~/.bash_profile

cp ~/works/dotfiles/.inputrc ~/.inputrc

# configure macosx (https://gist.github.com/erikh/2260182)
## Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
## Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
## Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Enable tap to click (Trackpad)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
# Only Show Open Applications In The Dock
defaults write com.apple.dock static-only -bool true
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true
# Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
# Show item info below desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# Enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0.02
# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 12
# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES
# Change Apple OS X Dock size
defaults write com.apple.dock tilesize -int 32

# Change screen saver
defaults write com.apple.screensaver "moduleDict" -dict-add "moduleName" -string "Aerial"
defaults write com.apple.screensaver "moduleDict" -dict-add "path" -string "/Users/"$(whoami)"/Library/Screen Savers/Aerial.saver"

# Mostra percentuale batteria
defaults write com.apple.menuextra.battery ShowPercent YES

# Imposta formato orologio
defaults write com.apple.menuextra.clock DateFormat -string "HH:mm"

# Evita riordino spaces
defaults write com.apple.dock mru-spaces -bool false

# reload all application affected
for app in Safari Finder Dock Mail SystemUIServer; do
    killall "$app" >/dev/null 2>&1;
done
