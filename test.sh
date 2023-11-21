#!/bin/bash

set -e

notify () {
  echo "--------------------------------------------------------------------"
  echo $1
  echo "--------------------------------------------------------------------"
}


# Define the sections
sections=("Docker" "Cleanup" "ZSH & OhMyZSH" "SSH" "VSCode" "GitHub Desktop")

# Display the menu
echo "Please enter the numbers of the sections you want to install (separated by spaces):"
for i in "${!sections[@]}"; do 
     echo "$((i+1))) ${sections[$i]}"
done

# Read the user's selections
read -a selections

# Convert the selections to zero-based indexing
for i in "${!selections[@]}"; do
     selections[$i]=$((selections[$i]-1))
done

# Check if a section is in the array of selections
function is_selected {
     local section=$1
     for selected in "${selections[@]}"; do
          if [[ $selected -eq $section ]]; then
               return 0
          fi
     done
     return 1
}

# Docker
# ---------------------------
if is_selected 0; then
     notify "Docker"
     # Docker installation commands...
fi

# Cleanup
# ---------------------------
if is_selected 1; then
     notify "Cleanup"
     # Cleanup commands...
fi

# ZSH & OhMyZSH
# ---------------------------
if is_selected 2; then
     notify "ZSH & OhMyZSH"
     # ZSH & OhMyZSH installation commands...
fi

# SSH
# ---------------------------
if is_selected 3; then
     notify "SSH"
     # SSH setup commands...
fi

# VSCode
# ---------------------------
if is_selected 4; then
     notify "VSCode"
     # VSCode installation commands...
fi

# GitHub Desktop
# ---------------------------
if is_selected 5; then
     notify "GitHub Desktop"
     # GitHub Desktop installation commands...
fi