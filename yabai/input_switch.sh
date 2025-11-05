#!/bin/bash

APP_NAME=$(yabai -m query --windows --window | jq -r '.app')

# Replace these with your input sources
ENGLISH="com.apple.keylayout.US"
VIETNAMESE="com.apple.inputmethod.VietnameseIM.VietnameseSimpleTelex"

if [ "$APP_NAME" = "Messages" ]; then
  im-select "$VIETNAMESE"
else
  im-select "$ENGLISH"
fi