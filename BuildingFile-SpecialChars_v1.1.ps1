$CsvPath = "C:\temp\input.csv"

$Data = Import-Csv $CsvPath

# Check Building data file column E "Building Name" only
$Columns = $Data[0].PSObject.Properties.Name[4]

$OutputPath = Join-Path (Split-Path $CsvPath -Parent) "results.csv"

$RowNumber = 1
$Results = @()

foreach ($Row in $Data) {

    foreach ($Column in $Columns) {

        $Value = "$($Row.$Column)"

        # Look for special characters, but allow:
        # letters, numbers, space, dash (-), period (.), comma (,)
        if ($Value -match '[^a-zA-Z0-9\s,\.-]') {
            $Results += [PSCustomObject]@{
                RowNumber        = $RowNumber
                ColumnName       = $Column
                Value            = $Value
                SpecialCharacter = $Matches[0]
            }
        }
    }

    $RowNumber++
}

$Results | Export-Csv $OutputPath -NoTypeInformation

Write-Host "Results exported to $OutputPath"