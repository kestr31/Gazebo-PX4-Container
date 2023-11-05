#! /bin/bash

PX4_GZ_WORLDS=/home/user/PX4-Autopilot/Tools/simulation/gz/worlds
PX4_GZ_WORLD=default

gz sim ${PX4_GZ_WORLDS}/${PX4_GZ_WORLD}.sdf --render-engine ogre

model_pose="0,0,0,0,0,0"
PX4_GZ_MODEL=/home/user/PX4-Autopilot/Tools/simulation/gz/models
PX4_GZ_MODEL_NAME=x500

# HEADLESS
# gz sim ${PX4_GZ_WORLDS}/${PX4_GZ_WORLD}.sdf --headless-rendering -s &
# gz sim -g --render-engine ogre 

# GZ_RELAY=172.21.0.6 GZ_IP=172.21.0.5 GZ_PARTITION=relay gz topic -e -t /foo
# GZ_RELAY: GAZEBO-IP GZ_IP: PX4-IP
# GZ_RELAY: Where Publisher is(Gazebo) GZ_IP: Where Subscriber is(PX4)
