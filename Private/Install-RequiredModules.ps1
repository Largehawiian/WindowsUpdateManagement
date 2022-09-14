function Install-RequiredModules {
    try {
        Import-module PsScheduledJob -ErrorAction Stop | Out-Null
    }
    catch {
        Install-Module PSScheduledJob -Force
        Import-Module PSScheduledJob -Force -ErrorAction Stop | Out-Null
    }
    try {
        Set-ExecutionPolicy -executionpolicy bypass Process -Force
        Import-Module PSWindowsUpdate -Force -ErrorAction Stop | Out-Null
    }
    catch {
        Install-Module PSWindowsUpdate -Force -ErrorAction stop | Out-Null
        Import-Module PSWindowsUpdate -Force -ErrorAction Stop | Out-Null
    }
    if ($NUll -ne (get-module -ListAvailable PSWindowsUpdate) -and $Null -ne (get-module -ListAvailable psscheduledjob)){
        Return $True
    }
    else {
        Return $False
    }
}