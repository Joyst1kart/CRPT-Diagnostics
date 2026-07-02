# ==================================================
# CRPT Diagnostics
# Main entry point
# ==================================================
. "$PSScriptRoot\Modules\Common.ps1"
. "$PSScriptRoot\Modules\Dns.ps1"
. "$PSScriptRoot\Modules\Tcp.ps1"
. "$PSScriptRoot\Modules\Https.ps1"
. "$PSScriptRoot\Modules\Engine.ps1"
. "$PSScriptRoot\Modules\Report.ps1"

Write-Log "Starting CRPT Diagnostics..." Cyan

$config = Get-Configuration "$PSScriptRoot\..\config\servers.json"

Write-Log "Application : $($config.application.name)" Green
Write-Log "Version     : $($config.application.version)" Green

$results = Invoke-Diagnostics -Configuration $config

Show-ConsoleReport -Results $results