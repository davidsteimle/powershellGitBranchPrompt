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

function Get-MyPrompt{
    $Prompt = "PS $((Get-Location).Path)$(Get-GitBranch)>"
    $Prompt
}

function prompt {
    Get-MyPrompt
}
