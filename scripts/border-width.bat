::Change border width for all users
%SystemRoot%\System32\reg.exe ADD HKU\.DEFAULT\Control Panel\Desktop\WindowMetrics\ /v BorderWidth /t REG_SZ /d 0 /f
%SystemRoot%\System32\reg.exe ADD HKU\.DEFAULT\Control Panel\Desktop\WindowMetrics\ /v PaddedBorderWidth /t REG_SZ /d 0 /f

::Change border width for current user
%SystemRoot%\System32\reg.exe ADD HKCU\Control Panel\Desktop\WindowMetrics\ /v BorderWidth /t REG_SZ /d 0 /f
%SystemRoot%\System32\reg.exe ADD HKCU\Control Panel\Desktop\WindowMetrics\ /v PaddedBorderWidth /t REG_SZ /d 0 /f