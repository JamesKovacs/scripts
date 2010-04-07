param($framework = '4.0')

if ($framework.Length -ne 3 -and $framework.Length -ne 6) {
  throw "Error: Invalid .NET Framework version, $framework, specified"
}
$versionPart = $framework.Substring(0,3)
$bitnessPart = $framework.Substring(3)

$programFiles = $null
$ptrSize = [System.IntPtr]::Size
switch ($ptrSize)
{
  4 { 
    switch ($bitnessPart)
    {
      'x86' { $programFiles = $env:ProgramFiles }
      $null { $programFiles = $env:ProgramFiles }
      default { throw "Error: Unknown .NET Framework bitness, $bitnessPart, specified in $framework" }
    }
  }
  8 { 
    switch ($bitnessPart)
    {
      'x86' { $programFiles = (Get-Item 'env:ProgramFiles(x86)').Value }
      'x64' { $programFiles = $env:ProgramFiles }
      $null { $programFiles = $env:ProgramFiles }
      default { throw "Error: Unknown .NET Framework bitness, $bitnessPart, specified in $framework" }
    }
  }
  default { throw "Error: Unknown pointer size ($ptrSize) returned from System.IntPtr." }
}

$snoopDir = $null
switch ($versionPart)
{
  '3.0' { $snoopDir = 'Snoop' }
  '3.5' { $snoopDir = 'Snoop' }
  '4.0' { $snoopDir = 'SnoopWPF4' }
  default { throw "Error: Unknown .NET Framework version, $versionPart, specified in $framework" }
}

& (join-path (join-path $programFiles $snoopDir) 'Snoop.exe')