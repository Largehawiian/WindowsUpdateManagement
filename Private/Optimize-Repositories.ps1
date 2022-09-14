function Optimize-Repositories {
    try {
        Get-PackageProvider -Name NuGet -ErrorAction Stop -ForceBootstrap | Out-Null
    }
    catch {
        Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -confirm:$false
    }
    try {
        $PSGallery = (Get-PSRepository -name PSGallery).InstallationPolicy
        if ($PSGallery -ne 'Trusted') {
            Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
        }
    }
    catch {
        exit 1
    }
    
}