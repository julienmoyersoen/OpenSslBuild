# OpenSslBuild
Docker setup to build Open SSL

docker build -t opensslbuilder -m 2GB .
docker run --name build2 -it --mount source=installVolume,target=c:\install opensslbuilder