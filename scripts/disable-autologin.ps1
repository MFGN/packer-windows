$RegistryValues = @(
    [pscustomobject]@{
        'Name' = "AutoAdminLogon"
        'Path' = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\"
        'RegValue' = 0
        'RegType' = 'String'
    }
)

if (!(Get-Module -Name RegTools)) {
    Import-Module "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\RegTools"
}

Import-RegData -RegistryValues $RegistryValues -Verbose