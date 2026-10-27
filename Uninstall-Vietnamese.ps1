[CmdletBinding(SupportsShouldProcess = $true)]
param([string]$GameRoot)

$ErrorActionPreference = 'Stop'
if (-not $GameRoot) {
    $GameRoot = Read-Host 'Enter the game folder that contains Octopath_Traveler2'
}
$target = Join-Path $GameRoot 'Octopath_Traveler2\Content\Paks\~mods\zzz_Octopath_Traveler2_Vietnamese_v213_P.pak'
if (-not (Test-Path -LiteralPath $target -PathType Leaf)) {
    Write-Host 'Vietnamese v213 is not installed in this game folder.'
    exit 0
}
if ($PSCmdlet.ShouldProcess($target, 'Remove Vietnamese translation PAK')) {
    Remove-Item -LiteralPath $target
    Write-Host 'Removed Vietnamese v213. Other PAK files were left untouched.'
}
