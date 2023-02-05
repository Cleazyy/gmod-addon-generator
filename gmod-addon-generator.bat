:: Disables the display of commands ::
@echo off

:: Get the addon name ::
set /p addon_name=Enter the name of your addon (ex: infinity_hud): 
set /p table_name=Enter the name of the global table (ex: INFINITY_HUD): 

:: Creating folders ::
md %addon_name%\lua\autorun
md %addon_name%\lua\%addon_name%

:: Creating load file ::
cd %addon_name%/lua/autorun
set autorun_file=%addon_name%_load.lua
echo %table_name% = {}> %autorun_file%
echo.>> %autorun_file%
echo local function RecursiveLoad(path)>> %autorun_file%
echo     local Files, Directories = file.Find(path .. "*", "LUA")>> %autorun_file%
echo.>> %autorun_file%
echo     for _, f in pairs(Files) do>> %autorun_file%
echo         if string.match(f, "^sv") then>> %autorun_file%
echo             if SERVER then>> %autorun_file%
echo                 include(path .. f)>> %autorun_file%
echo             end>> %autorun_file%
echo         elseif string.match(f, "^sh") then>> %autorun_file%
echo             AddCSLuaFile(path .. f)>> %autorun_file%
echo             include(path .. f)>> %autorun_file%
echo         elseif string.match(f, "^cl") then>> %autorun_file%
echo             AddCSLuaFile(path .. f)>> %autorun_file%
echo             if CLIENT then>> %autorun_file%
echo                 include(path .. f)>> %autorun_file%
echo             end>> %autorun_file%
echo         end>> %autorun_file%
echo     end>> %autorun_file%
echo.>> %autorun_file%
echo     for _, d in pairs(Directories) do>> %autorun_file%
echo         RecursiveLoad(path .. d .. "/")>> %autorun_file%
echo     end>> %autorun_file%
echo end>> %autorun_file%
echo.>> %autorun_file%
echo RecursiveLoad("%addon_name%/")>> %autorun_file%

:: Creating config file ::
cd ../%addon_name%
set config_file=sh_config.lua
set /p answer="Do you want a configuration file? (Y/N)"
if /i "%answer%"=="Y" (
	echo %table_name%.CFG = {}> %config_file%
)

:: Creating client folder ::
set /p answer="Do you want a client folder? (Y/N)"
if /i "%answer%"=="Y" (
	mkdir client
)

:: Creating server folder ::
set /p answer="Do you want a server folder? (Y/N)"
if /i "%answer%"=="Y" (
	mkdir server
)