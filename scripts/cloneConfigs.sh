#!/bin/bash

echo "Starting system config cloning"

echo "Let's log into github"

# Authenticate with GitHub using gh cli
if ! gh auth login; then
  echo "Error: Failed to authenticate with GitHub. Exiting."
  exit 1
fi

echo "Let's start cloning!"

# Function to clone a repository, create directories if they don't exist, and handle errors
clone_repo() {
  local repo_name="$1"
  local destination_dir="$2"

  # Create the destination directory if it doesn't exist
  if [ ! -d "$destination_dir" ]; then
    echo "Creating directory: $destination_dir"
    mkdir -p "$destination_dir" || { echo "Error: Failed to create directory $destination_dir. Exiting."; exit 1; }
  fi

  # Clone the repository
  echo "Cloning $repo_name to $destination_dir"
  gh repo clone "$repo_name" "$destination_dir" || { echo "Error: Failed to clone $repo_name to $destination_dir. Exiting."; exit 1; }
}

# Clone the repositories with error handling and directory creation
clone_repo nvim ~/config
clone_repo alacritty ~/config
clone_repo fish ~/config
clone_repo foot ~/config
clone_repo WPs ~/Pictures
clone_repo variety ~/config
clone_repo fastfetch ~/config

echo "System config cloning complete!"
exit 0
