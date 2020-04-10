$sourceConfigDir = 'C:\UnattendResources\Config'
$targetConfigDir = 'C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf'

$sourceLocalScriptPath = 'C:\UnattendResources\LocalScripts'
$targetLocalScriptPath = 'C:\Program Files\Cloudbase Solutions\Cloudbase-Init\LocalScripts'

if((Test-Path $sourceConfigDir)) {
    # Inject Cloudbase-Init Config
    Copy-Item -Recurse -Force "$sourceConfigDir\cloudbase-init.conf" "$targetConfigDir\cloudbase-init.conf"
    Copy-Item -Recurse -Force "$sourceConfigDir\cloudbase-init-unattend.conf" "$targetConfigDir\cloudbase-init-unattend.conf"
}

if(!(Test-Path $targetLocalScriptPath)) {
    mkdir -Path $taegetLocalScriptPath
}

if((Test-Path $sourceLocalScriptPath)) {
    # Inject LocalScripts
    Copy-Item -Recurse -Force $sourceLocalScriptPath 'C:\Program Files\Cloudbase Solutions\Cloudbase-Init\'
}

Move-Item "$targetLocalScriptPath\CleanUp.ps1" "C:\CleanUp.ps1"

Write-Host -NoNewLine "[AfterCloudbaseInitInstall] Once you done any manual configuration or don't want to config, Press any key to continue...";
$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');