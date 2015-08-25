param (
    [string] $user = $env:username
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
        Push-Location $drive_letter
        Write-Host "VMware Tools: Start installation - $(Get-Date -Format T)"
        $installation_process = Start-Process -FilePath $($drive_letter+"\setup.exe") -ArgumentList '/S /v "/qn REBOOT=R ADDLOCAL=ALL"' -NoNewWindow -Wait -PassThru
        Wait-Process -InputObject $installation_process
        #$installation_args = "/c $($drive_letter)\setup.exe /S /v ""/qn REBOOT=R ADDLOCAL=ALL"""
        #$installation_process = Start-Process 'cmd.exe' -ArgumentList $installation_args -PassThru -Wait

        Write-Host "VMware Tools: End installation - $(Get-Date -Format T)"
        Pop-Location
        if (!(Get-Service -Name VMTools -ErrorAction SilentlyContinue)) {
            Write-Host "VMware Tools: Service not running" -ForegroundColor Red
        }
        else {
            Write-Host "VMware Tools: Service is running" -ForegroundColor Green
        }
        Write-Host "VMware Tools: Dismounting ISO"
        Dismount-DiskImage -StorageType ISO -ImagePath $iso_path
        #Write-Host "VMware Tools | Removing ISO"
        #Remove-Item -Path $iso_path -Force
    }
}
