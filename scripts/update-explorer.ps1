$RegistryValues = @(
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

if (!(Get-Module -Name RegTools)) {
    Import-Module "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\RegTools"
}

Import-RegData -RegistryValues $RegistryValues