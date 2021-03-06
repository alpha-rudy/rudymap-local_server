# rudymap-local_server
RudyMap local server in a Docker container complete with a syncing mirror.

Upstream Links:
* Docker Registry @ rudychung/rudymap-local_server
* GitHub @ alpha-rudy/rudymap-local_server

## Quick Start

* Pick a name for the MAPS_DATA data volume. It's recommended to use the `rudymap-data`.

      MAPS_DATA="rudymap-data"
      MIRROR="rex"  ### or "kcwu"
      LOCAL="10.0.0.4"   ### host IP
      PORT="8080"   ### local port
    
* Initialize the $MAPS_DATA volume that will hold the maps data.

      docker volume create --name $MAPS_DATA
    
* Sync with a choosen mirror `rex` or `kcwu`.

      docker run -v $MAPS_DATA:/mnt/data \
        -e "MIRROR=$MIRROR" \
        -it --rm rudychung/rudymap-local_server \
        sync2local  
    
* Start local server process.

      docker run -v $MAPS_DATA:/mnt/data \
        -p $PORT:80 \
        -e "LOCAL=$LOCAL" \
        -e "PORT=$PORT" \
        -it --rm rudychung/rudymap-local_server \
        startweb
      ### use Ctrl-C to stop local server

* Or do it both (sync and start the local server).

      docker run -v $MAPS_DATA:/mnt/data \
        -p 8080:80 \
        -e "MIRROR=$MIRROR" \
        -e "LOCAL=$LOCAL" \
        -e "PORT=$PORT" \
        -it --name rudymap rudychung/rudymap-local_server
      ### user Ctrl-C to exit or to stop local server
    
* And then next time, simply start it

      docker start -i rudymap
