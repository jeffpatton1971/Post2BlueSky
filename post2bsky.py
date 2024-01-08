import json
import requests
import sys
from datetime import datetime

def post2bsky(api_key, identifier, message):
    # Get current date and time in the specified format
    created_at = datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S.%fZ")

    # Construct the authentication body
    auth_body = {
        "Identifier": identifier,
        "ApiKey": api_key
    }

    # Set up headers for the request
    headers = {
        'Content-Type': 'application/json'
    }

    # Authenticate
    response = requests.post("https://bsky.social/xrpc/com.atproto.server.createSession",
                             json=auth_body, headers=headers)
    response.raise_for_status()
    access_jwt = response.json()['accessJwt']

    # Add the Authorization header
    headers['Authorization'] = f"Bearer {access_jwt}"

    # Create post data
    record = {
        '$type': "app.bsky.feed.post",
        'text': message,
        'createdAt': created_at
    }
    post_data = {
        'repo': identifier,
        'collection': 'app.bsky.feed.post',
        'record': record
    }

    # Send the post
    post_response = requests.post("https://bsky.social/endpoint_for_posting", json=post_data, headers=headers)
    post_response.raise_for_status()

    print("Post sent successfully")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python post2bsky.py <api_key> <identifier> <message>")
        sys.exit(1)

    api_key = sys.argv[1]
    identifier = sys.argv[2]
    message = sys.argv[3]

    post2bsky(api_key, identifier, message)
