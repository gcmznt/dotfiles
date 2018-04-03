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
brew install coreutils \
             tree \
             googler \
             node \
             the_silver_searcher \
             exiftool \
             jid \
             fzf \
             git \
             yarn

## browsers
brew cask install google-chrome \
                  firefox
# brew cask install google-chrome-canary
# brew cask install firefox-beta
# brew cask install firefoxdeveloperedition
# brew cask install opera
# brew cask install opera-beta
# brew cask install opera-developer
# brew cask install safari-technology-preview
# brew cask install webkit-nightly
# brew cask install brave
# brew cask install vivaldi
# brew cask install blisk
# brew cask install servo

## applications
brew cask install iterm2 \
                  visual-studio-code \
                  mou \
                  alfred \
                  transmit \
                  slack \
                  itsycal \
                  numi \
                  keepingyouawake \
                  kap \
                  vlc \
                  qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook suspicious-package quicklookase qlvideo \
                  aerial \
                  tunnelbear

# brew cask install betterzipql
# brew cask install tunnelblick
# brew cask install lacona
# brew cask install atom
# brew cask install sublime-text
# brew cask install docker
printf "\n==== Install from app store ====\nSip, Moom and Gestimer\n===========\n"

## fonts
brew cask install font-fira-code

# open background applications
open -a itsycal
open -a alfred\ 3
open -a keepingyouawake

## node
npm i -g npm \
         caniuse-cmd \
         code-stats \
         http-server \
         nodemon \
         space-hogs \
         tldr \
         git-bc \
         how2 \
         sloc \
         stylestats \
         webpagetest \
         yo \
         pageres-cli \
         ntl \
         gulp-cli \
         grunt-cli \
         eslint \
         bower \
         webpack \
         stylelint \
         diff-so-fancy

# remove last login message in terminal
touch ~/.hushlogin

# generate and print public ssh-key
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""
printf "\n==== Generated SSH Public key ====\n`cat ~/.ssh/id_rsa.pub`\n===========\n"

# configure npm
npm adduser

# setup works folders
cd ~
mkdir works
cd works

# clone and setup dotfiles
git clone git@github.com:gcmznt/dotfiles.git
cd dotfiles
## init z submodule
git submodule init
git submodule update

# configure git
cp ~/works/dotfiles/.gitconfig ~/.gitconfig
git config --global diff.exif.textconv exiftool

# bootstrap bash_profile
cp ~/works/dotfiles/.bash_profile_home_example ~/.bash_profile

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
# reload all application affected
for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done
