ForEach ($cvsDir in (Get-ChildItem $args[0] -Include CVS -recurse -force)) {
  Remove-Item $cvsDir -recurse -force
}
