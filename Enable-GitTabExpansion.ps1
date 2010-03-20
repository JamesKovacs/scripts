# git tab expansion by Jeremy Skinner
# http://www.jeremyskinner.co.uk/2010/03/07/using-git-with-windows-powershell/
function TabExpansion($line, $lastWord) {
  $LineBlocks = [regex]::Split($line, '[|;]')
  $lastBlock = $LineBlocks[-1] 
 
  switch -regex ($lastBlock) {
    'git (.*)' { gitTabExpansion($lastBlock) }
  }
}

function gitTabExpansion($lastBlock) {
     switch -regex ($lastBlock) {
 
        #Handles git branch -x -y -z <branch name>
        'git branch -(d|D) (\S*)$' {
          gitLocalBranches($matches[2])
        }
 
        #handles git checkout <branch name>
        #handles git merge <brancj name>
        'git (checkout|merge) (\S*)$' {
          gitLocalBranches($matches[2])
        }
 
        #handles git <cmd>
        #handles git help <cmd>
        'git (help )?(\S*)$' {      
          gitCommands($matches[2])
        }
 
        #handles git push remote <branch>
        #handles git pull remote <branch>
        'git (push|pull) (\S+) (\S*)$' {
          gitLocalBranches($matches[3])
        }
 
        #handles git pull <remote>
        #handles git push <remote>
        'git (push|pull) (\S*)$' {
          gitRemotes($matches[2])
        }
    }	
}

function gitCommands($filter) {
  $cmdList = @()
  $output = git help
  foreach($line in $output) {
    if($line -match '^   (\S+) (.*)') {
      $cmd = $matches[1]
      if($filter -and $cmd.StartsWith($filter)) {
        $cmdList += $cmd.Trim()
      }
      elseif(-not $filter) {
        $cmdList += $cmd.Trim()
      }
    }
  }
 
  $cmdList | sort
 }
 
function gitRemotes($filter) {
  if($filter) {
    git remote | where { $_.StartsWith($filter) }
  }
  else {
    git remote
  }
}
 
function gitLocalBranches($filter) {
   git branch | foreach { 
      if($_ -match "^\*?\s*(.*)") { 
        if($filter -and $matches[1].StartsWith($filter)) {
          $matches[1]
        }
        elseif(-not $filter) {
          $matches[1]
        }
      } 
   }
}