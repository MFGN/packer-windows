param (
    [string]$user = $env:username
)

$iso_path = "C:\Users\$($user)\windows.iso"

if (Test-Path $iso_path) {
    try {
        Write-Host "VMware Tools: Mounting ISO"
        $image_mount = Mount-DiskImage $iso_path -PassThru -ErrorAction Stop
    }
    catch {
        Write-Host "VMware Tools: Error mounting ISO" -ForegroundColor Red
        $error[0].Exception
    }
    if ($image_mount) {
        $drive_letter = ((Get-Volume -DiskImage $image_mount).DriveLetter)+':'
        $inst_path = Join-Path $drive_letter -ChildPath 'setup64.exe'
        if (Test-Path $inst_path) {
            Write-Host "VMware Tools: Start installation on $inst_path - $(Get-Date -Format T)"
            Start-Job -ScriptBlock {
                Start-Process -FilePath $inst_path -ArgumentList '/S /v /qn'
            } | Wait-Job -TimeoutSec 180
        }
        else {
            Write-Host "VMware Tools: Error accessing $inst_path"
        }
    }
}
