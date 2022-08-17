::                      Turning Off The Environment Prompt
@ECHO OFF

::                      Enabling The Variable Expansion Throughout The Script
SETLOCAL EnableDelayedExpansion
COLOR 0a      

::                      Assigning The Title to the Program
TITLE Wi-Fi Friendly Tool     
CLS       

::                      Creating Banner For User
ECHO.
ECHO.        
ECHO        ###       ### ########## ###         ########   ########  ####    ####  ########## 
ECHO        ###       ### ###        ###        ###    ### ###    ### ###### ###### ###        
ECHO        ###       ### ###        ###        ###        ###    ### ### ##### ### ###        
ECHO        ###  ###  ### ########   ###        ###        ###    ### ###  ###  ### ########   
ECHO        ### ##### ### ###        ###        ###        ###    ### ###       ### ###        
ECHO         ##### #####  ###        ###        ###    ### ###    ### ###       ### ###        
ECHO          ###   ###   ########## ##########  ########   ########  ###       ### ########## 
ECHO.
ECHO.
ECHO.
ECHO    Press " E.N.T.E.R " to Start The Application . . . . . . 
PAUSE > NULL

::                          Process To Check Administrative Priviledges
COLOR 0b
CLS
ECHO.
ECHO.
ECHO                Checking For The Administrative Priviledges . . . . . . . . . .
ping localhost -n 2 >NULL
CLS
ECHO.
ECHO.
ECHO                Checking For The Administrative Priviledges . . .  
ping localhost -n 2 >NULL
CLS
ECHO.
ECHO.
ECHO                Checking For The Administrative Priviledges . . . . . . . . . .
ping localhost -n 2 >NULL
CLS
ECHO.
ECHO.
ECHO                Checking For The Administrative Priviledges . . .  
ping localhost -n 2 >NULL
CLS
net session >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
COLOR 0a
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                            *-----------------------------------------------*
ECHO                                Granted The Administrative Priviledges 
ECHO                            *-----------------------------------------------*
ECHO.
ping localhost -n 3 >null
) ELSE (
COLOR 7C
ECHO.
ECHO        [  Please Run This Program As an Administrative  ]
ECHO.
ping localhost -n 1 >NULL
IF EXIST "NULL" DEL NULL
PAUSE >NULL
GOTO :ProgramExit
)
