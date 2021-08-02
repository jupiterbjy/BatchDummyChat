@echo off

:setup
	title PlayingAlone
	mode con cols=50 lines=30
	
	set /p sorrowful_loner="Your name: "
	
	:GET_LIST
		cls
		echo Available partners:
		
		for /f "usebackq tokens=1,2 delims=_" %%i in (`list_dial.bat`) do echo. ▷ %%i
		echo.
		
		set /p partner="partner: "
		set exist=0
		for /f "usebackq tokens=1,2 delims=_" %%i in (`list_dial.bat`) do (if %%i equ %partner% goto PROCEED)
		echo profile %partner% does not exists.
		pause
		goto GET_LIST
		
	:PROCEED
		set conf=y
		set /p conf="Confirm %partner%? (y/n): "
		if %conf% equ y goto PASSED
		if %conf% equ Y goto PASSED
		goto GET_LIST
		
	:PASSED
	
	set file_loc=%partner%_%sorrowful_loner%.rtf
	set eof_mark=~~
	
	set sl_speaker=【%sorrowful_loner%】
	set speaker=【%partner%】
	
	title Chat with %speaker%
	
	:THEMESELECT
		cls
		echo Recommended themes: e0, f2, 0a, 2a
		echo Defaults to e0 when not specified.
		set theme=e0
		set /p theme="Theme: "
		color %theme%
		
		set engage=y
		set /p engage="Confirm this theme? (y/n): "
		if %engage% equ y goto S_START
		if %engage% equ Y goto S_START
		goto THEMESELECT
		

:S_START
	cls
	echo Enter %eof_mark% to stop chatting.
	pause
	
	cls
	echo - - Session Start - -
	echo - - Session Start - - >> %file_loc%
	echo.
	echo Theme: %theme% / %date% - %time% >> %file_loc%
	echo. >> %file_loc%
	
	:RAND_HS
		rem usebackq를 쓴 for 로 감싸지 않으면 배치파일이 아예 넘어가버리고 종료됨.
		for /f "usebackq delims=:" %%i in (`fetch_resp.bat GREET %partner% %random%`) do set rand_hs=%%i
		echo ↙%speaker%: %rand_hs%
		echo.
		
		echo ↙%speaker% >> %file_loc%
		echo %rand_hs% >> %file_loc%
		echo. >> %file_loc%
		

:LOOP
	set input= 
	set /p input="↗%sl_speaker%: "
	if "%input%" equ "%eof_mark%" goto EXIT
	
	set cur_date=↗%sl_speaker% - %date% / %time%
	echo %cur_date% >> %file_loc%
	echo. %input% >> %file_loc%
	
	:RESPONSE
		for /f "usebackq delims=:" %%i in (`fetch_resp.bat NORMAL %partner% %random%`) do set response=%%i
		
		echo    ‥
		echo ↙%speaker%: %response%
		echo.
		
		echo    ‥ >> %file_loc%
		echo ↙%speaker% >> %file_loc%
		echo %response% >> %file_loc%
		echo. >> %file_loc%
	
	goto LOOP


:EXIT
	:RANDBYE
		for /f "usebackq delims=:" %%i in (`fetch_resp.bat FAREWELL %partner% %random%`) do set rand_bye=%%i
		
		echo    ...
		echo ↙%speaker%: %rand_bye%
		echo.
		echo - -  Session End  - - 
		
		echo    ... >> %file_loc%
		echo ↙%speaker% >> %file_loc%
		echo %rand_bye% >> %file_loc%
		echo - -  Session End  - - >> %file_loc%
		echo. >> %file_loc%
		echo. >> %file_loc%
	
	echo by nyarukoishi / jupiterbjy
	pause
	exit