﻿<#
Author: Michel Bevilacqua  
IMPORTANT: this script needs to be run as administrator
#>

$path = 'C:\temp'
if (!(Test-Path $path)) {New-Item -ItemType directory -Path C:\temp}

$credential = Get-Credential

$credential.Password | ConvertFrom-SecureString | Set-Content c:\temp\password.txt

$encrypted = Get-Content c:\temp\password.txt | ConvertTo-SecureString

$credential = New-Object System.Management.Automation.PsCredential($credential.Username,$encrypted)

$isDone = $false;

while (!$isDone)
{
	echo 'Enter the number corresponding to the drive you want to map and press "Enter"'
	echo '0. INSERT DRIVE NAME HERE'
	echo '1. INSERT DRIVE NAME HERE'
	echo '2. INSERT DRIVE NAME HERE'
	$Printer = Read-Host -Prompt 'Number'
	<# 
	Exception handling still need to be implemented
	Try
	{
	#>
		switch ($Printer)
		{
			0 { New-PSDrive -name "Z" -PSProvider FileSystem -Root "\\SERVER\share" -Persist -Scope "Global" -Credential $credential; break}
			1 { New-PSDrive -name "Y" -PSProvider FileSystem -Root "\\SERVER\share" -Persist -Scope "Global" -Credential $credential; break}
			2 { New-PSDrive -name "X" -PSProvider FileSystem -Root "\\SERVER\share" -Persist -Scope "Global" -Credential $credential; break}
			default {"Invalid number"; break}
		}

		$result
	
	<#
	} 
	Catch 
	{ 
		Write-Output 'Error: the user's privileges do not match the required permission to map this drive'
	}
	#>
	
	echo 'Would you like to map another drive? Enter the corresponding number and press "Enter"'
	echo '0. Yes'
	echo '1. No'
	
	$Continue = Read-Host -Prompt 'Number'
	
	switch ($Continue)
	{
		0 {break}   
		1 {$isDone = $true; break}
		default {$isDone = $true; break}
	}
}
Remove-Item –path c:\temp\password.txt –recurse