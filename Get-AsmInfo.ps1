param(
  $file= $(throw "An assembly file name is required.")
)

$fullpath = (Get-Item $file).FullName
$assembly = [System.Reflection.Assembly]::ReflectionOnlyLoadFrom($fullpath)

# Get name, version and display the results
$name = $assembly.GetName()
$version =  $name.version
"{0} [{1}]" -f $name.name, $version