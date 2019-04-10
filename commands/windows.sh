#!/bin/bash

# list names of all event logs
wevtutil.exe el

# display 2 most recent events in system log text
wevtutil.exe qe System /c:2 /rd:true /f:text

# get log configuration information
wevtutil.exe gl Application

# turn hibernate off to free hiberfil.sys
powercfg -h off

##### windows selenium headless browsing
# ndoe
/cygdrive/c/ProgramData/Oracle/Java/javapath/java.exe -jar selenium-server-standalone-3.4.0.jar -role node -port 5555 -hub http://192.168.1.2:4444/grid/register
# hub
/cygdrive/c/ProgramData/Oracle/Java/javapath/java.exe -jar selenium-server-standalone-3.4.0.jar -role hub -port 4444

# powershell
Get-Help # <command> -Example -Full
Get-Command -Name *register*
Get-Service # Start- Stop- Restart- Resume- Suspend-
Get-Process # Start- Stop- Wait-
ps | sort -p ws | select -last 5 # find the five proce3sses using the most memory
dir -r | select string "searchforthis" # search within files for string
cd hkcu: # navigation windows registry
(Get-WmiObject -Class Win32_OperatingSystem -ComputerName .).Win32Shutdown(2) # shutdown computer
Get-WmiObject -Class Win32_ComputerSystem # get computer information
Get-WmiObject -Class Win32_BIOS -ComputerName . # get bios informaiton
Get-WmiObject -Class Win32_PRoduct -ComputerName . | Format-Wide -Column 1 # get names of installed applications
Start-Sleep 60; Restart-Computer -Force -ComputerName TARGETMACHINE # remotely shut down another machine after 1 minute
invoke-command -computername machine1, machine2 -filepath c:\Script\script.ps1 # run script on a remote machine
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName . | Format-Table -Property IPAddress # get ip addresses assigned
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName . | Select-Object -Property [a-z]* -ExcludeProperty IPX*,WINS* # detailed ip configuration
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=true" -ComputerName . # get all network interfaces with dhcp
Stop-Process -processname calc* # stop all calculator processes

# remote desktop
mstsc /v:10.10.10.10:3389
mstsc /v:dionysus:3389

# speak through speakers
$s = New-Object -ComObject SAPI.SPVoice
$s.Speak("I'm a COM object and I can speak!")

# speak a tweet
$webClient = New-Object -TypeName "System.Net.WebClient"

$s = New-Object -ComObject "SAPI.SPVoice"
$s.Rate = -1;

$url = "http://search.twitter.com/search.atom?q=PowerShell"
$x = [XML]$webClient.DownloadString($url)

$x.feed.entry | foreach {
    $s.Speak("Tweet from: " + $_.author.name)
    $s.Speak($_.title)
}
