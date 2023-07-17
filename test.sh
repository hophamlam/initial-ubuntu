#!/bin/bash

# Define the menu options
options=(
  "Install new non-root user with SSH key login and disable root access..."
  "Install Docker and Docker-compose"
  "Option 3"
  "Quit"
)

# Define formatting characters
bold=$(tput bold)
normal=$(tput sgr0)
underline=$(tput smul)
reset_underline=$(tput rmul)

# Set the prompt and menu colors
PS3="$(tput setaf 6)$(tput bold)Enter your choice:$(tput sgr0) "
menu_color=$(tput setaf 4)
selected_color=$(tput setaf 2)s
error_color=$(tput setaf 1)

# Loop until the user selects the "Quit" option
while true; do
  # Clear the screen
  clear

  # Display the menu options
  echo "$(tput setaf 3)$(tput bold)=== MENU ===$(tput sgr0)"
  echo

  for i in "${!options[@]}"; do
    if [[ $((i + 1)) -eq $REPLY ]]; then
      printf "%s%s) %s%s\n" "$selected_color" "$((i + 1))" "${options[$i]}" "$normal"
    else
      printf "%s%s) %s%s\n" "$menu_color" "$((i + 1))" "${options[$i]}" "$normal"
    fi
  done

  echo

  # Prompt the user to select an option
  read -r -p "$(tput bold)$(tput setaf 6)Enter your choice (or q to quit):$(tput sgr0) " choice

  # Check if the input is a valid option or the quit command
  if [[ "$choice" =~ ^[0-9]+$ ]] && ((choice >= 1 && choice <= ${#options[@]})); then
    case $choice in
    1)
      echo "You selected ${bold}Option 1${normal}"
      echo "Installing new non-root user with SSH key login and disabling root..."
      git clone https://github.com/jasonheecs/ubuntu-server-setup.git && bash ./ubuntu-server-setup/setup.sh && rm -rf ./ubuntu-server-setup
      ;;

    2)
      echo "You selected ${bold}Option 2${normal}"
      curl -fsSL https://get.docker.com | bash
      ;;

    3)
      echo "You selected ${bold}Option 3${normal}"
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
    echo "${error_color}Invalid option. Try again.${normal}"
    sleep 1
  fi
done
