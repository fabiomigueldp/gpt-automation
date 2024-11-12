#!/bin/zsh

# Server URL
SERVER_URL="https://json-handler.torbware.space/process"

# Authentication token
AUTH_TOKEN="your_secure_token" # Replace with your actual token

# Capture the text passed to the script via stdin
input_text=$(cat)

# Send the text to the server and capture the response
response=$(echo "$input_text" | curl -s -X POST "$SERVER_URL" \
    -H "Content-Type: text/plain" \
    -H "Authorization: Bearer $AUTH_TOKEN" \
    --data @-)

# Check if there was an error in the request
if [ $? -ne 0 ]; then
    osascript -e 'display notification "Error connecting to the server." with title "Error"'
    exit 1
fi

# Check if the response is empty
if [ -z "$response" ]; then
    osascript -e 'display notification "Empty response from server." with title "Error"'
    exit 1
fi

# Replace the selected text with the response
echo "$response"

# Success notification
osascript -e 'display notification "Text successfully improved!" with title "Success"'
