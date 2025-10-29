#!/bin/bash

echo "Setting up AI Workflows for macOS..."

# ---
# Step 1: Check for and install Homebrew
# ---
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew is already installed."
fi

# ---
# Step 2: Check for and install jq
# ---
if ! command -v jq &> /dev/null; then
    echo "jq not found. Installing jq via Homebrew..."
    brew install jq
else
    echo "✅ jq is already installed."
fi

# ---
# Step 3: Get the user's API Key
# ---
echo ""
echo "Please enter your OpenAI API key (it will be hidden):"
read -sp "API Key: " API_KEY
echo ""

# Add the key to their .zshrc file if not already there
if ! grep -q "OPENAI_API_KEY" ~/.zshrc; then
    echo "" >> ~/.zshrc
    echo "# OpenAI API Key for AI Workflows" >> ~/.zshrc
    echo "export OPENAI_API_KEY=\"$API_KEY\"" >> ~/.zshrc
    echo "✅ API Key added to ~/.zshrc. Restart your Terminal for it to take effect."
else
    echo "✅ API Key already set in ~/.zshrc."
fi

# ---
# Step 4: Download and install multiple Automator Workflows
# ---

SERVICES_DIR="$HOME/Library/Services"
mkdir -p "$SERVICES_DIR"

# 🧩 Add your workflow ZIPs here
# Format: "filename.zip|Friendly Name"
WORKFLOWS=(
    "Rephrase%20with%20AI.zip|Rephrase with AI"
    "Open%20Datadog.zip|Open Datadog"
    "Open%20Grafana.zip|Open Grafana"
    "Query%20Chatgpt.zip|Open Chatgpt"
)

REPO_BASE_URL="https://github.com/devglyph1/mac-ai-rephraser/raw/main"

echo ""
echo "Downloading and installing workflows..."
echo ""

for entry in "${WORKFLOWS[@]}"; do
    IFS="|" read -r ZIP_FILE WORKFLOW_NAME <<< "$entry"
    ZIP_PATH="$HOME/Downloads/$WORKFLOW_NAME.zip"
    
    echo "📦 Downloading $WORKFLOW_NAME..."
    curl -sL "$REPO_BASE_URL/$ZIP_FILE" -o "$ZIP_PATH"
    
    echo "📂 Installing $WORKFLOW_NAME to $SERVICES_DIR..."
    unzip -o "$ZIP_PATH" -d "$SERVICES_DIR" > /dev/null
    rm "$ZIP_PATH"
    
    echo "✅ Installed: $WORKFLOW_NAME"
    echo ""
done

echo ""
echo "🎉 All workflows installed successfully!"
echo ""
echo "-------------------------------------------"
echo "🧩 FINAL STEP: Set Keyboard Shortcuts"
echo "-------------------------------------------"
echo "1. Open System Settings → Keyboard → Keyboard Shortcuts"
echo "2. Select 'Services' on the left"
echo "3. Scroll down to 'Text' section"
echo "4. For each of these workflows, click 'Add Shortcut' and set your preferred key:"
echo ""

for entry in "${WORKFLOWS[@]}"; do
    IFS="|" read -r ZIP_FILE WORKFLOW_NAME <<< "$entry"
    echo "   • $WORKFLOW_NAME"
done

echo ""
echo "Example: Press ⌃⇧R for 'Rephrase with AI', ⌃⇧S for 'Summarize with AI', etc."
echo ""
echo "✅ Done!"
