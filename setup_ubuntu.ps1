$ubuntuExePath = "$($env:USERPROFILE)\AppData\Local\Microsoft\WindowsApps\ubuntu2004.exe"
$hostMountPath = $PSScriptRoot.Replace('\', '/').Replace('C:', '/mnt/c').ToLower()

Start-Process -NoNewWindow -FilePath $ubuntuExePath -ArgumentList 'install --root' -Wait 

wsl -d 'Ubuntu-20.04' -e cp $hostMountPath/setup.sh /tmp
wsl -d 'Ubuntu-20.04' -e sudo bash /tmp/setup.sh $($env:USERNAME )

ubuntu2004 config --default-user $env:USERNAME 

Write-Host "Done!" -ForegroundColor Green