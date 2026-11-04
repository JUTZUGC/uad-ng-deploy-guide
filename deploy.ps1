# UAD-ng 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation/wiki
# 更新日期：2026-11-04
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -fL -o uad-ng-windows.exe https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation/releases/latest/download/uad-ng-windows.exe
Get-Item uad-ng-windows.exe | Select-Object Name, Length
Start-Process .\uad-ng-windows.exe

Write-Host ''

Write-Host '下载与校验完成，安装包在 .download 目录'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation/wiki'
