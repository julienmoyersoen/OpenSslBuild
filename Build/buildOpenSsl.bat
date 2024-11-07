@echo off

::single argument is the version of openssl to build
set OPENSSL_VERSION=%1
if "%OPENSSL_VERSION%"=="" (
    echo Usage: buildOpenSsl.bat [openssl version to build]
    exit /b 1
)
set OPENSSL_SOURCE=https://github.com/openssl/openssl/releases/download/openssl-3.0.15/openssl-%OPENSSL_VERSION%.tar.gz

:: Download the openssl sources
echo "Downloading OpenSSL source from: %OPENSSL_SOURCE%..."
curl -SL --output openssl.tar.gz %OPENSSL_SOURCE%

set OPENSSL_SOURCE_DIR=c:\src\openssl

:: Create the source directory
if exist %OPENSSL_SOURCE_DIR% (
    echo Deleting existing source directory: %OPENSSL_SOURCE_DIR%
    rmdir /s /q %OPENSSL_SOURCE_DIR%
)
mkdir %OPENSSL_SOURCE_DIR%

:: Extract the source
echo Extracting OpenSSL source to %OPENSSL_SOURCE_DIR%...
tar -xf openssl.tar.gz -C %OPENSSL_SOURCE_DIR%

:: Create the static build directory
set OPENSSL_BUILD_DIR="c:/src/openssl/openssl-%OPENSSL_VERSION%/static"
mkdir %OPENSSL_BUILD_DIR%

:: Build from static folder
pushd %OPENSSL_BUILD_DIR%

echo Configuring OpenSSL...
perl ..\Configure VC-WIN64A -static

echo Building OpenSSL...
nmake

echo Installing OpenSSL...
nmake install

popd

:: Copy the binaries to the install volume
echo Copying OpenSSL binaries to install volume...
robocopy "c:\Program Files\OpenSSL" "c:\install\OpenSSL" /e /s
rmdir /s /q %OPENSSL_SOURCE_DIR%

:: Cleanup
del /q openssl.tar.gz