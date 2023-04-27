<#
.SYNOPSIS
Microsoft Teams QoS Client Activation Script
.Description
Microsoft Teams QoS Client Activation Script
.NOTES
  Version      	   		: 1.0
  Author(s)    			: Erwin Bierens
  Email/Blog/Twitter	: erwin@bierens.it https://erwinbierens.com @erwinbierens
.EXAMPLE
.\Set-QoSClientActivationScript.ps1
#>

# Create QoS Policys
New-NetQosPolicy -Name "TeamsClientAudio" -AppPathName "Teams.exe" -IPProtocol Both -IPSrcPortStart 50000 -IPSrcPortEnd 50019 -DSCPValue 46
New-NetQosPolicy -Name "TeamsClientVideo" -AppPathName "Teams.exe" -IPProtocol Both -IPSrcPortStart 50020 -IPSrcPortEnd 50039 -DSCPValue 34
New-NetQosPolicy -Name "TeamsClientSharing" -AppPathName "Teams.exe" -IPProtocol Both -IPSrcPortStart 50040 -IPSrcPortEnd 50059 -DSCPValue 18

# Create Registry setting to enable QoS
New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\" -Name QoS -Value "Default Value" -Force
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\QoS" -Name "Application Name" -Value "Teams.exe" -PropertyType "String" -Force |Out-Null
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\QoS" -Name "DSCP Value" -Value "46" -PropertyType "String" -Force |Out-Null
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\QoS" -Name "Local IP" -Value "*" -PropertyType "String" -Force |Out-Null
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\QoS" -Name "Local IP Prefix Length" -Value "*" -PropertyType "String" -Force |Out-Null
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\QoS" -Name "Local Port" -Value "50000-50019" -PropertyType "String" -Force |Out-Null
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\QoS" -Name "Protocol" -Value "*" -PropertyType "String" -Force |Out-Null
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\QoS" -Name "Remote IP" -Value "*" -PropertyType "String" -Force |Out-Null
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\QoS" -Name "Remote Port" -Value "*" -PropertyType "String" -Force |Out-Null
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\QoS" -Name "Throttle Rate" -Value "-1" -PropertyType "String" -Force |Out-Null

#update local store
gpupdate /force
