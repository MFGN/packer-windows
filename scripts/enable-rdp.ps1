$RegistryValues = @(
    [pscustomobject]@{
        'Name' = "fDenyTSConnections"
        'Path' = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\"
        'RegValue' = 0
        'RegType' = 'DWord'
    }
)

if (!(Get-Module -Name RegTools)) {
    Import-Module "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\RegTools"
}

Import-RegData -RegistryValues $RegistryValues -Verbose

Set-NetFirewallRule -Name RemoteDesktop-UserMode-In-TCP -Profile Private,Domain -Enabled True -Action Allow
Set-NetFirewallRule -Name RemoteDesktop-UserMode-In-UDP -Profile Private,Domain -Enabled True -Action Allow

