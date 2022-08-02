@echo off
if "%*" == "" (goto noargs)
set "params=%*"

ver>nul
for /f "tokens=2 delims==" %%a in ('wmic process where "name='%params%'" get ExecutablePath /value 2^>nul') do set "ExecutablePath=%%a"
for /f "tokens=2 delims==" %%a in ('wmic process where "name='%params%'" get Name /value 2^>nul') do set "Name=%%a"

ver>nul
taskkill /f /im %* | findstr "SUCCESS:">nul 2>&1
if %errorlevel% neq 0 (exit /b)
ver>nul
start "" "%ExecutablePath%
if %errorlevel% neq 0 (goto error)
echo SUCCESS: The process "%Name%" was successfully restarted.
exit /b

:error
echo ERROR: Cannot start process "%Name%".
exit /b

:noargs
echo ERROR: Invalid syntax. Process name not specified.
exit /b