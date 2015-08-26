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


        Start-Job -ScriptBlock {Start-Process -FilePath $inst_path -ArgumentList '/S /v "/qn REBOOT=R ADDLOCAL=ALL"' -Wait} | Get-Job | Wait-Job -TimeoutSec 180


        Write-Host "VMware Tools: Start installation - $(Get-Date -Format T)"

        Write-Host "VMware Tools: End installation - $(Get-Date -Format T)"
        if (!(Get-Service -Name VMTools -ErrorAction SilentlyContinue)) {
            Write-Host "VMware Tools: Service not running" -ForegroundColor Red
        }
        else {
            Write-Host "VMware Tools: Service is running" -ForegroundColor Green
            Write-Host "VMware Tools: Dismounting ISO"
            Dismount-DiskImage -StorageType ISO -ImagePath $iso_path
        }
    }
}
