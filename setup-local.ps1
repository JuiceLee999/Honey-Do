$env:PATH = "C:\Program Files\nodejs;" + $env:PATH
Set-Location "C:\Users\Juicy\japps"
Remove-Item -Recurse -Force node_modules -ErrorAction SilentlyContinue
& "C:\Program Files\nodejs\npm.cmd" install
Write-Host "--- Install complete, starting server ---"
& "C:\Program Files\nodejs\node.exe" server.js
