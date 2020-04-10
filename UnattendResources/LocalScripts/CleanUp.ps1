$stoppedCloudbaseInit = $null

do {
    $stoppedCloudbaseInit = Get-Service -Name 'cloudbase-init' | Where-Object {$_.Status -eq 'Stopped'}
} while ($stoppedCloudbaseInit -eq $null)

(Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -eq "Cloudbase-Init 1.1.0"}).Uninstall()

#Remove-LocalUser -Name 'cloudbase-init'
net user cloudbase-init /delete

Remove-Item -Recurse -Force 'C:\Program Files\Cloudbase Solutions'
Remove-Item -Recurse -Force 'C:\curtin'
Remove-Item -Recurse -Force 'C:\root'
Remove-Item -Recurse -Force 'C:\Users\cloudbase-init'
Remove-Item -Recurse -Force 'C:\network.json'

Remove-Item -Force -Path $MyInvocation.MyCommand.Path