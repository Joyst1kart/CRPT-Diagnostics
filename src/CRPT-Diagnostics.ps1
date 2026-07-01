# ==================================================
# CRPT Diagnostics
# Main entry point
# ==================================================

# Загружаем общие функции
. "$PSScriptRoot\Modules\Common.ps1"

# Загружаем модули
. "$PSScriptRoot\Modules\Dns.ps1"

Write-Log "Starting CRPT Diagnostics..." Cyan

# Загружаем конфигурацию
$config = Get-Configuration "$PSScriptRoot\..\config\servers.json"

Write-Log "Application : $($config.application.name)" Green
Write-Log "Version     : $($config.application.version)" Green

Write-Host ""

# Массив результатов
$results = @()

# Выполняем DNS-проверки
foreach ($server in $config.servers) {

    if (-not $server.enabled) {
        continue
    }

    $result = Test-Dns -Server $server

    $results += $result
    }

# Пока ничего не выводим
# На следующем шаге добавим красивый вывод результатов
Write-Host ""
Write-Host "DNS Check"
Write-Host "-----------------------------------------------"

foreach ($item in $results)
{
    if($item.Status -eq "Success")
    {
        Write-Host ("{0,-15} {1,-10} {2}" -f `
            $item.Name,
            $item.Status,
            $item.Data.IP) -ForegroundColor Green
    }
    else
    {
        Write-Host ("{0,-15} {1,-10} {2}" -f `
            $item.Name,
            $item.Status,
            $item.Message) -ForegroundColor Red
    }
}