# syncronizes content between two folders
# inspired by: https://www.business.com/articles/powershell-sync-folders/

[CmdletBinding()]
Param
(   
    [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Path to source")]
    [ValidateNotNullOrEmpty()]
    [string]$srcFolder,
    [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Destination path to be synced.")]
    [ValidateNotNullOrEmpty()]
    [string]$taregtFolder,
    [switch] $testOnly,
    # if file is missing on src do not delete it on target
    [switch] $doNotDelete 
)

$VerbosePreference = "Continue"
$sourceFiles = Get-ChildItem -Path $srcFolder -Recurse -ErrorAction Stop
$targetFiles = Get-ChildItem -Path $taregtFolder -Recurse -ErrorAction Stop
Compare-Object -ReferenceObject $sourceFiles -DifferenceObject $targetFiles | ForEach-Object {        
    if ($_.SideIndicator -eq '=>') {
        if (! $doNotDelete) {
            Write-Verbose ("Deleting " + $_.InputObject.Fullname)
            if (! $testOnly) {
                Remove-Item -Path $_.InputObject.Fullname -Confirm
            }
        }
    }
    elseif ($_.SideIndicator -eq '<=') {
        Write-Verbose ("Coping " + $_.InputObject.Fullname)
        if (! $testOnly) {
            
        }
    }
}
