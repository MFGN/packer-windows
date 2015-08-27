$RegistryKeys = @(
    [pscustomobject]@{
        'Name' = "BorderWidth"
        'Path' = "HKCU:\Control Panel\Desktop\WindowMetrics\"
        'RegValue' = 0
        'RegType' = 'String'
    },
    [pscustomobject]@{
        'Name' = "PaddedBorderWidth"
        'Path' = "HKCU:\Control Panel\Desktop\WindowMetrics\"
        'RegValue' = 0
        'RegType' = 'String'
    },
    [pscustomobject]@{
        'Name' = "BorderWidth"
        'Path' = "HKU:\.DEFAULT\Control Panel\Desktop\WindowMetrics\"
        'RegValue' = 0
        'RegType' = 'String'
    },
    [pscustomobject]@{
        'Name' = "PaddedBorderWidth"
        'Path' = "HKU:\.DEFAULT\Control Panel\Desktop\WindowMetrics\"
        'RegValue' = 0
        'RegType' = 'String'
    }
)

if ((Get-PSDrive -PSProvider Registry).Root -notcontains 'HKEY_USERS') {
    New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
}

ForEach ($Item in $RegistryKeys) {
    if ((Get-ItemProperty $Item.Path) -match $Item.Name) {
        Set-ItemProperty -Path $Item.Path -Name $Item.Name -Value $Item.RegValue -Type $Item.RegType -Force
    }
    else {
        New-ItemProperty -Path $Item.Path -Name $Item.Name -Value $Item.RegValue -Type $Item.RegType -Force
    }
}