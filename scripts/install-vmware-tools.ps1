$user = 'vagrant'
$iso_path = "C:\Users\$($user)\windows.iso"

if (Test-Path $iso_path) {
    try {
        $image_mount = Mount-DiskImage $iso_path -StorageType ISO -PassThru -ErrorAction Stop
    }
    catch {
        Write-Error "Error mounting ISO"
        $error[0].Exception
    }
    Set-Location "$((Get-Volume -DiskImage $image_mount).DriveLetter):"
    Start-Process -FilePath .\setup.exe -ArgumentList '/S /v "/qn REBOOT=R ADDLOCAL=ALL"' -Wait
    if (!(Get-Service -Name VMTools -ErrorAction SilentlyContinue)) {
        Write-Error "VMware Tools service not running"
    }
    Dismount-DiskImage -StorageType ISO -ImagePath $iso_path
    Remove-Item -Path $iso_path -Force
    Start-Sleep -Seconds 5
    Restart-Computer -Force
}