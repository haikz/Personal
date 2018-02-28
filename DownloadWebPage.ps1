<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-WebPage
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [String]$TestFolder,
        [Parameter(Mandatory=$true)]
        [String]$SourcePage
    )

    Begin
    {
    }
    Process
    {
        if (!(Test-Path($TestFolder)))
        {
            mkdir $TestFolder
            Write-Verbose "New folder created";
        }
        $web = New-Object System.Net.WebClient
        $web.DownloadFile($SourcePage, "$TestFolder\index.html")
    }
    End
    {
    }
}
# https://www.autoleht.ee/ostujuht/arvustused
# Get-WebPage ".\autoleht" "https://www.autoleht.ee/ostujuht/arvustused" -Verbose