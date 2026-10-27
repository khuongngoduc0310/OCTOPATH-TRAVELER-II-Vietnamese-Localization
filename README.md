# OCTOPATH TRAVELER II — Vietnamese Fan Translation

**Version 213 · Unofficial community localization · Windows PC**

This project contains an installable Vietnamese PAK and editable translation sources. It is intended for owners of the PC version of OCTOPATH TRAVELER II. The source files let editors revise dialogue, menus, character/item information and skill/equipment terminology without changing the game mechanics.

## Install

1. Download and extract the all-in-one bundle, or download the PAK release asset and keep it next to this script under `release-assets`.
2. Open PowerShell in this folder and run:

   ```powershell
   .\Install-Vietnamese.ps1 -GameRoot "C:\Games\OCTOPATH TRAVELER II"
   ```

   `GameRoot` is the folder containing `Octopath_Traveler2`.
3. Fully exit the game and launch it again. The script verifies the PAK SHA-256 before installation.

To uninstall, run `Uninstall-Vietnamese.ps1 -GameRoot "<game folder>"`. It removes only this translation PAK. For manual installation, copy `zzz_Octopath_Traveler2_Vietnamese_v213_P.pak` into `Octopath_Traveler2\Content\Paks\~mods`.

## Edit the translation

Edit the UTF-8 CSV files in `translations/` with a spreadsheet editor or a text editor. Keep the `Path`, `Key`, `Source`, and `Translation` columns and preserve all row keys and format placeholders. `Translation` is the editable Vietnamese text. `catalogs/` and `GLOSSARY.md` provide terminology and context; review logs record the recent name edits.

## Build a modified PAK

The build script extracts the included v213 PAK, imports all four editable CSVs, and repacks the full 388-file payload. It leaves the input PAK and source CSVs untouched.

1. Download [repak v0.2.3 for Windows](https://github.com/trumank/repak/releases/tag/v0.2.3) and [UassetLocalize](https://github.com/rm-NoobInCoding/UassetLocalize). The tested repak archive SHA-256 is listed in `tools/README.md`.
2. Run:

   ```powershell
   .\Build-Translation.ps1 `
     -BasePak .\release-assets\zzz_Octopath_Traveler2_Vietnamese_v213_P.pak `
     -RepakPath C:\Tools\repak.exe `
     -UassetLocalizePath C:\Tools\UassetLocalize.Cli.exe
   ```

3. The generated PAK appears in `build-output/`. Install that PAK manually or update the installer’s PAK path and expected hash before distributing a new version.

See `CONTRIBUTING.md` for editing and validation rules. The translation source and project-authored scripts are licensed under CC BY-NC-SA 4.0; see `LICENSE.md`. Game assets and trademarks remain the property of their respective owners. This fan translation is not affiliated with or endorsed by Square Enix.
