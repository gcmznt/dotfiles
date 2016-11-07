#!/bin/bash

# set the hostname
echo "Enter the name for the computer:"
read newhostname
sudo scutil --set HostName $newhostname

# install brew and brew cask
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew tap caskroom/versions
brew tap caskroom/fonts
sudo chown -R $USER /usr/local/*
export PATH="/usr/local/bin:$PATH"

# install all software
## python
sudo easy_install -U Pygments
sudo easy_install httpcode

## terminal
brew install coreutils
brew install tree
brew install googler
brew install node
brew install the_silver_searcher
brew install exiftool

## browsers
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install firefox
# brew cask install firefox-beta
brew cask install firefoxdeveloperedition
brew cask install opera
# brew cask install opera-beta
# brew cask install opera-developer
# brew cask install safari-technology-preview
# brew cask install webkit-nightly
# brew cask install brave
# brew cask install vivaldi
# brew cask install blisk
# brew cask install servo

## applications
brew cask install iterm2
brew cask install atom
brew cask install visual-studio-code
brew cask install sublime-text
brew cask install alfred
brew cask install lacona
brew cask install git
brew cask install docker
brew cask install transmit
brew cask install moom
brew cask install slack
brew cask install itsycal
brew cask install numi
brew cask install keepingyouawake
brew cask install kap
brew cask install mou
# Missing from cask Sip and Gestimer

## fonts
brew cask install font-fira-code

# open background applications
open -a itsycal
open -a moom
open -a alfred\ 3
open -a keepingyouawake

## node
npm i -g npm
npm i -g caniuse-cmd
npm i -g code-stats
npm i -g http-server
npm i -g nodemon
npm i -g space-hogs
npm i -g tldr
npm i -g git-bc
npm i -g how2
npm i -g sloc
npm i -g stylestats
npm i -g webpagetest
npm i -g yo
npm i -g pageres-cli
npm i -g ntl
npm i -g jshint
npm i -g gulp-cli
npm i -g grunt-cli
npm i -g eslint
npm i -g bower
npm i -g webpack
npm i -g pug-lint
npm i -g stylelint
npm i -g diff-so-fancy

## atom
apm install atom-material-syntax
apm install atom-material-ui
apm install minimap
apm install pigments
apm install set-syntax
apm install sort-lines
apm install unsaved-changes
apm install keyboard-scroll
apm install filesize
apm install file-icons
apm install emmet
apm install editorconfig
apm install autocomplete-emojis
apm install atom-beautify
apm install linter
apm install linter-eslint
# apm install linter-lesshint
apm install linter-stylelint

# remove last login message in terminal
touch ~/.hushlogin

# configure npm
npm adduser

# setup works folders
cd ~
mkdir works
cd works
mkdir playground

# clone and setup dotfiles
git clone git@github.com:giacomozinetti/dotfiles.git
cd dotfiles
## init z submodule
git submodule init
git submodule update

# configure git
cp ~/works/dotfiles/.gitconfig ~/.gitconfig
git config diff.exif.textconv exiftool

# bootstrap bash_profile
cp ~/works/dotfiles/.bash_profile_home_example ~/.bash_profile

# symlink atom configuration
ln -s ~/works/dotfiles/.atom/config.cson ~/.atom/config.cson
ln -s ~/works/dotfiles/.atom/keymap.cson ~/.atom/keymap.cson

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
# Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES
# reload all application affected
for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done

# generate and print public ssh-key
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""
printf "\n==== Generated SSH Public key ====\n`cat ~/.ssh/id_rsa.pub`\n===========\n"
