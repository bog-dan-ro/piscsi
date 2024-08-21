#/bin/sh

docker run --rm -v $PWD/../:/home/pi/piscsi --network="host" -it piscsi_arm64
