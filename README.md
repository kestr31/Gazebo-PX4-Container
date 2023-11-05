# CONTAINERIZED GAZEBO CONTAINER FOR PX4 SITL

## 0. OVERVIEW

- Further documentation will be done.

## 1. AVAIABLE TAGS & BUILD ORDERS

- TBD

## 2. ENVIRONMENT VARIABLE SETUPS

- TBD

## 3. HOW-TO-BUILD

```shell
DOCKER_BUILDKIT=1 docker build \
--build-arg BASEIMAGE=ubuntu \
--build-arg BASETAG=22.04 \
-t kestr3l/gazebo:harmonic \
-f ./Dockerfile .
```

## 4. ATTACHING CONTAINER TO SITL

- TBD