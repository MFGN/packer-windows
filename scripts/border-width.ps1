if ((Get-PSDrive -PSProvider Registry).Root -notcontains 'HKEY_USERS')
{
    New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
}

$Keys=@{
    "BorderWidth" =  0
    "PaddedBorderWidth" = 0
}

$HKCUpath = "HKCU:\Control Panel\Desktop\WindowMetrics\"
$HKUpath = "HKU:\.DEFAULT\Control Panel\Desktop\WindowMetrics\"

$Keys.GetEnumerator() | % {
    #Change border width for current user
    if ((Get-ItemProperty $HKCUpath) -like "*$($_.Name)*")
    {
        Set-ItemProperty -Path $HKCUpath -Name $_.Name -Value $_.Value -Type String -Force
    }
    else
    {
        New-ItemProperty -Path $HKCUpath -Name $_.Name -Value $_.Value -Type String -Force 
    }
    #Change border width for all users
    if ((Get-ItemProperty $HKUpath) -like "*$($_.Name)*")
    {
        Set-ItemProperty -Path $HKUpath -Name $_.Name -Value $_.Value -Type String -Force
    }
    else
    {
        New-ItemProperty -Path $HKUpath -Name $_.Name -Value $_.Value -Type String -Force
    }
}