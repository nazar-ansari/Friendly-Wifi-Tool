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

::                              Program To Display Available Profiles In The System
SET /A Array=1
SET /A Iteration=1
FOR /F "SKIP=1 TOKENS=2 DELIMS=:" %%G IN ('netsh wlan show profile ^| findstr /i :') DO (
    CALL :Profiles "%%G"
)
SET /A Iteration-=1
CLS
ECHO.
ECHO            **************  Available Profiles In The System  **************
ECHO.
FOR /L %%A IN (1,1,%Iteration%) DO (
    ECHO                  ------------------------------------------------
    ECHO                           {%%A}         !PROFILE[%%A]!         
)
FOR /L %%B IN (1,1,%Iteration%) DO (
     FOR /F "TOKENS=* DELIMS= " %%C IN ("!PROFILE[%%B]!") DO (
        SET PROFILE[%%B]=%%C
     )
)
ECHO.
ECHO.

::                              Getting A value From User
ECHO     ENTER The Number of Above Profile to Perform Operations :
SET /P CHOICE=
IF "%CHOICE%"=="" (
    CLS
    ECHO.
    ECHO                          Invalid Response   S O R R Y
    ECHO.
    PAUSE >NULL
    GOTO :ProgramExit
) ELSE ( SET /A UserChoice=%CHOICE% )
CLS

::                                  Assigning The Profile Information As per Profile Array
NETSH WLAN SHOW INTERFACE | FINDSTR /I "!PROFILE[%UserChoice%]!" >NULL
IF %ERRORLEVEL% EQU 0 ( SET Status=Connected) ELSE ( SET Status=NOT Connected )
ECHO.
ECHO                   ***********    !PROFILE[%UserChoice%]!    **********
ECHO.
ECHO           --------------------------
ECHO            STATUS :  "%Status%"
ECHO           --------------------------
ECHO.
ECHO            Available Operation On This Network :
ECHO.

::                                  Statement To Check Whether The You Are Connected To Particular Profile or NOT
IF "%Status%"=="Connected" (
ECHO            { 1 }      ---   Disconnect This Network .) ELSE (
ECHO            { 1 }      ---   Connect To This Network .
)
ECHO            { 2 }      ---   Show ( Cached ) PASSWORD For this Profile .
ECHO            { 3 }      ---   Export This Profile .
ECHO            { 4 }      ---   Delete These Profile From System .
ECHO.

::                                      To Direct The User Choice To Certain Operation
ECHO      Enter Your Operation Choice :
SET /P OperationChoice=
IF %OperationChoice%==1 (
    IF "%Status%"=="Connected" ( GOTO :Disconnect) ELSE (GOTO :Connection)
    DEL NULL
)
IF %OperationChoice%==2 ( GOTO :ShowPassword )
IF %OperationChoice%==3 ( GOTO :ExportProfile )
IF %OperationChoice%==4 ( GOTO :DeleteProfile ) ELSE ( 
    ECHO.
    ECHO        -------------------
    ECHO           INVALID OPTION      
    ECHO        -------------------
    PAUSE >NULL
    GOTO :ProgramExit)
@REM
