# copies all song files in playlist to spetc dir
$PlaylistFile = "Pidu_Tants.m3u";
$destUri = "C:\Users\Haikk\Music\Pulmamiks";

Get-Content $PlaylistFile |
  Select-String '^[^#]' | 
  ForEach-Object {     
    Copy-Item -Path $_ -Destination $destUri
  }