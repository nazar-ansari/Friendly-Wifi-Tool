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
ECHO.        
ECHO    ___________      .__              .__       .___      
ECHO    \_   _____/______^|__^| ____   ____ ^|  ^|    __^| _/__.__.
ECHO     ^|    __) \_  __ \  ^|/ __ \ /    \^|  ^|   / __ ^<   ^|  ^|
ECHO     ^|     \   ^|  ^| \/  \  ___/^|   ^|  \  ^|__/ /_/ ^|\___  ^|
ECHO     \___  /   ^|__^|  ^|__^|\___  ^>___^|  /____/\____ ^|/ ____^|
ECHO         \/                  \/     \/           \/\/     
ECHO           __      __.__         ___________.__               
ECHO          /  \    /  \__^|        \_   _____/^|__^|              
ECHO          \   \/\/   /  ^|  ______ ^|    __)  ^|  ^|              
ECHO           \        /^|  ^| /_____/ ^|     \   ^|  ^|              
ECHO            \__/\  / ^|__^|         \___  /   ^|__^|              
ECHO                 \/                   \/                      
ECHO                        ___________           .__                         
ECHO                        \__    ___/___   ____ ^|  ^|                        
ECHO                          ^|    ^| /  _ \ /  _ \^|  ^|                        
ECHO                          ^|    ^|(  ^<_^> ^|  ^<_^> )  ^|__                      
ECHO                          ^|____^| \____/ \____/^|____/                      
ECHO.
ECHO    (Version : 1.0.1)
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

::                              Function To Delete The Selected Profile 
:DeleteProfile
NETSH WLAN DELETE PROFILE NAME="!PROFILE[%UserChoice%]!" >NULL
IF %ERRORLEVEL% EQU 0 (
    CLS
    ECHO.
    ECHO            ----------------------------------------------------------
    ECHO            Successfully Deleted The Profile "!PROFILE[%UserChoice%]!" From The System .
    ECHO            ----------------------------------------------------------
    ECHO.
    IF EXIST "NULL" DEL NULL
    PAUSE >NULL
    GOTO :ProgramExit
) ELSE (
    CLS
    COLOR 7C
    ECHO.
    ECHO            --------------------------------------------------------
    ECHO            Unable To Delete The Profile "!PROFILE[%UserChoice%]!" S O R R Y Try Later .
    ECHO            --------------------------------------------------------
    ECHO.
    PAUSE >NULL
    GOTO :ProgramExit
)

@REM

::                                  Function To Export The Selected Profile
:ExportProfile
DIR | FINDSTR /I "!PROFILE[%UserChoice%]!.XML" >NULL
IF %ERRORLEVEL% EQU 0 (
    CLS
    ECHO.
    ECHO        The Exported Profile of "!PROFILE[%UserChoice%]!" Already Exist in Working Directory . 
    ECHO.
    ECHO   -------------------------------------------------
    DIR | FINDSTR /I "!PROFILE[%UserChoice%]!.xml" 
    ECHO   -------------------------------------------------
    ECHO.
    IF EXIST "NULL" DEL NULL
    PAUSE >NULL
    GOTO :ProgramExit
) ELSE (
    NETSH WLAN EXPORT PROFILE NAME="!PROFILE[%UserChoice%]!" FOLDER=. >NULL
    CLS
    ECHO.
    ECHO            --------------------------------------------------------
    ECHO            Successfully Exported And Saved As "Wi-Fi-!PROFILE[%UserChoice%]!.xml" 
    ECHO            --------------------------------------------------------
    ECHO.
    IF EXIST "NULL" DEL NULL
    PAUSE >NULL
    GOTO :ProgramExit
)

@REM

::                                  Function To Show Cache PASSWORD OF The Selected Profile from The System
:ShowPassword
NETSH WLAN SHOW PROFILE NAME="!PROFILE[%UserChoice%]!" key=clear | FINDSTR /I CONTENT >>PASS.TXT
FOR /F "TOKENS=4 DELIMS= " %%A IN (PASS.TXT) DO (SET ProfilePassword="%%A" )
DEL PASS.TXT
CLS
COLOR 0E
ECHO.
ECHO             ----------------------------------------------
ECHO               The PASSWORD of "!PROFILE[%UserChoice%]!" is %ProfilePassword%
ECHO             ----------------------------------------------
ECHO.
IF EXIST "NULL" DEL NULL
PAUSE >NULL
GOTO :ProgramExit

@REM

::                                  Function To Make a Connection To The Selected Profile
:Connection
CLS
ECHO.
NETSH WLAN DISCONNECT >NULL
ECHO.
NETSH WLAN CONNECT NAME="!PROFILE[%UserChoice%]!" SSID="!PROFILE[%UserChoice%]!" INTERFACE=Wi-Fi >NULL
IF %ERRORLEVEL% EQU 0 (
ECHO.
ECHO         Successfully Connected To "!PROFILE[%UserChoice%]!"
ECHO.
IF EXIST "NULL" DEL NULL
PAUSE >NULL
GOTO :ProgramExit) ELSE (
    CLS
    COLOR 7C
    ECHO.
    ECHO            "!PROFILE[%UserChoice%]!" Is Not Available To CONNECT .
    ECHO.
    DEL NULL
    PAUSE >NULL
    EXIT /B 0
)
DEL NULL

@REM

::                                  Function To Disconnect To The Selected Profile
:Disconnect
CLS
NETSH WLAN DISCONNECT >NULL
ECHO.
ECHO        D I S C O N N E C T E D 
ECHO.
IF EXIST "NULL" DEL NULL
PAUSE >NULL
GOTO :ProgramExit

@REM 

::                                  Function to Assign the profile name into PROFILE ARRAY
:Profiles
SET PROFILE[%Array%]=%~1
SET /A Array+=1
SET /A Iteration+=1

::                                  Function To Redirect to Exit
:ProgramExit
IF EXIST "NULL" DEL NULL

