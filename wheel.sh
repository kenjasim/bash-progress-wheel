#!/bin/bash
# Deploy the infrastructure components needed for a KMO Deployment 
set -e
####################
# VARIABLES
####################

# Colours
GREEN='\033[0;32m'
YELLOW='\033[33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
GREY='\033[37m'
NC='\033[0m'

# Kubernetes Specific
LOG_FILE="/tmp/deploy.log"


#########################
# FUNCTIONS
#########################

#######################################
# Prints the progress wheel when doing
# a task
# Arguments
# 1: pid of the task which is running
# 2: Message to write
# 3: Colour variable
#######################################
utils::print_progress(){
    i=1
    sp="/-\|"

    pid=$1
    message=$2

    # While the process is still running make sure the progres wheel is spinning
    while kill -0 $pid 2>/dev/null;
    do   
        # Set the column length to allow the spinning progress wheel to be on 
        # The right of the screen
        column_length=$(( $(tput cols) -  ${#message} - 1 ))
        printf "${CYAN}\r$message %${column_length}s\033[0m" "[${sp:i++%${#sp}:1}]"
        sleep 0.1
    done

    # Exit the script if the process failed
    if ! wait $pid; then
        echo "process $pid failed"
        exit 1
    fi 
}

#######################################
# Run the script
# Arguments
# 1 - the first argument
#######################################
main(){
    sleep 5 & pid=$!
    utils::print_progress $pid "Sleeping" 
}

#################################################
# MAIN
#################################################

main

