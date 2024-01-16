# BlueSky Notification GitHub Action

## Overview

The "Post2Bluesky" Github Action posts a message to your Bsky social account. You can use this for project update notifications, new releases, or just an easy way to post a message. The workflow accepts a plain-text message or a JSON string comprised of at least [bsky record](https://atproto.com/blog/create-post#post-record-structure).

## Setup

**GitHub Secrets**: Set up the following secrets in your GitHub repository:

- `bluesky_api_key`: Your BlueSky App Password.
- `bluesky_identifier`: Your BlueSky Identifier, like `user.bsky.social`.

## Workflow File

You can trigger the `action.yml` by `workflow_call` to post a notification automatically. The workflow contains several steps to act:

1. Checkout the repository
2. Call the `post2bsky.ps1` script

### Workflow Inputs

- `Message`: The message to post
- `verbose`: A value of verbose will output additional information
- `Link`: A url to link to, or a comma separated list of links
- `bluesky_api_key`: Your BlueSky App Password
- `bluesky_identifier`: Your BlueSky Identifier, something like user.bsky.social

## PowerShell Script (`issue2releasenotes.ps1`)

The PowerShell script constructs an authentication package to authenticate into the API. Once it has authenticated, it checks to see if the `Message` is a proper bsky record with repo or if it's a plain-text message. If it's a proper message it is posted; if it's missing a repo, one is constructed, and then the message is posted; and finally, if it's just a plain-text message, a record and repo are created and posted for you.

## Usage

There a few different ways you could use this action, here is an example of one way to get you started.

```yaml
jobs:
  send_notification:
    uses: mod-posh/Post2BlueSky@v0.0.2.5
    with:
      message: '"This is a test post with a link to github"'
      link: 'https://www.github.com'
      verbose: 'verbose'
      bluesky_api_key: ${{ secrets.bluesky_api_key }}
      bluesky_identifier: ${{ secrets.bluesky_identifier }}
```

> [!Note]
> This example is used directly as part of a larger workflow
> The verbose option will output a little more detail in the logs

## License

This project is licensed using the [Gnu GPL-3](LICENSE).
