# Mark Embling (http://www.markembling.info/)
# http://www.markembling.info/view/my-ideal-powershell-prompt-with-git-integration
# Displays git branch and stats when inside a git repository.

. (Resolve-Path ~/Documents/WindowsPowershell/gitutils.ps1)

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
    
    if (isCurrentDirectoryGitRepository) {
        $status = gitStatus
        $currentBranch = $status["branch"]
        
        Write-Host(' [') -nonewline -foregroundcolor Yellow
        if ($status["ahead"] -eq $FALSE) {
            # We are not ahead of origin
            Write-Host($currentBranch) -nonewline -foregroundcolor Cyan
        } else {
            # We are ahead of origin
            Write-Host($currentBranch) -nonewline -foregroundcolor Red
        }
        Write-Host(' +' + $status["added"]) -nonewline -foregroundcolor Yellow
        Write-Host(' ~' + $status["modified"]) -nonewline -foregroundcolor Yellow
        Write-Host(' -' + $status["deleted"]) -nonewline -foregroundcolor Yellow
        
        if ($status["untracked"] -ne $FALSE) {
            Write-Host(' !') -nonewline -foregroundcolor Yellow
        }
        
        Write-Host(']') -nonewline -foregroundcolor Yellow 
    }
    
	Write-Host('>') -nonewline -foregroundcolor Green    
	return " "
}