function Set-DefaultWUSettings {
    Get-WUSettings | Set-WUSettings -Confirm:$False -AutoInstallMinorUpdates:$True -IncludeRecommendedUpdates:$True -NoAutoUpdate:$False `
    -NoAutoRebootWithLoggedOnUsers:$False
}