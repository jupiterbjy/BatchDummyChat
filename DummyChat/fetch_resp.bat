@echo off
rem 인수 1=대화타입 2=대화자 3=난수
rem 난수생성이 실행시간으로부터 델타값이 시드인지 랜덤이 고정값만 반환함. 받아와야만 함.

if "%1" equ "" goto EMPTY
goto %1

:EMPTY
	echo GREET, NORMAL, FAREWELL만 지원합니다.
	goto :eof

:GREET
	set resp_target=welcome
	goto EXIT
	
:NORMAL
	set resp_target=normal
	goto EXIT
	
:FAREWELL
	set resp_target=farewell
	goto EXIT


:EXIT
	set full_p=%2_lines\%resp_target%.txt
	set lines=0
	
	for /f "delims=\n" %%i in (%full_p%) do (set /a lines+=1)
	set /a rand=(%3 / (32767/%lines%)) + 1
	
	for /f "usebackq tokens=1,2* delims=[]#" %%i in (`wrapper.bat %full_p%`) do (if %%i equ %rand% set output=:%%j)
	echo %output%