@ECHO Off
SETLOCAL
REM for /f %%i in ('gsudo hcsdiag list') do set str=%%i
:: gsudo hcsdiag list > temp.txt
:: set /p str=<temp.txt
:: ECHO %str%
REM SET "str=This is a string that has a long uuid: (UUID: 359f975d-2649-4e20-b7c0-b452aaaca4b2)"

:: Theoretical

:: SET "hn=[a-f0-9]"
:: SET "hn4=%hn%%hn%%hn%%hn%"
:: SET "hn8=%hn4%%hn4%"
:: SET "wrx=%hn8%-%hn4%-%hn4%-%hn4%-%hn8%%hn4%"
:: :again
:: IF NOT DEFINED str ECHO notfound&GOTO done
:: ECHO %str%|FINDSTR /b /r /i "%wrx%">NUL
:: IF ERRORLEVEL 1 (
::  REM did not find string
::  SET "str=%str:~1%"
::  GOTO again
:: )
:: SET "str=%str:~0,36%"
:: ECHO found "%str%"

:: :done

:: BFI method

REM for /f %%i in ('gsudo hcsdiag list') do set str=%%i
gsudo hcsdiag list > temp.txt
set /p str=<temp.txt
ECHO %str%
REM SET "str=This is a string that has a long uuid: (UUID: 359f975d-2649-4e20-b7c0-b452aaaca4b2)"
:: SET "hn=[a-f0-9]"
:: SET "hn4=%hn%%hn%%hn%%hn%"
:: SET "hn8=%hn4%%hn4%"

:: :bfiagain
:: IF NOT DEFINED str ECHO notfound&GOTO donebfi
:: :: "regex" using brute-force and ignorance
:: ECHO %str:~0,9%|FINDSTR /b /i /r  "%hn8%-">NUL
:: IF ERRORLEVEL 1 GOTO bfino
:: ECHO %str:~9,5%|FINDSTR /b /i /r  "%hn4%-">NUL
:: IF ERRORLEVEL 1 GOTO bfino
:: ECHO %str:~14,10%|FINDSTR /b /i /r  "%hn4%-%hn4%-">NUL
:: IF ERRORLEVEL 1 GOTO bfino
:: ECHO %str:~24,12%|FINDSTR /b /i /r  "%hn4%%hn8%">NUL
:: :bfino
:: IF ERRORLEVEL 1 (
::  SET "str=%str:~1%"
::  GOTO bfiagain
:: )
:: SET "str=%str:~0,36%"
:: ECHO found "%str%"

:: :donebfi

:: GOTO :EOF

:: this works only, because the GUID is the first line in temp.txt!
gsudo C:\Programme\VcXsrv\vcxsrv.exe :0 -vmid {%str%} -vsockport 106000 -ac -wgl +xinerama
