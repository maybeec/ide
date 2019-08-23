@echo off

pushd %~dp0
echo Setting up your devon-ide in %CD%
call scripts\devon.bat ide setup
reg import system/windows/cmd/devon-cmd.reg
reg import system/windows/power-shell/devon-power-shell.reg

for /F "usebackq tokens=2*" %%O in (`call "%SystemRoot%"\system32\reg.exe query "HKLM\Software\Cygwin\setup" /v "rootdir" 2^>nul ^| "%SystemRoot%\system32\findstr.exe" REG_SZ`) do set CYGWIN_HOME=%%P
if exist "%CYGWIN_HOME%\bin\bash.exe" (
  reg import system/windows/cygwin/devon-cygwin.reg
  "%CYGWIN_HOME%\bin\bash.exe" -l -c "cd \"%CD%\";./scripts/devon"
)

echo Setup of devon-ide completed
pause

popd
