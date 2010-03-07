if($args.Length -ne 2) {
  Write-Host "Usage: SvnAll.ps1 <svn-command> <directory>"
  Write-Host "  where <svn-command> is any valid Subversion command"
  Write-Host "    and <directory> is the parent directory of the working copies"
  Exit(0)
}

ForEach ($svnDir in (Get-ChildItem $args[1] | where-object { $_.PSIsContainer })) {
  Write-Host "Performing action on $svnDir..."
  svn $args[0] $svnDir.FullName
}
