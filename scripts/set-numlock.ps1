$RegistryValues = @(
    [pscustomobject]@{
        'Name' = "InitialKeyboardIndicators"
        'Path' = "HKCU:\Control Panel\Keyboard\"
        'RegValue' = 1
        'RegType' = 'String'
    },
    [pscustomobject]@{
        'Name' = "InitialKeyboardIndicators"
        'Path' = "HKU:\.DEFAULT\Control Panel\Keyboard\"
        'RegValue' = 1
        'RegType' = 'String'
    }
)

if (!(Get-Module -Name RegTools)) {
    Import-Module "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\RegTools" -Global
}

Import-RegData -RegistryValues $RegistryValues