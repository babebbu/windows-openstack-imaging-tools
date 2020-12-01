#$stoppedCloudbaseInit = $null

#do {
#    $stoppedCloudbaseInit = Get-Service -Name 'cloudbase-init' | Where-Object {$_.Status -eq 'Stopped'}
#} while ($null -eq $stoppedCloudbaseInit)

#(Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -Like "Cloudbase-Init *"}).Uninstall()


$res = Invoke-WebRequest http://103.131.202.250/provisioning-scripts/windows/run-mode.txt -UseBasicParsing
$mode = ""
foreach ($char in $res.Content) {
    $mode += [char]$char
}

if ("Invoke-Expression".Equals($mode)) {
    try {
        Invoke-Expression $content | Out-File 'C:\invoke-expression-output.log.txt'
    } catch {
        $_ | Out-File 'C:\invoke-expression-error.log.txt'
    }
} elseif ("Start-Process".Equals($mode)) {
    $FileName = 'C:\finalize.ps1'
    (New-Object System.Net.WebClient).DownloadFile('http://103.131.202.250/provisioning-scripts/windows/finalize.ps1', $FileName)
    Start-Process PowerShell -ArgumentList $FileName
}




#Remove-LocalUser -Name 'cloudbase-init'
#net user cloudbase-init /delete

#Remove-Item -Recurse -Force 'C:\Program Files\Cloudbase Solutions'
#Remove-Item -Recurse -Force 'C:\curtin'
#Remove-Item -Recurse -Force 'C:\root'
#Remove-Item -Recurse -Force 'C:\Users\cloudbase-init'

#Remove-Item -Force -Path $MyInvocation.MyCommand.Path