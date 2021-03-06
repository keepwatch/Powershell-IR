﻿
# Registry Collection
Write-Host -ForegroundColor Yellow "`tCollecting Registry Hives"

# TODO: decide how to implement -filter "<HIVE>*" which will also pull transaction logs but my be messy for current triage usecases
Invoke-BulkCopy -folder "$env:systemdrive\Windows\System32\config" -target "$Output\Registry" -filter "SECURITY" -forensic
Invoke-BulkCopy -folder "$env:systemdrive\Windows\System32\config" -target "$Output\Registry" -filter "SOFTWARE" -forensic
Invoke-BulkCopy -folder "$env:systemdrive\Windows\System32\config" -target "$Output\Registry" -filter "SAM" -forensic
Invoke-BulkCopy -folder "$env:systemdrive\Windows\System32\config" -target "$Output\Registry" -filter "SYSTEM" -forensic

Invoke-BulkCopy -folder "$env:systemdrive\Windows\AppCompat\Programs" -target "$Output\Registry\Windows\AppCompat\Programs" -filter "Amcache.hve" -forensic

# System and serice profile hives
Invoke-BulkCopy -folder "$env:systemdrive\Windows\system32\config\systemprofile" -target "$Output\Registry\SystemProfile" -filter "ntuser.dat" -forensic
Invoke-BulkCopy -folder "$env:systemdrive\Windows\ServiceProfiles" -target "$Output\Registry\ServiceProfiles" -filter "ntuser.dat" -recurse -forensic
