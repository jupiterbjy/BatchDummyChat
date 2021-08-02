@echo off
rem 인수로 파일정보를 받고, 각 열마다 앞에 #을 붙입니다.
rem for ~~ | FIND /N 사용시 인덱스가 1로 고정되어 분리합니다.
for /f "usebackq delims=:" %%i in (`TYPE %1`) do echo #%%i