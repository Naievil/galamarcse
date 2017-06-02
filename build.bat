@echo off
rem
rem	Delete any existing files
rem

if exist del galamar.8ck

rem
rem	Actually do the work
rem

%~dp0exec\spasm.exe ti84cse.asm -T
%~dp0exec\lite86 ti84cse.bin compressed.bin
%~dp0exec\spasm64 loader.asm loader.bin -T 
%~dp0exec\rabbitsign -t 8xk -g -b -f loader.bin -k 010F.key -o galamar.8ck

rem 
rem	Move files to build
rem

if not exist "%~dp0build" mkdir build
move /Y "%~dp0compressed.bin" "%~dp0build\"
move /Y "%~dp0loader.bin" "%~dp0build\"
move /Y "%~dp0loader.lst" "%~dp0build\"
move /Y "%~dp0ti84cse.bin" "%~dp0build\"
move /Y "%~dp0ti84cse.lst" "%~dp0build\"

pause