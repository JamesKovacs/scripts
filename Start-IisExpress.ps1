param(
  $dir = '.'
)
$absoluteDirectory = resolve-path $dir
& "${env:ProgramFiles(x86)}\IIS Express\iisexpress.exe" /path:$absoluteDirectory
