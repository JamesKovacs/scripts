$physDir = resolve-path $args
& "${env:CommonProgramFiles}\microsoft shared\DevServer\10.0\WebDev.WebServer40.exe" /port:8080 /path:$physDir /vpath: 
