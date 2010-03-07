# CleanSolution v1.10
# Copyright © 2007 by James Kovacs
# All rights reserved.
# THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
# ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
# TO THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND/OR FITNESS FOR A
# PARTICULAR PURPOSE.

If($args.Length -ne 0) {
  $slnPath = $args[0]
} Else {
  $slnPath = .
}

$slnFile = Join-Path $slnPath '*.sln'

If(!(Test-Path $slnFile)) {
  Write-Host "Error: No .sln files found."
  Exit(-1)
}

ForEach ($item in (Get-ChildItem $slnPath -include *.user, *.resharper, *.suo, *.gpstate, _ReSharper.*, bin, obj -exclude thirdparty -recurse -force)) {
  Remove-Item $item -recurse -force
}

Write-Host "Cleaned solution"
