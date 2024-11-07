@echo off

::single argument is the version of curl to build
set CURL_VERSION=%1
if "%CURL_VERSION%"=="" (
    echo Usage: buildCurl.bat [curl version to build]
    exit /b 1
)

set CURL_SOURCE=https://curl.se/download/curl-%CURL_VERSION%.tar.gz

:: Download the curl sources
echo "Downloading Curl source from: %CURL_SOURCE%..."
curl -SL --output curl.tar.gz %CURL_SOURCE%

set CURL_SOURCE_DIR=c:\src\curl

:: Create the source directory
if exist %CURL_SOURCE_DIR% (
    echo Deleting existing source directory: %CURL_SOURCE_DIR%
    rmdir /s /q %CURL_SOURCE_DIR%
)
mkdir %CURL_SOURCE_DIR%

:: Extract the source
echo Extracting Curl source to %CURL_SOURCE_DIR%...
tar -xf curl.tar.gz -C %CURL_SOURCE_DIR%

:: Create deps folder structure
set CURL_DEPS_DIR=c:\src\curl\deps
mkdir %CURL_DEPS_DIR%
mkdir %CURL_DEPS_DIR%\include
mkdir %CURL_DEPS_DIR%\lib
mkdir %CURL_DEPS_DIR%\bin

::Copy the openssl files from install volume to the deps folder
robocopy "c:\install\OpenSSL\include" "%CURL_DEPS_DIR%\include" /e /s
robocopy "c:\install\OpenSSL\lib" "%CURL_DEPS_DIR%\lib" /e /s

:: Build from the winbuild directory
pushd %CURL_SOURCE_DIR%\curl-%CURL_VERSION%\winbuild
nmake /f Makefile.vc mode=static VC=16 WITH_SSL=static MACHINE=x64 GEN_PDB=yes  WITH_DEVEL=..\..\deps\
popd

