# Face Attendance System Launcher
# Double-click this file or run: .\run.ps1

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Face Attendance System Launcher" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Starting application..." -ForegroundColor Green
Write-Host ""

& .\venv_windows\Scripts\python.exe main.py

Write-Host ""
Write-Host "Application closed." -ForegroundColor Yellow
Read-Host "Press Enter to exit"
