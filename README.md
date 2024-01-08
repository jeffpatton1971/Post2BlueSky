# Post2BlueSky GitHub Action

## Overview

Post2BlueSky is a GitHub Action designed to send notifications to BlueSky social media whenever new content is published. It's particularly useful for automated blog post updates.

## Requirements

- GitHub repository with GitHub Actions enabled.
- BlueSky API key and Identifier.

## Setting Up Secrets

Before using this action, you need to set up the following secrets in your GitHub repository:

- `BLUESKY_API_KEY`: Your BlueSky API key.
- `BLUESKY_IDENTIFIER`: Your BlueSky identifier.

These secrets can be added in your repository settings under `Settings > Secrets`.

## Usage

To use this action in your workflow, create a `.yml` file (if you haven't already) in your `.github/workflows` directory in your GitHub repository.

Here's a basic example of how to use this action:

```yaml
name: Blog Update Workflow

on:
  push:
    branches:
      - main

jobs:
  notify_bluesky:
    uses: jeffpatton1971/Post2Bluesky@v1
    with:
      message: "New blog post published!"
    secrets:
      bluesky_api_key: ${{ secrets.BLUESKY_API_KEY }}
      bluesky_identifier: ${{ secrets.BLuesky_Identifier }}
```

In this example, when you push to the `main` branch, the action will trigger and send a notification to BlueSky.

## Python Script

The `post2bsky.py` Python script is used by this action to perform the actual notification. It takes the API key, identifier, and the message as input to send the post to BlueSky.

## Contributing

Contributions to the Post2BlueSky action are welcome! Please read our contributing guidelines and submit pull requests for any enhancements.

## Support

For support, questions, or feature requests, please open an issue in the GitHub repository.

## License

This project is licensed under the [MIT License](LICENSE).
