$source = 'http://192.168.220.1:8080/iso/VMware-tools-windows.iso'
$iso_path = 'C:\Users\vagrant\windows.iso'

(New-Object System.Net.WebClient).DownloadFile($source,$iso_path)
Start-Sleep 10

if (Test-Path $iso_path) {
  Write-Host "Mounting ISO $iso_path"
  try {
    $image = Mount-DiskImage $iso_path -PassThru
  }
  catch {
    Write-Host "ERROR $LastExitCode while mounting VMWare Guest Additions"
    exit 2
  }
  $drive = (Get-Volume -DiskImage $image).DriveLetter
  Write-Host "ISO Mounted on $drive"
  Write-Host "Installing VMWare Guest Additions"
  cmd /c "${drive}:\setup64.exe /S /v`"/qn REBOOT=ReallySuppress ADDLOCAL=ALL`" /l C:\Windows\Logs\vmware-tools.log"
  Write-Host "Dismounting ISO"
  Dismount-DiskImage -ImagePath $image.ImagePath
  Restart-Computer -Force
  exit 0
}
else {
  Write-Host $(Get-NetAdapter -Physical | Get-NetIPAddress -AddressFamily IPv4).IPAddress
  Write-Host "ISO was not loaded [$iso_path], nothing will happen"
  exit 1
}
