@echo off
rem �μ��� ���������� �ް�, �� ������ �տ� #�� ���Դϴ�.
rem for ~~ | FIND /N ���� �ε����� 1�� �����Ǿ� �и��մϴ�.
for /f "usebackq delims=:" %%i in (`TYPE %1`) do echo #%%i