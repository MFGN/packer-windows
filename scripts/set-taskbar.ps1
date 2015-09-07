$RegistryKeys = @(
    [pscustomobject]@{
        'Name' = "Accent"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\"
    },
    [pscustomobject]@{
        'Name' = "Accent"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\"
    },
    [pscustomobject]@{
        'Name' = "Advanced"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\"
    },
    [pscustomobject]@{
        'Name' = "Advanced"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\"
    },
    [pscustomobject]@{
        'Name' = "EdgeUi"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\"
    },
    [pscustomobject]@{
        'Name' = "EdgeUi"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\"
    },
    [pscustomobject]@{
        'Name' = "StartPage"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\"
    },
    [pscustomobject]@{
        'Name' = "StartPage"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\"
    }
)

$RegistryValues = @(
    [pscustomobject]@{
        'Name' = "DisableTRCorner"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\EdgeUi\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "DisableTRCorner"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\EdgeUi\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "DisableTLCorner"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\EdgeUi\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "DisableTLCorner"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\EdgeUi\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MotionAccentId_v1.00"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 219
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MotionAccentId_v1.00"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 219
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "OpenAtLogon"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage\"
        'RegValue' = 0
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "OpenAtLogon"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage\"
        'RegValue' = 0
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MonitorOverride"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MonitorOverride"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MakeAllAppsDefault"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MakeAllAppsDefault"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "GlobalSearchInApps"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "GlobalSearchInApps"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "DesktopFirst"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "DesktopFirst"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "TaskbarSmallIcons"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "TaskbarSmallIcons"
        'Path' = "HKU:\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
        'RegValue' = 1
        'RegType' = 'DWord'
    }
)

if (!(Get-Module -Name RegTools)) {
    Import-Module "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\RegTools"
}

Import-RegData -RegistryKeys $RegistryKeys -RegistryValues $RegistryValues