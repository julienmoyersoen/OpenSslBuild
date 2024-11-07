# escape=`

# Use the latest Windows Server Core 2022 image.
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# This is where our build output will be shared.
VOLUME C:/install

# Import the build script to the container. deleting it in RUN step. It is hacky but it works.
COPY prepareBuildEnv.bat c:/temp/prepareBuildEnv.bat

# Prepare the build environment.
RUN C:\temp\prepareBuildEnv.bat `
    && del c:\temp\prepareBuildEnv.bat

# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Auxiliary\\Build\\vcvars64.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
