# PowerShell Git Branch Prompt

Change your PowerShell prompt to note the current git branch.

First, we create a function to get your current branch (if any), and return it with parenthesis.

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

Lastly, we run the native ``prompt`` command to change the prompt.

```powershell
function prompt {
    Get-MyPrompt
}
```

This will act of your current branch, if the code is in your ``$PROFILE``. Example:

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
