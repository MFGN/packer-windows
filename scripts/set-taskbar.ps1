$RegistryValues = @(
    [pscustomobject]@{
        'Name' = "EnableFeaturedSoftware"
        'Path' = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\EdgeUi\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "IncludeRecommendedUpdates"
        'Path' = "HKU:\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\EdgeUi\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "AUOptions"
        'Path' = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\"
        'RegValue' = 4
        'RegType' = 'DWord'
    }
)

if (!(Get-Module -Name RegTools)) {
    Import-Module "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\RegTools"
}

Import-RegData -RegistryValues $RegistryValues