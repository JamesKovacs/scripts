# Validate the the user passed in the correct number of args and
# call Write-Error to print a noticable usage statement if they did not
if ( $Args.Length -ne 2 ) {
    Write-Error "usage: Add-Counters <Computers.txt> <Counters.txt>"
    return
}

# Get the path to where the script lives
$ScriptBase = split-path -parent $myinvocation.mycommand.path

# In the same folder as this .ps1 file should exist the BaseTemplate.txt file
# This file contains much goo required by PerfMon to control various setttings
# You can modify this Template, but save the origional in case you make an invalid change
# Note if the BaseTemplate.txt file is not located, the script will exit with an error
$BaseTemplatePath = Join-Path $ScriptBase "\BaseTemplate.txt"
$BaseTemplateContent = Get-Content $BaseTemplatePath
Write-Output "Base path : $BaseTemplatePath"

# In the same folder as this .ps1 file should also exist the CounterTemplate.txt file
# This file contains much goo required by PerfMon to control various setttings
# You can modify this Template, but save the origional in case you make an invalid change
# Note if the CounterTemplate.txt file is not located, the script will exit with an error
$CounterTemplatePath = Join-Path $ScriptBase "\CounterTemplate.txt"
$CounterTemplateContent = Get-Content $CounterTemplatePath
Write-Output "Counter path : $CounterTemplatePath"

# If we get this far, we believe that we have two parameters which should represent filenames
# for the ComputerList and the CountersList files
$ListOfComputersFile = $Args[0]
$ListOfCountersFile = $Args[1]

# Get the content from the computer and counters files
$ComputerList = Get-Content $ListOfComputersFile
$CounterList = Get-Content $ListOfCountersFile

# Instantiate an ArrayList for us to work with
$CounterCollection = New-Object System.Collections.ArrayList

foreach ( $Computer in $ComputerList ) {
    foreach ( $Counter in $CounterList ) {
        $data = "\\$Computer\$Counter"
        Write-Output "Adding counter : $data"
        $CounterCollection.Add($data)
    }
}

$NumberOfCounters = $CounterCollection.Count
Write-Output "Number of counters : $NumberOfCounters"

$OutputBuffer = ""
$index = 1
$color = 0

foreach ( $item in $CounterCollection) {    
    $indexString = "0000" + $index
    if ($indexString.Length -gt 5 ) {    $indexString = "000" + $index }
    $OutputBuffer += [System.String]::Format($CounterTemplateContent, $item, $indexString, $color)    
    $index += 1
    $color += 10 
}

#format the output
$BaseOutputBuffer = [System.String]::Format($BaseTemplateContent, $NumberOfCounters, $OutputBuffer)
$OutputFile = "temp_" + (Get-Date).ToString("ddMMyyyyhhmmss") + ".xml"
Add-Content $OutputFile $BaseOutputBuffer

#Copy to clip board
$BaseOutputBuffer | clip
Write-Output "Successfully added $NumberOfCounters counters to the clipboard"