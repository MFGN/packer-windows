if ((Get-Service -Name WinRM).Status -eq 'Running') {
    Stop-Service -Name WinRM -Force -PassThru
}

Set-Service -Name WinRM -StartupType Disabled -PassThru