Push-Location c:/Utilities/Scripts/posh-git/

# Git utils
. ./GitUtils.ps1
. ./GitPrompt.ps1

# Use Git tab expansion
. ./GitTabExpansion.ps1

Pop-Location

# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    $path = ""
    $pathbits = ([string]$pwd).split("\", [System.StringSplitOptions]::RemoveEmptyEntries)
    if($pathbits.length -eq 1) {
      $path = $pathbits[0] + "\"
    } else {
      $path = $pathbits[$pathbits.length - 1]
    }
    $userLocation = $env:username + '@' + [System.Environment]::MachineName + ' ' + $path
    $host.UI.RawUi.WindowTitle = $userLocation
    Write-Host($userLocation) -nonewline -foregroundcolor Green 
        
    # Git Prompt
    $Global:GitStatus = Get-GitStatus
    Write-GitStatus $GitStatus

    return "> "
}

if(-not (Test-Path Function:\DefaultTabExpansion)) {
    Rename-Item Function:\TabExpansion DefaultTabExpansion
}

# Set up tab expansion and include git expansion
function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1]
    
    switch -regex ($lastBlock) {
        # Execute git tab completion for all git-related commands
        'git (.*)' { GitTabExpansion $lastBlock }
        # Fall back on existing tab expansion
        default { DefaultTabExpansion $line $lastWord }
    }
}

Enable-GitColors

Pop-Location
