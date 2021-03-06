﻿function Import-RegData {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [object[]]
        $RegistryKeys,
        [Parameter(Mandatory=$false)]
        [object[]]
        $RegistryValues
    )
    begin {
        function Set-RegistryDrive {
            param (
                [string]$Path
            )
            $path_split = $Path.Split(':')[0]
            $drive = switch ($path_split) {
                HKCU {'HKEY_CURRENT_USER'}
                HKLM {'HKEY_LOCAL_MACHINE'}
                HKCC {'HKEY_CURRENT_CONFIG'}
                HKCR {'HKEY_CLASSES_ROOT'}
                HKU  {'HKEY_USERS'}
            }
            if ($drive) {
                if ((Get-PSDrive -PSProvider Registry).Root -notcontains $drive) {
                    New-PSDrive -Name $path_split -PSProvider Registry -Root Registry::$drive -Scope 1 | Out-Null
                }
            }
        }
    }
    process {
        switch ($PSBoundParameters.Keys) {
            'RegistryKeys' {
                foreach ($reg_key in $RegistryKeys) {
                    Write-Verbose "$(Get-Date -format 'dd/MM/yyyy HH:mm:ss')    Keys: Processing: $($reg_key.Name)"
                    try {
                        Set-RegistryDrive -Path $reg_key.Path
                        if (!((Get-ChildItem $reg_key.Path -ErrorAction SilentlyContinue) -match $reg_key.Name)) {
                            Write-Verbose "$(Get-Date -format 'dd/MM/yyyy HH:mm:ss')    Keys: Setting: $($reg_key.Name)"
                            if ($reg_key.Path -notmatch '\\$') {
                                $reg_key.Path = $reg_key.Path+'\'
                            }
                            New-Item -Path $($reg_key.Path+$reg_key.Name) -Force | Out-Null
                        }
                    }
                    catch {
                        Write-Error -Exception $_.Exception -Message $_.Exception.Message -TargetObject $reg_key.Name
                    }
                }
            }
            'RegistryValues' {
                foreach ($reg_value in $RegistryValues) {
                    Write-Verbose "$(Get-Date -format 'dd/MM/yyyy HH:mm:ss')    Values: Processing: $($reg_value.Name)"
                    try {
                        Set-RegistryDrive -Path $reg_value.Path
                        if ((Get-ItemProperty $reg_value.Path) -match $reg_value.Name) {
                            Write-Verbose "$(Get-Date -format 'dd/MM/yyyy HH:mm:ss')    Values: Setting: $($reg_value.Name)"
                            Set-ItemProperty -Path $reg_value.Path -Name $reg_value.Name -Value $reg_value.RegValue -Type $reg_value.RegType -Force | Out-Null
                        }
                        else {
                            Write-Verbose "$(Get-Date -format 'dd/MM/yyyy HH:mm:ss')    Values: Creating: $($reg_value.Name)"
                            New-ItemProperty -Path $reg_value.Path -Name $reg_value.Name -Value $reg_value.RegValue -Type $reg_value.RegType -Force | Out-Null
                        }
                    }
                    catch {
                        Write-Error -Exception $_.Exception -Message $_.Exception.Message -TargetObject $reg_value.Name
                    }
                }
            }
        }
    }
}