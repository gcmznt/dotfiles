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

## app store
mas install 990588172 ## Gestimer
mas install 507257563 ## Sip

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
brew cask install firefox
brew cask install firefox-developer-edition
brew cask install google-chrome
# brew cask install blisk
# brew cask install brave
# brew cask install firefox-beta
# brew cask install google-chrome-canary
# brew cask install opera
# brew cask install opera-beta
# brew cask install opera-developer
# brew cask install safari-technology-preview
# brew cask install servo
# brew cask install vivaldi
# brew cask install webkit-nightly

## applications
brew cask install aerial
brew cask install alfred
brew cask install iterm2
brew cask install itsycal
brew cask install keepingyouawake
brew cask install notion
brew cask install numi
brew cask install rectangle
brew cask install runjs
brew cask install slack
brew cask install transmit
brew cask install visual-studio-code
brew cask install vlc
# brew cask install kap
# brew cask install sip
# brew cask install tunnelbear
# brew cask install atom
# brew cask install betterzipql
# brew cask install docker
# brew cask install lacona
# brew cask install mou
# brew cask install sublime-text
# brew cask install tunnelblick

## finder preview
brew cask install qlcolorcode
brew cask install qlimagesize
brew cask install qlmarkdown
brew cask install qlprettypatch
brew cask install qlstephen
brew cask install qlvideo
brew cask install quicklook-csv
brew cask install quicklook-json
brew cask install quicklookase
brew cask install suspicious-package
brew cask install webpquicklook

## fonts
brew cask install font-fira-code

printf "\n==== Install Dank Mono font ====\n\n"

# open background applications
open -a alfred\ 4
open -a gestimer
open -a itsycal
open -a keepingyouawake
open -a rectangle
open -a sip

## node
npm i -g npm
npm i -g bower
npm i -g caniuse-cmd
npm i -g code-stats
npm i -g diff-so-fancy
npm i -g eslint
npm i -g git-bc
npm i -g grunt-cli
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
