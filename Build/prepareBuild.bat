@echo off
echo "Preparing build environment..."

echo "Installing the Build Tools for Visual Studio 2019..."
curl -SL --output vs_buildtools.exe https://aka.ms/vs/16/release/vs_buildtools.exe

::Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
(start /w vs_buildtools.exe --quiet --wait --norestart --nocache ^
    --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools" ^
    --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 ^
    || IF "%ERRORLEVEL%"=="3010" EXIT 0)

del /q vs_buildtools.exe 

:: Install Strawberry Perl and add to PATH
echo "Installing Perl..."
curl -SL --output strawberry-perl.zip https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/SP_53822_64bit/strawberry-perl-5.38.2.2-64bit-portable.zip
mkdir C:\Perl
tar -xf strawberry-perl.zip -C C:\Perl
del /q strawberry-perl.zip

:: Install NASM
echo Installing NASM...
curl -o nasm.zip https://www.nasm.us/pub/nasm/releasebuilds/2.16.03/win64/nasm-2.16.03-win64.zip
mkdir c:\NASM
tar -xf nasm.zip -C c:\NASM
del /q nasm.zip

:: Add Perl and NASM to PATH
setx PATH c:\NASM\nasm-2.16.03;C:\Perl\perl\bin;%PATH%

echo "Build environment is ready."
