# NadirRemote installation with visible confirmation. Requires an elevated PowerShell.
# No passwords are embedded or passed on the command line.
# SPDX-License-Identifier: AGPL-3.0-only
#Requires -RunAsAdministrator
$ErrorActionPreference = 'Stop'
$exe = Join-Path $PSScriptRoot 'NadirRemote.exe'
if (-not (Test-Path -LiteralPath $exe -PathType Leaf)) {
    throw 'Extract the complete NadirRemote-Windows-x64.zip first. NadirRemote.exe is missing.'
}
Write-Host 'NadirRemote will be installed with an automatically starting Windows service.'
Write-Host 'Remote access without confirmation requires a password you set in Security settings.'
$answer = Read-Host 'Type INSTALL to install on this computer, or press Enter to cancel'
if ($answer -cne 'INSTALL') { exit 0 }
$p = Start-Process -FilePath $exe -ArgumentList '--silent-install' -Wait -PassThru
if ($p.ExitCode -ne 0) { throw "Installer returned exit code $($p.ExitCode)" }
# The upstream launcher can return before its elevated installation process finishes.
$service = $null
for ($i = 0; $i -lt 30; $i++) {
    $service = Get-Service -Name 'NadirRemote' -ErrorAction SilentlyContinue
    if ($null -ne $service) { break }
    Start-Sleep -Seconds 2
}
if ($null -eq $service) { throw 'Installation did not register NadirRemote. Open the EXE and use its Install button.' }
Set-Service -Name 'NadirRemote' -StartupType Automatic
Start-Service -Name 'NadirRemote'
$service = Get-Service -Name 'NadirRemote'
$service.WaitForStatus('Running', [TimeSpan]::FromSeconds(30))
Write-Host 'NadirRemote service is running and will start automatically with Windows.'
Write-Host 'Open NadirRemote > Settings > Security and set your own permanent password.'
