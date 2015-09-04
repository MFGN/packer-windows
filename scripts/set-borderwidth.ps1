$RegistryValues = @(
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

if (!(Get-Module -Name RegTools)) {
    Import-Module "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\RegTools"
}

Import-RegData -RegistryValues $RegistryValues