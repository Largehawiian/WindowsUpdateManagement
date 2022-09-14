function Get-Status {
    $Status = Get-WURebootStatus -Silent
    if ($Status.RebootRequired -eq $true){
        return $Status.RebootRequired
    }
    else {
        return $status
    }
}