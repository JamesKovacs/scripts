# CreateSvnRepo v1.21
# Copyright © 2007 by James Kovacs
# All rights reserved.
# THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
# ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
# TO THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND/OR FITNESS FOR A
# PARTICULAR PURPOSE.

# Check usage
If($args.Length -ne 1) {
  Write-Host "Usage: .\CreateSvnRepo.ps1 <RepoName>"
  Write-Host "  where RepoName is the name of the new repository"
  Write-Host "N.B. RepoName cannot accept a file path or url."
  Write-Host "     CreateSvnRepo assumes that svn and svnadmin are in your path."
  Exit(0)
}

# Set up variables needed by script
$newRepoName = $args[0]
$currentWorkingDir = (Get-Location).Path.Replace("\", "/")
$newRepoSvnPath = "file:///$currentWorkingDir/$newRepoName"
$repoConfigDirectory = Join-Path $newRepoName 'conf'
$repoConfigFile = Join-Path $repoConfigDirectory 'svnserve.conf'
$tempPath = [System.IO.Path]::GetTempPath()
$tempDirName = [System.IO.Path]::GetRandomFileName()
$workingCopy = Join-Path $tempPath $tempDirName
$dirNames = 'branches', 'tags', 'trunk'

# Ensure that we were passed only a repository name and not a path
$invalidChars = [System.IO.Path]::GetInvalidFileNameChars()
If($newRepoName.IndexOfAny($invalidChars) -ne -1) {
  Write-Host "You must specify a valid repository name. It cannot be an absolute or relative path."
  Exit(-1)
}

# Ensure that repository doesn't already exist
If(Test-Path $newRepoName) {
  Write-Host "Error: Repository, $newRepoName, already exists."
  Exit(-1)
}

# Create directory to hold the new repository
Write-Host "Creating new repository: $newRepoName"
New-Item -path . -name $newRepoName -type directory
If(!(Test-Path $newRepoName)) {
  Write-Host "Unable to create directory, $newRepoName. Verify that you have permission to create this directory."
  Exit(-1)
}

# Create the repository
svnadmin create $newRepoName

# Clear repo configuration directory
$configFiles = Get-ChildItem -path $repoConfigDirectory
ForEach ($configFile in $configFiles) {
  Remove-Item -path $configFile.FullName
}

# Overwrite configuration file to point to global password directory
"[general]`r`nanon-access=none`r`npassword-db=../../passwd`r`nrealm=Default`r`n" | Out-File -filePath $repoConfigFile -encoding ASCII

# Create a temporary working copy so we can commit initial setup in one go
Write-Host "Creating temporary working copy in $workingCopy"
New-Item -path $tempPath -name $tempDirName -type directory
svn checkout --non-interactive $newRepoSvnPath $workingCopy

Write-Host "Creating directories in working copy"
ForEach ($dirName in $dirNames) {
  $path = Join-Path $workingCopy $dirName
  svn mkdir $path
}

# Commit changes to the repository
Write-Host "Committing changes"
svn commit $workingCopy --message "Initial repository setup"

# Perform cleanup
Write-Host "Cleaning up working copy"
Remove-Item -path $workingCopy -recurse -force