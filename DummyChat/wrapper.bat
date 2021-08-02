@echo off
rem 오로지 단일명령어만 받는 usebackq를 위해 분리.
rem 번호없이 인덱스 접근을 가능케 하는 로직.
line_indexer.bat %1 | find /n "#"