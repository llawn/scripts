#!/bin/bash

# Ensure that you have the necessary arguments
if [ -z "$1" ]; then
    echo "Please provide a repository name."
    exit 1
fi

REPO_NAME=$1
GITHUB_USERNAME=$(gh auth status 2>&1 | grep "Logged in as" | awk '{print $4}')
GITHUB_REPO_URL="git@github.com:$GITHUB_USERNAME/$REPO_NAME.git"

# Initialize the git repository locally
git init

# Create the repository on GitHub using GitHub CLI (gh)
gh repo create "$REPO_NAME" --public --confirm

# Add the remote to the local repository
git remote add origin "$GITHUB_REPO_URL"

# Clone the repository (you can use 'git clone' directly or choose not to in this case)
git clone "$GITHUB_REPO_URL"

# Enter the repository directory and push the initial commit
cd "$REPO_NAME"
git add .
git commit -m "Initial commit"
git push -u origin master

echo "Repository $REPO_NAME created and pushed to GitHub!"
