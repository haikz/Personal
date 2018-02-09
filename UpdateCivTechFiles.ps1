# Modifies CIV 5 technologies costs
$civInstallationUrl = "C:\Games\Civilization V";
[decimal]$multiplier = 1.4;
[bool]$ExcludeAncientEra = $true;


$files = Get-ChildItem -Path $civInstallationUrl -Include "CIV5Technologies.xml" -Recurse;

foreach($file in $files){       
    [xml]$XmlDocument = Get-Content -Path $file.FullName;
    $Technologies = $XmlDocument.GameData.Technologies.Row;
    foreach ($tech in $Technologies){        
        if ($tech.Era -ne "ERA_ANCIENT" -or -not $ExcludeAncientEra) {            
            [int]$currCost = [convert]::ToInt32($tech.Cost);
            $newCost = [math]::Round($currCost * $multiplier);
            $tech.Cost = $newCost.ToString();
        }
    }
    $XmlDocument.Save($file.FullName);
    Write-Output $file.FullName;  
}
