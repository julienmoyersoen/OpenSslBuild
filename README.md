# OpenSslBuild
This is a docker setup to build Open SSL

# To build the image from the dockerFile instructions:
docker build -t opensslbuilder -m 2GB .

# To run the image in a new container:
docker run --name build2 -it --mount source=installVolume,target=c:\install opensslbuilder

# To restart the container (with native cmd as entry point):
docker start -i openSslContainer