$RegistryKeys = @(
    [pscustomobject]@{
        'Name' = "Accent"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\"
        'ItemType' = "Directory"
    },
    [pscustomobject]@{
        'Name' = "Accent"
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\"
        'ItemType' = "Directory"
    },
    [pscustomobject]@{
        'Name' = "Advanced"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\"
        'ItemType' = "Directory"
    },
    [pscustomobject]@{
        'Name' = "Advanced"
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\"
        'ItemType' = "Directory"
    },
    [pscustomobject]@{
        'Name' = "EdgeUi"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\"
        'ItemType' = "Directory"
    },
    [pscustomobject]@{
        'Name' = "EdgeUi"
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\"
        'ItemType' = "Directory"
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
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\EdgeUi\"
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
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\EdgeUi\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MotionAccentId_v1.00"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 'db'
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MotionAccentId_v1.00"
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 'db'
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "OpenAtLogon"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 0
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "OpenAtLogon"
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 0
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MonitorOverride"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MonitorOverride"
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MakeAllAppsDefault"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "MakeAllAppsDefault"
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "GlobalSearchInApps"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "GlobalSearchInApps"
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "DesktopFirst"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "DesktopFirst"
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent\"
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
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
        'RegValue' = 1
        'RegType' = 'DWord'
    }
)

if (!(Get-Module -Name RegTools)) {
    Import-Module "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\RegTools"
}

Import-RegData -RegistryKeys $RegistryKeys -RegistryValues $RegistryValues