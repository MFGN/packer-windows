$RegistryKeys = @(
    [pscustomobject]@{
        'Name' = "AutoAdminLogon"
        'Path' = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\"
        'RegValue' = 0
        'RegType' = 'String'
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