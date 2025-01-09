#!/bin/bash

BOLD='\033[1m'
UNDERLINE='\033[4m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color (reset)
YELLOW_ON_WHITE='\033[1;33m\033[47m'
YELLOW_ON_BLACK='\033[1;33m\033[0;30m'

script_dir="$(pwd)"

cd /var/log || { echo -e "${RED}Failed to change directory to /var/log${NC}"; exit 1; }

echo -e "${MAGENTA}Summary of Unsuccessful Login Attempts${NC}  | ${MAGENTA} $(pwd)/auth.log${NC}"

echo -e "${YELLOW}Timestamp (ISO 8601 format)\t\tLogin Name\tLogin Terminal\tLogin User\tRemote User\tRemote Host${NC}"
cat auth.log | grep "authentication failure" | awk '{print $1 "\t" $7 "\t""\t" $10 "\t" $13 "\t" $11 "\t" $12}' | \
 sort -n | sed -e 's/rhost=//g' -e 's/ruser=//g' -e 's/logname=//g' -e 's/tty=//g' -e 's/user=//g' | head 

echo -e "${CYAN}Do you want the output in txt or csv format?${NC}"
read -r format

if [[ "$format" != "txt" && "$format" != "csv" ]]; then
  echo -e "${RED}Invalid format. Please choose either 'txt' or 'csv'.${NC}"
  exit 1
fi

output_file="$script_dir/unsuccessful_login_attempts.$format"

login_data=$(cat auth.log | grep "authentication failure" | \
awk '{print $1 "\t" $7 "\t""\t" $10 "\t" $13 "\t" $11 "\t" $12}' | \
sort -n | sed -e 's/rhost=//g' -e 's/ruser=//g' -e 's/logname=//g' -e 's/tty=//g' -e 's/user=//g')

cd

if [ "$format" == "txt" ]; then
  # Write to a .txt file with tab-separated values
  echo -e "Timestamp (ISO 8601 format)\t\tLogin Name\tLogin Terminal\tLogin User\tRemote User\tRemote Host" > "$output_file"
  echo -e "$login_data" >> "$output_file"
  echo -e "${GREEN}The data were successfully written to $output_file${NC}"
elif [ "$format" == "csv" ]; then
  # Write to a .csv file with comma-separated values
  echo "Timestamp,Login Name,Login Terminal,Login User,Remote User,Remote Host" > "$output_file"
  echo -e "$login_data" | awk '{print $1","$2","$3","$4","$5","$6}' >> "$output_file"
  echo -e "${GREEN}The data were successfully written to $output_file${NC}"
fi
