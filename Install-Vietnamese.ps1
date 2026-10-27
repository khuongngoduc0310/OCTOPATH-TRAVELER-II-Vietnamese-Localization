[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$GameRoot,
    [string]$PakPath = (Join-Path $PSScriptRoot 'release-assets\zzz_Octopath_Traveler2_Vietnamese_v213_P.pak')
)

$ErrorActionPreference = 'Stop'
$expectedHash = 'C3B5153E503CC3314721D7C1956D3A21B53756165F6F654A7288BA2B490B6B11'

if (-not $GameRoot) {
    $GameRoot = Read-Host 'Enter the game folder that contains Octopath_Traveler2'
}
$exe = Join-Path $GameRoot 'Octopath_Traveler2\Binaries\Win64\Octopath_Traveler2-Win64-Shipping.exe'
if (-not (Test-Path -LiteralPath $exe -PathType Leaf)) {
    throw "Game executable was not found. GameRoot should contain Octopath_Traveler2: $GameRoot"
}
if (-not (Test-Path -LiteralPath $PakPath -PathType Leaf)) {
    throw "Translation PAK not found: $PakPath. Download the v213 PAK asset or pass -PakPath."
}

$actualHash = (Get-FileHash -LiteralPath $PakPath -Algorithm SHA256).Hash
if ($actualHash -ne $expectedHash) {
    throw "PAK checksum mismatch. Expected $expectedHash; found $actualHash"
}

$mods = Join-Path $GameRoot 'Octopath_Traveler2\Content\Paks\~mods'
$target = Join-Path $mods 'zzz_Octopath_Traveler2_Vietnamese_v213_P.pak'
if (Test-Path -LiteralPath $target -PathType Leaf) {
    $installedHash = (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash
    if ($installedHash -eq $expectedHash) {
        Write-Host 'Vietnamese v213 is already installed.'
        exit 0
    }
    throw "A different PAK already uses the v213 filename: $target. Move it aside manually before installing."
}

if ($PSCmdlet.ShouldProcess($target, 'Install Vietnamese translation PAK')) {
    New-Item -ItemType Directory -Path $mods -Force | Out-Null
    Copy-Item -LiteralPath $PakPath -Destination $target
    if ((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne $expectedHash) {
        throw 'Installed file failed checksum verification.'
    }
    Write-Host "Installed Vietnamese v213: $target"
    Write-Host 'Fully close and restart the game to load the new PAK.'
}
