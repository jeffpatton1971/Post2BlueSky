# Changelog

All changes to this project should be reflected in this document.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [[0.0.2.10]](https://github.com/mod-posh/Post2Bluesky/releases/tag/v0.0.2.10) - 2024-01-17

There was an issue between 2.7 and 2.10, basically I was misunderstanding byteEnd. This has been corrected, byteEnd is now the the last character in the string to be linked from the _start_ of the string. Originally this was just the length of the string replaced, this resulted in odd placements or no placements of the link.

What's Changed:

1. Updated the logic to add the startIndex to the endIndex for a proper byteEnd value in the json

---

## [[0.0.2.7]](https://github.com/mod-posh/Post2Bluesky/releases/tag/v0.0.2.7) - 2024-01-17

This release corrects an issue with how the links were presented. The message retained the github markdown format which looked odd in a post, so it's been updated now to remove the markdown in favor of creating a link for just the word in the brackets

What's Changed:

1. Added logic to process the message for each markdown block
2. If the link is found
   1. The link is replaced with the anchor word and the message is updated
   2. The facet is created with the new location of the anchor in the message

---

## [[0.0.2.6]](https://github.com/mod-posh/Post2Bluesky/releases/tag/v0.0.2.6) - 2024-01-16

This release makes the message a little more github friendly, links should be notated in github [markdown](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links).

What's Changed:

1. Added logic to build the message
2. If a link is present it is parsed out
   1. iterate over the list of links to populate the facets

---

## [[0.0.2.5]](https://github.com/mod-posh/Post2Bluesky/releases/tag/v0.0.2.5) - 2024-01-16

This is a functional change, the Action now only posts a message, with an optional link(s)

What's Changed:

1. Added logic to build the message
2. If a link is present, test for a list
   1. iterate over the list of links to populate the embeds

---

## [[0.0.2.1]](https://github.com/mod-posh/Post2Bluesky/releases/tag/v0.0.2.1) - 2024-01-16

This is a functional change, the Action now only posts a message, there is no message creation within the Action. This can be externalized by some other process.

What's Changed:

1. Removed message creation logic
2. Added logic to test incoming message
   1. If plain-text, create a record and repo then post
   2. If it's a record object missing a repo, one is constrcuted and then posted
   3. If it's a proper bsky post object, it's posted
3. Moved the apikey and identifier into env variables
4. Added verbose logic

---

## [[0.0.2.0]](https://github.com/mod-posh/Post2Bluesky/releases/tag/v0.0.2.0) - 2024-01-10

This is a breaking change from previous versions, I have moved from Python to Powershell for the script. This allows me to easily test and work on these locally, as most of what I write is actually in PowerShell or C#.

- post2bsky.ps1: A rewrite of the script in PowerShell with better error handling and a more uniform layout.
- post2bsky.yml: Updated to work with PowerShell script.
- action.yml: Updated to work with PowerShell script.

---