#!/bin/bash

# Define the menu options
options=(
  "Option 1"
  "Option 2"
  "Option 3"
  "Quit"
)

# Loop until the user selects the "Quit" option
while true; do
  # Clear the screen
  clear

  # Display the menu options
  echo "=== MENU ==="
  echo

  for i in "${!options[@]}"; do
    echo "$((i + 1)). ${options[$i]}"
  done

  echo

  # Prompt the user to select an option
  echo -n "Enter your choice (or q to quit): "
  read -r choice

  # Check if the input is a valid option or the quit command
  if [[ "$choice" =~ ^[0-9]+$ ]] && ((choice >= 1 && choice <= ${#options[@]})); then
    case $choice in
    1)
      echo "You selected Option 1"
      # Add your Option 1 code here
      ;;

    2)
      echo "You selected Option 2"
      # Add your Option 2 code here
      ;;

    3)
      echo "You selected Option 3"
      # Add your Option 3 code here
      ;;

    4)
      echo "Goodbye!"
      break
      ;;

    *) ;;
    esac
  elif [[ "$choice" = "q" || "$choice" = "Q" ]]; then
    echo "Goodbye!"
    break
  else
    echo "Invalid option. Try again."
    sleep 1
  fi
done
