#!/bin/bash

echo "Setting up AI Rephraser for macOS..."

# ---
# Step 1: Check for and install Homebrew, the macOS package manager
# ---
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# ---
# Step 2: Check for and install 'jq' (our JSON parser)
# ---
if ! command -v jq &> /dev/null; then
    echo "jq not found. Installing jq via Homebrew..."
    brew install jq
else
    echo "jq is already installed."
fi

# ---
# Step 3: Get the user's API Key
# ---
echo ""
echo "Please enter your OpenAI API key (it will be hidden):"
read -sp "API Key: " API_KEY # -sp prompts securely
echo ""

# Add the key to their .zshrc file
echo "Adding API key to ~/.zshrc..."
echo "" >> ~/.zshrc
echo "# OpenAI API Key for Rephraser Tool" >> ~/.zshrc
echo "export OPENAI_API_KEY=\"$API_KEY\"" >> ~/.zshrc

echo "API Key saved. Please restart your Terminal for it to be active."

# ---
# Step 4: Download and install the Automator Workflow
# ---
SERVICE_NAME="Rephrase with AI.workflow"
SERVICES_DIR="$HOME/Library/Services"
REPO_URL="https://github.com/devglyph1/mac-ai-rephraser/raw/main/$SERVICE_NAME.zip" # Assumes you zip the workflow

echo "Downloading the workflow..."
# Note: GitHub automatically zips .workflow files when you click "Download"
# It's easier to download the .workflow file as a zip from the repo
# You must first ZIP your "Rephrase with AI.workflow" file and upload that zip to GitHub.
# Let's assume you uploaded "Rephrase with AI.workflow.zip" to your repo.

# Download the zip file
curl -sL "https://github.com/devglyph1/mac-ai-rephraser/raw/main/Rephrase%20with%20AI.zip" -o "$HOME/Downloads/rephrase.zip"

# Unzip it to the Services directory
echo "Installing to $SERVICES_DIR..."
mkdir -p "$SERVICES_DIR" # Ensure the Services directory exists
unzip -o "$HOME/Downloads/rephrase.zip" -d "$SERVICES_DIR"

# Clean up
rm "$HOME/Downloads/rephrase.zip"

echo ""
echo "✅ Installation complete!"
echo ""
echo "---
FINAL STEP: Set Your Keyboard Shortcut
---
1. Go to System Settings > Keyboard > Keyboard Shortcuts...
2. Select 'Services' from the left menu.
3. Scroll down to 'Text' and find 'Rephrase with AI'.
4. Click 'Add Shortcut' and press your desired hotkey (e.g., ⌃⇧R)
"
