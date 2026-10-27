[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$BasePak,
    [Parameter(Mandatory = $true)][string]$RepakPath,
    [Parameter(Mandatory = $true)][string]$UassetLocalizePath,
    [string]$OutputDirectory = (Join-Path $PSScriptRoot 'build-output')
)

$ErrorActionPreference = 'Stop'
$BasePak = (Resolve-Path -LiteralPath $BasePak).Path
$RepakPath = (Resolve-Path -LiteralPath $RepakPath).Path
$UassetLocalizePath = (Resolve-Path -LiteralPath $UassetLocalizePath).Path
foreach ($path in @($BasePak, $RepakPath, $UassetLocalizePath)) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "File not found: $path" }
}
if (Test-Path -LiteralPath $OutputDirectory) {
    throw "Output folder already exists; choose another -OutputDirectory: $OutputDirectory"
}

$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
$payload = Join-Path $OutputDirectory 'payload'
$temp = Join-Path $OutputDirectory 'imported'
New-Item -ItemType Directory -Path $payload,$temp -Force | Out-Null
& $RepakPath unpack $BasePak --output $payload
if ($LASTEXITCODE -ne 0) { throw "repak unpack failed with exit code $LASTEXITCODE" }

$content = Join-Path $payload 'Octopath_Traveler2\Content'
$translations = Join-Path $PSScriptRoot 'translations'
$jobs = @(
    @{ Asset = 'GameText\Database\GameTextEN.uasset'; Csv = 'gametext_en_vi.csv'; Names = $false; Expected = 14633 },
    @{ Asset = 'Talk\Database\TalkData_EN.uasset'; Csv = 'dialogue_en_vi.csv'; Names = $false; Expected = 30405 },
    @{ Asset = 'Text\Database\GameTextCharacterInfo_EN.uasset'; Csv = 'characterinfo_en_vi.csv'; Names = $true; Expected = 84 },
    @{ Asset = 'Text\Database\GameTextItemInfo_EN.uasset'; Csv = 'iteminfo_en_vi.csv'; Names = $true; Expected = 7 }
)

foreach ($job in $jobs) {
    $asset = Join-Path $content $job.Asset
    $csv = Join-Path $translations $job.Csv
    if (-not (Test-Path -LiteralPath $asset -PathType Leaf)) { throw "Asset missing from base PAK: $asset" }
    $rows = @(Import-Csv -LiteralPath $csv -Encoding utf8)
    if ($rows.Count -ne $job.Expected) { throw "$($job.Csv): expected $($job.Expected) rows, found $($rows.Count)" }
    $out = Join-Path $temp ([IO.Path]::GetFileName($asset))
    $args = @('import', $asset, $csv, '--engine', '5.0', '--match', 'identity', '--out', $out)
    if ($job.Names) { $args += '--names' }
    $result = & $UassetLocalizePath @args 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Import failed for $($job.Asset): $($result -join "`n")" }
    $applied = (($result | Out-String) -match "Applied\s+$($job.Expected)\s+of\s+$($job.Expected)\s+rows")
    if (-not $applied) { throw "Not all rows were applied for $($job.Csv): $($result -join "`n")" }
    Copy-Item -LiteralPath $out -Destination $asset -Force
    Copy-Item -LiteralPath ([IO.Path]::ChangeExtension($out, '.uexp')) -Destination ([IO.Path]::ChangeExtension($asset, '.uexp')) -Force

    $roundTrip = Join-Path $temp ("roundtrip_" + $job.Csv)
    $exportArgs = @('export', $asset, $roundTrip, '--engine', '5.0')
    if ($job.Names) { $exportArgs += '--names' }
    $exportResult = & $UassetLocalizePath @exportArgs 2>&1
    if ($LASTEXITCODE -ne 0) { throw "Round-trip export failed for $($job.Asset): $($exportResult -join "`n")" }
    $roundRows = @(Import-Csv -LiteralPath $roundTrip -Encoding utf8)
    if ($roundRows.Count -ne $rows.Count) { throw "Round-trip row count mismatch for $($job.Csv): $($roundRows.Count)/$($rows.Count)" }
    $roundMap = @{}
    foreach ($roundRow in $roundRows) {
        $identity = $roundRow.Path + [char]0 + $roundRow.Key
        if ($roundMap.ContainsKey($identity)) { throw "Duplicate round-trip identity in $($job.Csv): $identity" }
        $roundMap[$identity] = $roundRow.Translation
    }
    foreach ($sourceRow in $rows) {
        $identity = $sourceRow.Path + [char]0 + $sourceRow.Key
        if (-not $roundMap.ContainsKey($identity) -or $roundMap[$identity] -cne $sourceRow.Translation) {
            throw "Round-trip translation mismatch in $($job.Csv) at $($sourceRow.Path)"
        }
    }
    Write-Host "Imported and verified row count: $($job.Csv) ($($job.Expected))"
}

& $RepakPath pack $payload --version V11 --mount-point ../../../ --path-hash-seed 836401085
if ($LASTEXITCODE -ne 0) { throw "repak pack failed with exit code $LASTEXITCODE" }
$packed = Join-Path $OutputDirectory 'payload.pak'
$final = Join-Path $OutputDirectory 'zzz_Octopath_Traveler2_Vietnamese_custom_P.pak'
Move-Item -LiteralPath $packed -Destination $final
$info = & $RepakPath info $final
if ($LASTEXITCODE -ne 0 -or (($info | Out-String) -notmatch '388 file entries')) {
    throw "Built PAK failed structural verification: $($info -join "`n")"
}
$sha = (Get-FileHash -LiteralPath $final -Algorithm SHA256).Hash
Write-Host "Built PAK: $final"
Write-Host "SHA-256: $sha"
