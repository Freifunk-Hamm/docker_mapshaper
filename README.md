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
You can find the ready-to-use docker image at docker hub:
https://hub.docker.com/r/freifunkhamm/mapshaper

Pull the image with:
```
docker pull freifunkhamm/mapshaper
```

# Run
You can use a dockerized tool similar to a tool that use installed locally to your workstation.

## Show version:
```
docker run --rm \
    freifunk/mapshaper:latest \
    -v
```

# Alias
Instead of typing such an amount wouldn't it be cool to just type `mapshaper -v` as if it where installed via a package manager?
Just add this to your shell profile (e.g. at the last line of that file):
```
alias mapshaper="docker run --rm -v $(pwd):/data freifunk/mapshaper:latest"
```
Depending on which shell you are using your profile file is e.g. one of these:
* ~/.zshrc
* ~/.bashrc
* ~/.profile

It will become automatically active for every new terminal. 
For current active terminal you can just type `source ~/.bashrc` etc. to make the changes active.

`-v $(pwd):/data` mounts your current working dir into that docker container, so you can always operate on files of your current work directory if you use this alias.

We recommend to use a specific version number instead of "latest" to ensure that no "unintended" change will effect you.
Available versions are listed here: https://hub.docker.com/r/freifunkhamm/mapshaper/tags

## Show help:
(When you have setup an alias. See above.)
```
mapshaper -h
```
This will print you help info about mapshaper. 
There is also a wiki page available: https://github.com/mbloch/mapshaper/wiki/Command-Reference

## Reduce polygon complexity of GeoJSON data
We, at Freifunk, often do not need the high precision of shape data as provided by Open Streetmap Admin Boundaries (https://wambachers-osm.website/boundaries/).
OSM shapes files are often between 25 and 55 KB and and can be reduced to approximate 6 KB without loosing to mutch details for our needs. This reduces data transmission time but also JavaScript parsing- and rendering-time, especially if you render e.g. more then 70 shapes as Freifunk Münsterland do.

```
mapshaper -i sampleData/hamm.geojson -quiet -simplify percentage=10% -o sampleData/hamm_lowResolution.geojson
```
# Contribute / Build your own version
Fork this git repo, change Dockerfile, test it and send us pull request.

# Build your docker image
Before executing `local_build.sh` replace `freifunk/` with your docker hub account name / docker hub organisation name.
```
./local_build.sh
```

