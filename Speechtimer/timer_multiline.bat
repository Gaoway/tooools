chcp 65001

@echo off
:start
cls
echo ══════════════════════════════════════
echo            汉字统计Pro
echo ══════════════════════════════════════
echo.
echo 请输入文本（按Ctrl+Z结束输入）：
echo.

:: 使用临时文件接收多行输入
set "tempfile=%temp%\hanzi_input.txt"
del "%tempfile%" 2>nul
copy con "%tempfile%" >nul

:: 读取文件内容并转义特殊字符
setlocal enabledelayedexpansion
set "filecontent="
for /f "delims=" %%a in ('type "%tempfile%"') do (
    set "line=%%a"
    set "filecontent=!filecontent!!line!\n"
)
endlocal & set "text=%filecontent%"

:: 统计汉字数量（处理换行符）
for /f %%N in (
  'powershell -command "[regex]::Matches([IO.File]::ReadAllText(\"%tempfile%\"), '[\\u4e00-\\u9fa5]').Count"'
) do set char_count=%%N

:: 计算朗读时间（秒，按3字/秒估算）
set /a speech_time=(char_count + 2) / 3

echo.
echo 汉字数量：%char_count% 字     
echo 预估朗读：%speech_time% 秒 
echo.
del "%tempfile%" 2>nul
pause
goto start

:exit
echo 程序已退出.
pause