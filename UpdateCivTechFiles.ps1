# Modifies CIV 5 technologies costs
$civInstallationUrl = "C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V";
#$civInstallationUrl = "C:\Users\haikk\Documents\My Games\Sid Meier's Civilization 5"
[decimal]$multiplier = 1.5;
[bool]$ExcludeAncientEra = $true;
$VerbosePreference = "continue"

$files = Get-ChildItem -Path $civInstallationUrl -Include "CIV5Technologies.xml" -Recurse
#$files = Get-ChildItem -Path $civInstallationUrl -Include "Technologies.xml" -Recurse #mods


foreach($file in $files){   
    Write-Verbose ("found " +$file.FullName)
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
    #Write-Output $file.FullName;  
}

