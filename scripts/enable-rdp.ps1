$RegistryKeys = @(
    [pscustomobject]@{
        'Name' = "fDenyTSConnections"
        'Path' = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\"
        'RegValue' = 0
        'RegType' = 'DWord'
    }
)

ForEach ($Item in $RegistryKeys) {
    if ((Get-ItemProperty $Item.Path) -match $Item.Name) {
        Set-ItemProperty -Path $Item.Path -Name $Item.Name -Value $Item.RegValue -Type $Item.RegType -Force
    }
    else {
        New-ItemProperty -Path $Item.Path -Name $Item.Name -Value $Item.RegValue -Type $Item.RegType -Force
    }
}

Set-NetFirewallRule -Name RemoteDesktop-UserMode-In-TCP -Profile Private,Domain -Enabled True -Action Allow
Set-NetFirewallRule -Name RemoteDesktop-UserMode-In-UDP -Profile Private,Domain -Enabled True -Action Allow