@echo off
rem �μ� 1=��ȭŸ�� 2=��ȭ�� 3=����
rem ���������� ����ð����κ��� ��Ÿ���� �õ����� ������ �������� ��ȯ��. �޾ƿ;߸� ��.

if "%1" equ "" goto EMPTY
goto %1

:EMPTY
	echo GREET, NORMAL, FAREWELL�� �����մϴ�.
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