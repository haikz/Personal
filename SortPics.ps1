# copies and sorts pictures to folders by year/month
#based on https://gist.github.com/ManasBhardwaj/5f84fdfb2dcdf93a96e2#file-gistfile1-ps1

[CmdletBinding()]
Param
(   
	[Parameter(Mandatory=$true,Position=0,HelpMessage="Path to unsorted pics.")]
	[ValidateNotNullOrEmpty()]
	[string]$srcFolder,
	[Parameter(Mandatory=$true,Position=0,HelpMessage="Destination path for sorted pics.")]
	[ValidateNotNullOrEmpty()]
	[string]$taregtFolder,
	[switch] $testOnly
)
#Set-ExecutionPolicy RemoteSigned -Force

function checkCreateDir {
	param ([string]$_Directory)
	if (!(Test-Path $_Directory))
	{
		Write-Verbose "creating new dir: $_Directory "
		New-Item $_Directory -ItemType Directory | Out-Null		
	}
}

$files = Get-ChildItem -Path $srcFolder -include *.* -Recurse -ErrorAction Stop
checkCreateDir "$srcFolder\copied"

foreach ($file in $files){
	try{
		$path = $file.FullName
		$shell = New-Object -COMObject Shell.Application
		$folder = Split-Path $path
		$file1 = Split-Path $path -Leaf
		$shellfolder = $shell.Namespace($folder)
		$shellfile = $shellfolder.ParseName($file1)
		
		#0..287 | Foreach-Object { '{0} = {1}' -f $_, $shellfolder.GetDetailsOf($null, $_) }
		#32 CameraMaker,#12 DateTaken,#30 CameraModel
		
		$dateTaken = $shellfolder.GetDetailsOf($shellfile, 12)
			
		if([string]::IsNullOrWhiteSpace($dateTaken)) {  
			Write-Verbose "Unable to get date taken, use creation date instead " + $file.Name
			$parseDate =[datetime]$file.CreationTime  
		} 	
		else{
			#http://stackoverflow.com/questions/25474023/file-date-metadata-not-displaying-properly
			$dateTaken = ($dateTaken -replace [char]8206) -replace [char]8207
			$parseDate =[datetime]::ParseExact($dateTaken,"g",$null)
		}
		
		$year = $parseDate.Year	
		$monthNr = "{0:MM}" -f $parseDate
				
		$directory = $taregtFolder + "\" + $year + "\" + "$monthNr"
		checkCreateDir $Directory						
	
		if (! $testOnly) {
			Copy-Item $file.FullName -Destination $directory	
			Move-Item $file.FullName "$srcFolder\\copied"
		}		
		Write-Verbose "copied $($file.Name) to $directory"
	}
	catch{
		Write-Error "Could not copy file $file"
	}
}