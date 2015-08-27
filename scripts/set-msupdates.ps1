function Import-RegInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [object[]]$Keys,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [object[]]$Values
    )
    begin {
        $ErrorRecord = New-Object System.Collections.ArrayList
    }
    process {
        if ($Keys) {
            foreach ($Key in $Keys) {
                try {
                    if (!((Get-ChildItem $Key.Path -ErrorAction SilentlyContinue) -match $Key.Name)) {
                        New-Item -Path $Key.Path -Name $Key.Name -Force | Out-Null
                    }
                }
                catch {
                     Write-Warning "Error accessing $($Key.Path): $($_.Exception.Message)"
                     $ErrorRecord.add($Key) | Out-Null
                }
            }
        }
        if ($Values) {
            foreach ($Item in $Values) {
                try {
                    if ((Get-ItemProperty $Item.Path) -match $Item.Name) {
                        Set-ItemProperty -Path $Item.Path -Name $Item.Name -Value $Item.RegValue -Type $Item.RegType -Force | Out-Null
                    }
                    else {
                        New-ItemProperty -Path $Item.Path -Name $Item.Name -Value $Item.RegValue -Type $Item.RegType -Force | Out-Null
                    }
                }
                catch {
                    Write-Warning "Error setting $($Item.Name): $($_.Exception.Message)"
                    $ErrorRecord.add($Item) | Out-Null
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

$RegistryValues = @(
    [pscustomobject]@{
        'Name' = "EnableFeaturedSoftware"
        'Path' = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\"
        'RegValue' = 1
        'RegType' = 'DWord'
    },
    [pscustomobject]@{
        'Name' = "IncludeRecommendedUpdates"
        'Path' = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\"
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

if ((Get-Service -Name 'wuauserv').Status -ne 'Stopped') {
    try {
        Stop-Service -Name 'wuauserv' -PassThru
    }
    catch {
        $bla = $_
        write-host "you can't access it"
    }
}

