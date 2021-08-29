$ubuntuExePath = "$($env:USERPROFILE)\AppData\Local\Microsoft\WindowsApps\ubuntu2004.exe"
$hostMountPath = $PSScriptRoot.Replace('\', '/').Replace('C:', '/mnt/c').ToLower()

Start-Process -NoNewWindow -FilePath $ubuntuExePath -ArgumentList 'install --root' -Wait 

wsl -d 'Ubuntu-20.04' -u root -e cp $hostMountPath/ubuntu_setup.sh /tmp
wsl -d 'Ubuntu-20.04' -u root -e cp $hostMountPath/krb5.conf /etc
wsl -d 'Ubuntu-20.04' -u root -e sudo bash /tmp/ubuntu_setup.sh $($env:USERNAME )

ubuntu2004 config --default-user $env:USERNAME 

Write-Host "Done!" -ForegroundColor Green