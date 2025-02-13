#!/bin/bash

# Ensure that you have the necessary arguments
if [ -z "$1" ]; then
    echo "Please provide a repository name."
    exit 1
fi

REPO_NAME=$1
GITHUB_USERNAME=$(gh api user | jq -r '.login')

if [-z "$GITHUB_USERNAME" ]; then
    echo "Error: Unable to retrieve Github username via gh auth status."
    exit 1
fi

# Use ssh authentication
GITHUB_REPO_URL="git@github.com:$GITHUB_USERNAME/$REPO_NAME.git"

# Create the repository on GitHub using GitHub CLI (gh)
gh repo create "$REPO_NAME" --public
sleep 2

# Enter the cloned repository directory
mkdir "$REPO_NAME"
cd "$REPO_NAME" || exit

# Add an initial README.md file and commit
echo "# $REPO_NAME" > README.md
git init
git add README.md
git commit -m "feat: initial commit"
git remote add origin "$GITHUB_REPO_URL"
git push -u origin main

echo "Repository '$REPO_NAME' created, cloned and initialize"
