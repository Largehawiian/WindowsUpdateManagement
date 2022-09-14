function Set-WindowsUpdateProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ParameterSetName="Default")][switch]$Default,
        [Parameter(Mandatory=$true, ParameterSetName="ForceReboot")][switch]$ForceReboot
    )
    Set-DefaultWUSettings | Out-Null
    Optimize-Repositories
    $Modules = Install-RequiredModules
    if ($Modules -ne $True) { exit 1}
    if ($Default) {
        $RebootStatus = Get-Status
        if ($RebootStatus -eq $True){
            $RebootSchedule = [datetime](get-date).AddDays(1).Date.ToString('MM/dd/yyyy HH:mm', [cultureinfo]::InvariantCulture)
            $Trigger = New-ScheduledTaskTrigger -At $RebootSchedule -Once
            $Action = New-ScheduledTaskAction -Execute 'shutdown.exe' -Argument '-r -t 0'
            $Task = Register-ScheduledTask -Action $Action -Trigger $Trigger -TaskName 'Reboot' -RunLevel Highest -User SYSTEM -Force
        }
        Set-DefaultWUSettings
        Install-UpdatesInProfile -default
    }
    if ($ForceReboot){
        $RebootStatus = Get-Status
        if ($RebootStatus -eq $True){
            $RebootSchedule = [datetime](get-date).AddDays(1).Date.ToString('MM/dd/yyyy HH:mm', [cultureinfo]::InvariantCulture)
            $Trigger = New-ScheduledTaskTrigger -At $RebootSchedule -Once
            $Action = New-ScheduledTaskAction -Execute 'shutdown.exe' -Argument '-r -t 0'
            $Task = Register-ScheduledTask -Action $Action -Trigger $Trigger -TaskName 'Reboot' -RunLevel Highest -User SYSTEM -Force
        }
        Set-DefaultWUSettings
        Install-UpdatesInProfile -forcereboot
    }
    
}