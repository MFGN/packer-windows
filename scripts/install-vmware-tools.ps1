param (
    [string]$user,
    [string]$iso_url
)

$iso_path = "C:\Users\$($user)\windows.iso"

try {
    Write-Host "Downloading ISO to $iso_path" 
    (New-Object System.Net.WebClient).DownloadFile($iso_url,$iso_path)
}
catch {
    Write-Host "Error downloading ISO" -ForegroundColor Red
    $error[0].Exception
}

if (Test-Path $iso_path) {
    try {
        Write-Host "Mounting ISO" 
        $image_mount = Mount-DiskImage $iso_path -StorageType ISO -PassThru -ErrorAction Stop
    }
    catch {
        Write-Host "Error mounting ISO" -ForegroundColor Red
        $error[0].Exception
    }
    if ($image_mount) {
        $DriveLetter = ((Get-Volume -DiskImage $image_mount).DriveLetter)+':\'
        Write-Host "Installing VMware tools from $DriveLetter"
        Start-Process -FilePath ($DriveLetter+'setup.exe') -ArgumentList '/S /v "/qn REBOOT=R ADDLOCAL=ALL"' -Wait
        if (!(Get-Service -Name VMTools -ErrorAction SilentlyContinue)) {
            Write-Host "VMware Tools service not running" -ForegroundColor Red
        }
        else {
            Write-Host "VMware Tools service is running" -ForegroundColor Green
        }
        Write-Host "Dismounting ISO"
        Dismount-DiskImage -StorageType ISO -ImagePath $iso_path
        Write-Host "Removing ISO"
        Remove-Item -Path $iso_path -Force
        Write-Host "Restarting computer"
        Start-Sleep 10
        Restart-Computer -Force
    }
}