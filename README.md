# Building File Special Character Check

## Overview

This PowerShell script scans selected columns in a CSV file and reports values that contain unsupported special characters.

The script is intended to help validate building/location data before it is used in reporting tools such as Power BI.

## Why this matters

Special characters in building names, addresses, or location fields can cause issues in Power BI slicers and filters. Characters such as `/`, `&`, `#`, `_`, or other unexpected symbols may cause slicer values to display incorrectly, split unexpectedly, or make filtering/reporting inconsistent.

To reduce issues, the script flags characters that are not part of the allowed character set.

## Columns checked

The script checks only columns **D, E, and F** from the input CSV file.

## Allowed characters

The current regex allows:

- Letters: `A-Z`, `a-z`
- Numbers: `0-9`
- Spaces
- Commas: `,`
- Periods: `.`
- Dashes: `-`

Anything outside of this list is reported as a special character.

## Output

The script exports findings to:

```text
results.csv
```

The output file is created in the same folder as the source CSV file.

## Output columns

The results file includes:

- `RowNumber` - Row number from the imported CSV data
- `ColumnName` - Column where the special character was found
- `Value` - Full value from the CSV cell
- `SpecialCharacter` - The character that was flagged

## Example flagged values

| Value | Reason |
|---|---|
| `Building/West` | Contains `/` |
| `Building_West` | Contains `_` |
| `Building & West` | Contains `&` |
| `Floor #2` | Contains `#` |

## Example allowed values

| Value | Reason |
|---|---|
| `Building-West` | Dash is allowed |
| `Building West` | Space is allowed |
| `Seattle, WA` | Comma is allowed |
| `Building.1` | Period is allowed |

## Notes

If valid business data requires additional characters, update the regex in the script to include those characters in the allowed list.
