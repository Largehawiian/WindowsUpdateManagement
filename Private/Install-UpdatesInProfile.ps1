function Install-UpdatesInProfile {
    param(
        [Parameter(ParameterSetName="Default")][switch]$Default,
        [Parameter(ParameterSetName="ForceReboot")][string]$ForceReboot
    )
    if ($Default){
    $RebootSchedule = [datetime](get-date).AddDays(1).Date.ToString('MM/dd/yyyy HH:mm', [cultureinfo]::InvariantCulture)
    $Script:Results = Install-WindowsUpdate -NotCategory "Drivers","FeaturePacks" -AcceptAll -ScheduleReboot $RebootSchedule -confirm:$False
    }
    if ($ForceReboot){
        $Script:Results = Install-WindowsUpdate -NotCategory "Drivers","FeaturePacks" -AcceptAll -AutoReboot:$True -confirm:$False
    }
    return $Script:Results
}