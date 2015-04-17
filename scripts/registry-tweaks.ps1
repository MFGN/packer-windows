$RegistryKeys = @(
    [pscustomobject]@{
        'Name' = "QuickEdit"
        'Path' = "HKCU:\Console\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "HideFileExt"
        'Path' = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
        'RegValue' = 0
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "Start_ShowRun"
        'Path' = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "StartMenuAdminTools"
        'Path' = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
        'RegValue' = 1
        'RegType' = 'DWord'
    }
)

if ((Get-PSDrive -PSProvider Registry).Root -notcontains 'HKEY_USERS')
{
    New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
}

ForEach ($Item in $RegistryKeys)
{
    if ((Get-ItemProperty $Item.Path) -like "*$($Item.Name)*")
    {
        Set-ItemProperty -Path $Item.Path -Name $Item.Name -Value $Item.RegValue -Type $Item.RegType -Force
    }
    else
    {
        New-ItemProperty -Path $Item.Path -Name $Item.Name -Value $Item.RegValue -Type $Item.RegType -Force
    }
}