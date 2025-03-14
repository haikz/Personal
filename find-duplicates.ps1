$url = "I:\Pildid"
$destination = "I:\Ajutine\Duplicates"
$pics = Get-ChildItem -Path $url -Recurse -Include '*(1)*'
$ErrorActionPreference = "stop"
foreach ($pic in $pics) {
    #$pic = $pics[0]
    #$pic | select *
    $pic.DirectoryName.split("\")[2]
    $desUrl = $destination + $pic.DirectoryName.Replace("I:\Pildid", "")
    if (! (Test-Path $desUrl)) {
        $null = New-Item -Path $desUrl -ItemType Directory
    }
    Move-Item -Path $pic.FullName -Destination $desUrl
    Write-Host "moved $($pic.FullName)" -ForegroundColor Green
}