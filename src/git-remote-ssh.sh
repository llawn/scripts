#!/bin/bash

echo "Checking if all remotes are using SSH in the current repository..."

REMOTE_URLS=$(git remote -v | awk '{print $2}' | sort -u)

HAS_HTTPS=false

for URL in $REMOTE_URLS; do
    if [[ "$URL" == https://github.com/* ]]; then
        echo "Warning: Remote github URL '$URL' is using HTTPS instead of SSH."
        HAS_HTTPS=true
    else
        echo "Remote URL '$URL' is correctly using SSH."
    fi
done

# If any HTTPS remotes were found, ask if the user wants to change them
if $HAS_HTTPS; then
    read -p "Do you want to change all HTTPS remotes to SSH? [y/n]: " CHANGE_CONFIRM
    if [[ "$CHANGE_CONFIRM" == "y" || "$CHANGE_CONFIRM" == "Y" ]]; then
        # Loop through each remote URL and update if it's HTTPS
        for URL in $REMOTE_URLS; do
            if [[ "$URL" == https://github.com/* ]]; then
                REMOTE_NAME=$(git remote -v | grep "$URL" | awk '{print $1}' | head -n 1)
                NEW_URL="ssh://git@github.com/$(echo $URL | sed 's|https://github.com/||')"
                echo "Changing remote '$REMOTE_NAME' from HTTPS to SSH..."
                git remote set-url "$REMOTE_NAME" "$NEW_URL"
                echo "Remote '$REMOTE_NAME' updated to '$NEW_URL'."
            fi
        done
    else
        echo "No changes made."
    fi
else
    echo "All remotes are already using SSH."
fi
