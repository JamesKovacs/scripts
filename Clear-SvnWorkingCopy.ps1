# CleanSvnWorkingCopy v1.21
# Copyright © 2008 by James Kovacs
# All rights reserved.
# THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
# ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
# TO THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND/OR FITNESS FOR A
# PARTICULAR PURPOSE.

if($args.Length -ne 0) {
  $repoPath = $args[0]
} else {
  $repoPath = '.'
}

$unversionedList = (svn status --no-ignore $repoPath)

if($unversionedList -eq $null) {
  return
}

foreach($unversioned in $unversionedList) {
  $splitLine = $unversioned.Split(" ", [StringSplitOptions]::RemoveEmptyEntries)
  $status = $splitLine[0]
  $entry = $splitLine[1]
  if($status -eq '?' -or $status -eq 'I') {
    Remove-Item "$entry" -recurse -force
    Write-Host "Removed $entry"
  } else {
    Write-Host "Skipped $entry"
  }
}

Write-Host 'Cleaned SVN working copy'