ForEach ($svnDir in (Get-ChildItem $args[0] -Include .svn -recurse -force)) {
  Remove-Item $svnDir -recurse -force
}
