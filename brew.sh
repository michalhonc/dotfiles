#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install --cask neovim --with-override-system-vi
brew install grep
brew install openssh
brew install node
brew install yarn

brew install --cask \
    bettertouchtool \
    docker \
    firefox-developer-edition \
    dropbox \
    google-chrome \
    1password \
    visual-studio-code \
    sublime-text \
    flipper \
    transmission \
    iterm2 \
    slack \
    vlc

npm i -g typescript ts-node react-devtools trash-cli prettier nodemon sass

# Install other useful binaries.
brew install ack
brew install git
brew install tree

# Remove outdated versions from the cellar.
brew cleanup
