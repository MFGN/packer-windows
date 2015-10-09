if ((Get-ExecutionPolicy) -like "Restricted") {
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force -Confirm:$false
}
 
$id = &winrm id
if (($id -eq $null) -and (Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -name LocalAccountTokenFilterPolicy -ErrorAction SilentlyContinue) -eq $null) {
    New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -name LocalAccountTokenFilterPolicy -value 1 -propertyType dword
}

Set-Service -Name WinRM -StartupType Automatic -PassThru

Set-Item -Path WSMan:\localhost\Client\Auth\Basic -Value $true -Force -PassThru
Set-Item -Path WSMan:\localhost\Client\AllowUnencrypted -Value $true -Force -PassThru
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true -Force -PassThru
Set-Item -Path WSMan:\localhost\Service\AllowUnencrypted -Value $true -Force -PassThru
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value "*" -Force -PassThru
Set-Item -Path WSMan:\localhost\MaxTimeoutms -Value 1800000 -Force -PassThru
Set-Item -Path WSMan:\localhost\Shell\MaxMemoryPerShellMB -Value 512 -Force -PassThru

Enable-PSRemoting -Force -SkipNetworkProfileCheck

if ((Get-Service -Name WinRM).Status -ne 'Running') {
    Start-Service -Name WinRM -PassThru 
}