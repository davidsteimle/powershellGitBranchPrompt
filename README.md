# PowerShell Git Branch Prompt

Change your PowerShell prompt to note the current git branch.

-----

First, we create a function to get your current branch (if any), and return it with parenthesis. The variable ``$Query`` is function scoped, so if the user already has a variable assigned it will not influence this functionality.

```powershell
function Get-GitBranch{
    if(Get-Item .git -Force -ErrorAction Ignore){
        # this is a repo
        $Query = git branch --show
    } else {
        # this is not a repo
    }
    if($Query){
        " ($Query)"
    }
}
```


Next, we need to build the new prompt.

```powershell
function Get-MyPrompt{
    $Prompt = "PS $((Get-Location).Path)$(Get-GitBranch)>"
    $Prompt
}
```

Lastly, we modify the native ``prompt`` function to change the prompt.

```powershell
function prompt {
    Get-MyPrompt
}
```

This will act on your current branch, if the code is in your ``$PROFILE``. Example:

```
PS C:\Users\steimle\bin\onDemandToast (main)>git branch
* main
  test
PS C:\Users\steimle\bin\onDemandToast (main)>git checkout test
Switched to branch 'test'
M       CreateToast.ps1
M       README.md
PS C:\Users\steimle\bin\onDemandToast (test)>cd ..
PS C:\Users\steimle\bin>
```

Directory ``C:\Users\steimle\bin\onDemandToast`` is a repository, but ``C:\Users\steimle\bin`` is not. The error handling in ``Get-Branch``  prevents the prompt from trying to display a branch if no branch is present.

Works on my Ubuntu server with pwsh7 as well:

```
PS /home/david/bin/update (main)>git branch       
* main
  test
PS /home/david/bin/update (main)>git checkout test
Switched to branch 'test'
PS /home/david/bin/update (test)>
PS /home/david/bin/update (test)>cd ..
PS /home/david/bin>
PS /home/david/bin>$PSVersionTable

Name                           Value
----                           -----
PSVersion                      7.1.3
PSEdition                      Core
GitCommitId                    7.1.3
OS                             Linux 5.4.0-74-generic #83-Ubuntu SMP Sat May 8 02:35:39 UTC 2021
Platform                       Unix
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
WSManStackVersion              3.0
```
