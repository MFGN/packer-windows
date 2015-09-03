function Import-RegData {
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
        $ErrorRecord = New-Object System.Collections.ArrayList
    }
    process {
        if ($RegistryKeys) {
            foreach ($reg_key in $RegistryKeys) {
                Write-Verbose "$(Get-Date -format 'dd/MM/yyyy HH:mm:ss')    Keys: Processing: $($reg_key.Name)"
                try {
                    if (!((Get-ChildItem $reg_key.Path -ErrorAction SilentlyContinue) -match $reg_key.Name)) {
                        Write-Verbose "$(Get-Date -format 'dd/MM/yyyy HH:mm:ss')    Keys: Setting: $($reg_key.Name)"
                        New-Item -Path $reg_key.Path -Name $reg_key.Name -Force | Out-Null
                    }
                }
                catch {
                     Write-Warning "Error accessing $($reg_key.Path): $($_.Exception.Message)"
                     $ErrorRecord.add($reg_key) | Out-Null
                }
            }
        }
        if ($RegistryValues) {
            foreach ($reg_value in $RegistryValues) {
                Write-Verbose "$(Get-Date -format 'dd/MM/yyyy HH:mm:ss')    Values: Processing: $($reg_value.Name)"
                try {
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
                    Write-Warning "Error setting $($reg_value.Name): $($_.Exception.Message)"
                    $ErrorRecord.add($reg_value) | Out-Null
                } 
            }
        }
    }
    end {
        if ($ErrorRecord.Count -gt 0) {
            Write-Warning "Total errors $($ErrorRecord.count)"
            $ErrorRecord
        }
    }
}