# mac-ai-rephraser - 🤖 An AI Rephraser for macOS

A simple macOS Quick Action that lets you rephrase any selected text, anywhere on your system.

Select text in your browser, notes, chat app, or anywhere else, press a keyboard shortcut, and this tool will use the OpenAI API to instantly rephrase it for clarity, professionalism, or grammar.

## ✨ Features

* **System-Wide:** Works in any application that supports text selection.
* **Instant Replacement:** Automatically replaces your selected text with the AI's rephrased version.
* **Customizable:** Easily edit the script to change the AI model (`gpt-4o-mini`, `gpt-4`, etc.) or the prompt (e.g., "fix grammar," "make more casual").
* **Secure:** Your API key is stored locally in your shell environment, not in the script itself.

## 🚀 Installation

This tool requires [Homebrew](https://brew.sh/) to install the `jq` dependency (a JSON parser).

Open your **Terminal** app, paste the following command, and press Enter:

```bash
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/devglyph1/mac-ai-rephraser/main/install.sh](https://raw.githubusercontent.com/devglyph1/mac-ai-rephraser/main/install.sh))"
