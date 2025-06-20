chcp 65001

@echo off
:start
cls
echo ══════════════════════════════════════
echo                汉字统计
echo ══════════════════════════════════════
echo.
set /p text=请输入文本：
if "%text%"=="" goto exit

:: 统计汉字数量
for /f %%N in (
  'powershell -command "[regex]::Matches('%text%', '[\u4e00-\u9fa5]').Count"'
) do set char_count=%%N

:: 计算朗读时间（秒，按3字/秒估算）
set /a speech_time=(char_count + 2) / 3  

echo.
echo 汉字数量：%char_count% 字     
echo 预估朗读：%speech_time% 秒 
echo.
pause
goto start

:exit
echo 程序已退出。
pause