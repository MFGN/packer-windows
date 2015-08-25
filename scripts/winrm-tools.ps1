if ((Get-ExecutionPolicy) -like "Restricted") {
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force -Confirm:$false
}
 
$id = &winrm id
if (($id -eq $null) -and (Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -name LocalAccountTokenFilterPolicy -ErrorAction SilentlyContinue) -eq $null) {
    New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -name LocalAccountTokenFilterPolicy -value 1 -propertyType dword
}

Enable-PSRemoting -Force

if ((Get-Service -Name WinRM).Status -notlike "Stopped")
{
    &net stop winrm
}

Set-Service -Name WinRM -StartupType Automatic

# Enable and configure WinRM (see below)
&winrm quickconfig `-q
&winrm set winrm/config/client/auth '@{Basic="true"}'
&winrm set winrm/config/service/auth '@{Basic="true"}'
&winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="512"}'
&winrm set winrm/config '@{MaxTimeoutms="1800000"}'
&winrm set winrm/config/client '@{AllowUnencrypted="true"}'
&winrm set winrm/config/service '@{AllowUnencrypted="true"}'
&netsh http delete iplisten ipaddress=127.0.0.1