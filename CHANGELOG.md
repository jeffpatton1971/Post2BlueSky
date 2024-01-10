# Changelog

All changes to this project should be reflected in this document.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [[0.0.2.0]](https://github.com/mod-posh/Post2Bluesky/releases/tag/v0.0.2.0) - 2024-10-10

This is a breaking change from previous versions, I have moved from Python to Powershell for the script. This allows me to easily test and work on these locally, as most of what I write is actually in PowerShell or C#.

- post2bsky.ps1: A rewrite of the script in PowerShell with better error handling and a more uniform layout.
- post2bsky.yml: Updated to work with PowerShell script.
- action.yml: Updated to work with PowerShell script.

---
