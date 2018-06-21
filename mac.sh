#!/bin/bash

## Set macOS default preferences
##

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable local Time Machine snapshots
sudo tmutil disablelocal

# Set mouse and trackpad tracking speeds
defaults write NSGlobalDomain com.apple.mouse.scaling -float 2
defaults write NSGlobalDomain com.apple.trackpad.scaling -int 1

# Enable mouse right click
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "TwoButton"
defaults write com.apple.AppleMultitouchMouse MouseButtonMode -string "TwoButton"

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets
# not sure whether we want this
#defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable subpixel font rendering on non-Apple LCDs
# maybe?
#defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 1

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Set home folder as default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

#set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Set magnification
defaults write com.apple.dock magnification -int 1
defaults write com.apple.dock largesize -int 70

# Bottom right screen corner → Mission Control
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Disable Spotlight internet suggestions (potential data leak)
defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1; "name" = "APPLICATIONS";}' \
    '{"enabled" = 0; "name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
    '{"enabled" = 1; "name" = "MENU_CONVERSION";}' \
    '{"enabled" = 1; "name" = "MENU_EXPRESSION";}' \
    '{"enabled" = 1; "name" = "MENU_DEFINITION";}' \
    '{"enabled" = 1; "name" = "SYSTEM_PREFS";}' \
    '{"enabled" = 1; "name" = "DOCUMENTS";}' \
    '{"enabled" = 1; "name" = "DIRECTORIES";}' \
    '{"enabled" = 1; "name" = "PRESENTATIONS";}' \
    '{"enabled" = 1; "name" = "SPREADSHEETS";}' \
    '{"enabled" = 1; "name" = "PDF";}' \
    '{"enabled" = 1; "name" = "MESSAGES";}' \
    '{"enabled" = 1; "name" = "CONTACT";}' \
    '{"enabled" = 1; "name" = "EVENT_TODO";}' \
    '{"enabled" = 1; "name" = "IMAGES";}' \
    '{"enabled" = 1; "name" = "BOOKMARKS";}' \
    '{"enabled" = 1; "name" = "MUSIC";}' \
    '{"enabled" = 1; "name" = "MOVIES";}' \
    '{"enabled" = 1; "name" = "FONTS";}' \
    '{"enabled" = 1; "name" = "MENU_OTHER";}'

# Set computer hostname
scutil --set ComputerName "MyMac"
scutil --set LocalHostName "MyMac"

# Restart affected applications
for app in "cfprefsd" "Dock" "Finder" "SystemUIServer"; do
    killall "${app}" > /dev/null 2>&1
done

echo "All applications have been restarted, but a reboot is recommended for all changes to take effect."

## Application setup
BREW_PKGS=(aircrack-ng autoconf automake cmake curl gdb git go gpg htop kafka knock nmap protobuf pypy3 python3 spoof-mac the_silver_searcher tmux unrar watch wget zstd)

# Install Homebrew
# This is reasonably insecure, may want to cache this somewhere
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

brew cask install java

for pkg in "${BREW_PKGS[@]}"; do
    if brew list -1 | grep -q "^${pkg}\$"; then
        echo "Package '$pkg' is already installed."
    else
        brew install $pkg
    fi
done

# Install git-fame-rb
sudo gem install git_fame

# Install magic-wormhole
pip3 install magic-wormhole

# Install atom
wget -O ~/Downloads/atom-mac.zip https://atom.io/download/mac
unzip -q ~/Downloads/atom-mac.zip -d ~/Downloads
mv ~/Downloads/Atom.app/ /Applications/.

## Terminal setup

wget -O ~/Downloads/solarized.zip http://ethanschoonover.com/solarized/files/solarized.zip
unzip -q ~/Downloads/solarized.zip -d ~/Downloads
open ~/Downloads/solarized/osx-terminal.app-colors-solarized/xterm-256color/Solarized\ Dark\ xterm-256color.terminal

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Set Solarized Dark as default
defaults write com.apple.terminal "Default Window Settings" -string "Solarized Dark xterm-256color"
defaults write com.apple.terminal "Startup Window Settings" -string "Solarized Dark xterm-256color"

# Custom Terminal config
/usr/libexec/PlistBuddy -c "Set \"Window Settings\":Pro:shellExitAction 1" ~/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "Set \"Window Settings\":Solarized\ Dark\ xterm-256color:shellExitAction 1" ~/Library/Preferences/com.apple.Terminal.plist

# Install custom config
wget -O ~/Downloads/term-config.zip "https://drive.google.com/uc?export=download&id=0BwvyireKY5moNk4wcWx6NU5XZnc"
unzip -q ~/Downloads/term-config.zip -d ~/

wget -O ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

# Install Anonymous Pro font
wget -O ~/Downloads/AnonymousPro.zip http://www.marksimonson.com/assets/content/fonts/AnonymousPro-1.002.zip
unzip -q ~/Downloads/AnonymousPro.zip -d ~/Downloads
open ~/Downloads/AnonymousPro-1.002.001/Anonymous\ Pro.ttf

# Install Node
if command -v npm 2>/dev/null; then
    echo "Node js is already installed"
else
    echo "Installing Node js v4"
    brew tap homebrew/versions
    brew install homebrew/versions/node4-lts
fi
node --version

# Checkout github personal projects
git clone git@github.com:laneshetron/monopoly.git ~/monopoly
git clone git@github.com:laneshetron/hangups.git ~/hangups

# Cleanup
rm ~/Downloads/atom-mac.zip
rm ~/Downloads/solarized.zip
rm ~/Downloads/term-config.zip
