# Modifies CIV 5 technologies costs
$civInstallationUrl = "C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V";
#$civInstallationUrl ="C:\Users\haikk\Documents\My Games\Sid Meier's Civilization 5\MODS"
#$civInstallationUrl = "C:\Users\haikk\Documents\My Games\Sid Meier's Civilization 5"
#$civInstallationUrl = "I:\Ajutine"

[decimal]$multiplier = 2;
[bool]$ExcludeAncientEra = $true;
$VerbosePreference = "continue"

$files = Get-ChildItem -Path $civInstallationUrl -Include "CIV5Technologies.xml" -Recurse
#$files = Get-ChildItem -Path $civInstallationUrl -Include "FutureTechnologies.xml" -Recurse

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


$result = Get-ChildItem "$civInstallationUrl\Assets\DLC" -Exclude "*Dialog*","*Civlopedia*","*Text*","*Audio*","*ArtDefines*","*Maps*" -Recurse -Filter *.xml | Select-String "marble" -List 
$result = Get-ChildItem "$civInstallationUrl\Assets\DLC" -Exclude "*Dialog*","*Civlopedia*","*Text*","*Audio*","*Maps*" -Recurse -Filter *.xml | Select-String "TurnRateMin" -List 
$result = Get-ChildItem "$civInstallationUrl\Assets\DLC"  -Recurse -Filter *.xml -Include "*CIV5Improvements*" | Select-String "lumber" -List 
Get-ChildItem "$civInstallationUrl\Assets\DLC"  -Recurse -Filter *.xml -Include "*CIV5Improvements*" | Select-String "polder" -List 
$result = Get-ChildItem "$civInstallationUrl\Assets"  -Recurse -Filter *.xml -Include "*CIV5Buildings*" | Select-String "light" -List
Get-ChildItem "$civInstallationUrl\Assets\DLC"  -Recurse -Filter *.xml | Select-String "oasis" -List 
Get-ChildItem "$civInstallationUrl" -Exclude "Scenarios" -Filter *.xml -Recurse | Select-String "StartingWorkerUnits" -List 

$result.Path
#C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\DLC\Expansion2\Gameplay\XML\Buildings\CIV5Buildings_Expansion2.xml
# <NumTradeRouteBonus>1</NumTradeRouteBonus>
#Heroic - C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\DLC\Expansion2\Gameplay\XML\Buildings\CIV5Buildings.xml
# <Experience>15</Experience>

# C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\Gameplay\XML\Buildings
#<TrainedFreePromotion>PROMOTION_MEDIC</TrainedFreePromotion>
# air animations - ArtDefine_UnitMemberCombats
# C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\Units\Civ5ArtDefines_UnitMembers.xml
#C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\DLC\Expansion\Units\Civ5ArtDefines_Expansion_UnitMembers.xml
#C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\DLC\Expansion2\Units\Civ5ArtDefines_Expansion2_Inherited_UnitMembers.xml
# MoveRate, TurnRateMin, TurnRateMax

#<Row Name="BARBARIAN_MAX_XP_VALUE">
# C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\DLC\Expansion\Gameplay\XML\GlobalDefines.xml
# C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\DLC\Expansion2\Gameplay\XML\GlobalDefines.xml
# C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\Gameplay\XML\GlobalDefines.xml

#StartingWorkerUnits
# C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\DLC\Expansion\Gameplay\XML\GameInfo\CIV5Eras.xml
# C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\DLC\Expansion2\Gameplay\XML\GameInfo\CIV5Eras.xml
# C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\Assets\Gameplay\XML\GameInfo\CIV5Eras.xml