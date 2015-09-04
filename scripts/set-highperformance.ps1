function Get-PowerPlan {
    param (
        [switch]$Active
    )
    try {
        $power_plan = Get-CimInstance -Namespace root/CIMV2/power -ClassName Win32_PowerPlan
    }
    catch {
        Write-Warning "Error accessing Power Plan: $($_.Exception.Message)"
    }
    if ($power_plan) {
        $props = @(
            'ElementName',
            'IsActive',
            'InstanceID'
        )
        switch ($Active) {
            $true {$power_plan | Where-Object {$_.IsActive -eq $true} | Select-Object $props}
            $false {$power_plan | Select-Object $props}
        }
    }
}

function Set-PowerPlan {
    param (
        [ValidateSet('Balanced','HighPerformance','PowerSaver')]
        [string]$Plan
    )
    $power_plan = $Plan -csplit '(?=[A-Z])(?<=[a-z])' -join ' '
    try {
        $get_plan = Get-CimInstance -Namespace root/CIMV2/power -ClassName Win32_PowerPlan
    }
    catch {
        Write-Warning "Error accessing Power Plan: $($_.Exception.Message)"
    }
    if ($get_plan) {
        $new_plan = $get_plan | Where-Object {$_.ElementName -match $power_plan}
        if (!($new_plan.IsActive)) {
            try {
                Invoke-CimMethod -InputObject $new_plan -MethodName Activate | Out-Null
            }
            catch {
                Write-Warning "Error setting Power Plan: $($_.Exception.Message)"
            }
        }
    }
}

if ((Get-PowerPlan -Active).ElementName -notmatch 'High Performance') {
    Set-PowerPlan -Plan HighPerformance
}