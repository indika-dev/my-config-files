$vmid = gsudo hcsdiag list | Select-String -Pattern '(?im)^[{(]?[0-9A-F]{8}[-]?(?:[0-9A-F]{4}[-]?){3}[0-9A-F]{12}[)}]?$'
$vmid = $vmid -replace "`n",""
gsudo C:\Program Files\VcXsrv\vcxsrv.exe ':0' -vmid '{'+$vm+'}' -vsockport 106000 -ac -wgl +xinerama
