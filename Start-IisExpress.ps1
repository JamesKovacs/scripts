$physDir = resolve-path $args
& "${env:ProgramFiles(x86)}\IIS Express\iisexpress.exe" /path:$physDir
