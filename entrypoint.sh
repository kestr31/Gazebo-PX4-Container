#! /bin/bash

debug_message() {
    echo "
        ____  __________  __  ________   __  _______  ____  ______
       / __ \/ ____/ __ )/ / / / ____/  /  |/  / __ \/ __ \/ ____/
      / / / / __/ / __  / / / / / __   / /|_/ / / / / / / / __/   
     / /_/ / /___/ /_/ / /_/ / /_/ /  / /  / / /_/ / /_/ / /___   
    /_____/_____/_____/\____/\____/  /_/  /_/\____/_____/_____/   
    
    "
    echo "INFO [SITL] DEBUG_MODE IS SET. NOTHING WILL RUN"
}


# DIRECTORY TO PX4 gazebo SITL WORLD/MODEL OBJECTS
PX4_GZ_WORLDS=/home/user/PX4-Autopilot/Tools/simulation/gz/worlds
PX4_GZ_MODELS=/home/user/PX4-Autopilot/Tools/simulation/gz/models

# SET GAZEBO RESOURCE PATH
export GZ_SIM_RESOURCE_PATH=${GZ_SIM_RESOURCE_PATH}:${PX4_GZ_MODELS}:${PX4_GZ_WORLDS}:${GZ_SIM_USER_RESOURCE_PATH}


# A. DEBUG MODE / SIMULATION SELCTOR
## CASE A-1: DEBUG MODE
if [ "${DEBUG_MODE}" -eq "1" ]; then

    debug_message

    ## A-1. EXPORT ENVIRONMENT VARIABLE?
    ### CASE A-1-1: YES EXPORT THEM
    if [ "${EXPORT_ENV}" -eq "1" ]; then

        #- GET LINE NUMBER TO START ADDING export STATEMENT
        COMMENT_BASH_START=$(grep -c "" /home/user/.bashrc)
        COMMENT_ZSH_START=$(grep -c "" /home/user/.zshrc)

        COMMENT_BASH_START=$(($COMMENT_BASH_START + 1))
        COMMENT_ZSH_START=$(($COMMENT_ZSH_START + 1))


        #- WTIE VARIABLED TO BE EXPORTED TO THE TEMPFILE
        echo "DEBUG_MODE=0" >> /tmp/envvar
        echo "GZ_SIM_RESOURCE_PATH=${GZ_SIM_RESOURCE_PATH}" >> /tmp/envvar

        #- ADD VARIABLES TO BE EXPORTED TO SHELL RC
        for value in $(cat /tmp/envvar)
        do
            echo ${value} >> /home/user/.bashrc
            echo ${value} >> /home/user/.zshrc
        done

        #- ADD export STATEMENT TO VARIABLES
        sed -i "${COMMENT_BASH_START},\$s/\(.*\)/export \1/g" \
            ${HOME}/.bashrc
        sed -i "${COMMENT_ZSH_START},\$s/\(.*\)/export \1/g" \
            ${HOME}/.zshrc

        #- REMOVE TEMPORARY FILE
        rm -f /tmp/envvar

    ### CASE A-1-2: NO LEAVE THEM CLEAN
    else
        echo "INFO [SITL] ENVIRONMENT VARS WILL NOT BE SET"
    fi


## CASE A-2: SIMULATION MODE
else

    echo "INFO [SIM] RUNNING gazebo SIMULATOR"

    ## A-2. CHECK IF USER IS USING WSLg OR NOT
    ### CASE A-2-1: USER IS USING WSLg
    if [ -d "/mnt/wslg" ]; then

        echo "INFO [SIM] DETECTED WSLg! USE ogre1 FOR RENDERING GAZEBO"
        gz sim -r --render-engine ogre ${PX4_GZ_WORLDS}/default.sdf
    
    ### CASE A-2-2: NO WSLg DETECTED
    else

        echo "INFO [SIM] USE ogre2 FOR RENDERING GAZEBO"
        gz sim -r -s ${PX4_GZ_WORLDS}/default.sdf &

        if [ "${HEADLESS}" -ne "1" ]; then
            gz sim -g
        fi
    fi

fi

# KEEP CONTAINER ALIVE
sleep infinity