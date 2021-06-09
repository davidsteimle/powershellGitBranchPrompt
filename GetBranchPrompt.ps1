function Get-Branch{
    try{
        $(git branch).ForEach(
            {
                if($PSItem -match "\*"){
                    $Branch = $PSItem -replace "\* ",""
                    $Branch
                }
            }
        )
    }catch{

    }
}

function Get-MyPrompt{
    $Prompt = "PS $((Get-Location).Path)$(Get-GitBranch)>"
    $Prompt
}

function prompt {
    Get-MyPrompt
}
