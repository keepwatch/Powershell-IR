﻿
# RawCopy
$CopyArray = $Raw.Split(",")

Foreach($Item in $CopyArray) {
    If (Test-Path -Path $Item) {
        Write-Host -ForegroundColor Yellow "`tCollecting $Item with RawCopy"
        # RawCopy folder
        If (Test-Path -Path $Item  -PathType Container) {
            If (!(Split-path $Item)) {
                Write-Host -ForegroundColor Red "`tError: $Item is a Root folder. Please try single files."
            }
            Else {
                $Folder = $Item.TrimEnd("\")
                $Target = (Split-Path $Item -NoQualifier).Trim("\")
                $Drive = (split-path $Item -Qualifier).TrimEnd(":")

                Invoke-BulkCopy -folder $Folder -target "$Output\Files\$Drive\$Target" -forensic
                #Invoke-BulkCopy -folder $Item -target "$Output\Files\$Item" -recurse -forensic
            }
        }
        # Copy file
        ElseIf (Test-Path -Path $Item  -PathType Leaf) {
            $File = Split-Path -Path $Item -Leaf
            $Folder = Split-Path -Path $Item
            $Target = (Split-path (Split-Path $Item -NoQualifier)).TrimStart("\")
            $Drive = (split-path $Item -Qualifier).TrimEnd(":")
        
            Invoke-BulkCopy -folder $Folder -target "$Output\Files\$Drive\$Target" -filter $File -forensic
        }
    }
    Else {
        Write-Host -ForegroundColor Red "`tError: $Item not found"
    }
}
