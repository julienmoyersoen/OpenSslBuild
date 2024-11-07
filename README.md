# OpenSslBuild
This is a docker setup to build Open SSL

# To build the image from the dockerFile instructions:
docker build -t opensslbuilder -m 2GB .

# To run the image in a new container:
docker run --name openSslContainer -it `
--mount source=installVolume,target=c:\install `
--mount type=bind,source=.\buildScripts,target=c:\buildScripts opensslbuilder

# To restart the container (with native cmd as entry point):
docker start -i openSslContainer

# From container console start the openssl build
.\buildScripts\builOpenSsl.bat <version>

# Then you can compile curl
.\buildScripts\buildCurl.bat <version>