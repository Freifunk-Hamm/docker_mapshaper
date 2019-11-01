# Dockerized Mapshaper Tools

![Docker Stars](https://img.shields.io/docker/stars/freifunkhamm/mapshaper.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/freifunkhamm/mapshaper.svg)
![Docker Automated](https://img.shields.io/docker/cloud/automated/freifunkhamm/mapshaper)
![Docker Build](https://img.shields.io/docker/cloud/build/freifunkhamm/mapshaper)
![Docker Layers](https://img.shields.io/microbadger/layers/freifunkhamm/mapshaper/latest)
![Docker Image Size](https://img.shields.io/microbadger/image-size/freifunkhamm/mapshaper/latest)

This git repository contains a Dockerfile to dockerize the command line tool "mapshaper", which is a great tool to edit Shapefile, GeoJSON, TopoJSON and CSV files. 

You can find more information about mapshaper at:
* https://github.com/mbloch/mapshaper (source code)
* https://github.com/mbloch/mapshaper/wiki/Command-Reference (documentation)
* https://mapshaper.org/ Mapshape as a WebUI (online editor / online converter)


# Install
Instead of typing a long docker command you can copy a tiny shell script to your PATH:
```
sudo cp mapshaper /usr/local/bin
```

You can operate on files in your current work dir, as you would normally do.
Your work dir is mounted into the docker container for file processing (see script file above: `-v $(pwd):/data`).

Please note that above shell script will download the latest version of this tool, at the point in time, when you run this dockerized tool the first time.
It will not auto-update to the latest version if a new release will become available in the future. You have to run:
`docker image rm freifunkhamm/mapshaper` to delete local cached image and to allow to update to latest version on next run.

If you want to use a specific version you can replace `latest` in the above shell script by a concrete version number.
Available versions are listed here: https://hub.docker.com/r/freifunkhamm/mapshaper/tags

# Run
You can use a dockerized tool similar to a tool that use installed locally to your workstation.

## Show version:
```
mapshaper -v
``` 

## Show help:
```
mapshaper -h
```
This will print you help info about mapshaper. 
There is also a wiki page available: https://github.com/mbloch/mapshaper/wiki/Command-Reference

## Reduce polygon complexity of GeoJSON data
We, at Freifunk, often do not need the high precision of shape data as provided by Open Streetmap Admin Boundaries (https://wambachers-osm.website/boundaries/).
OSM shapes files are often between 25 and 55 KB (and sometimes even greater then 190 KB)  and can be reduced to approximate 6 KB without loosing to mutch details for our needs. This reduces data transmission time but also JavaScript parsing- and rendering-time, especially if you render e.g. more then 70 shapes as Freifunk Münsterland do.

```
mapshaper -i sampleData/hamm.geojson -quiet -simplify percentage=10% -o sampleData/hamm_lowResolution.geojson
```

# Run (without installation)
If you do not want to have this dockerized tool to be in your PATH, you can still run it with:
```
docker run --rm \
    freifunk/mapshaper:latest \
    -v
```

# Contribute / Build your own version
Fork this git repo, change Dockerfile, test it and send us pull request.

# Build your docker image
Before executing `local_build.sh` replace `freifunk/` with your docker hub account name / docker hub organisation name.
```
./local_build.sh
```

