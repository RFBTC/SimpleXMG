@echo off





rem WELCOME MESSAGE

color 0B
echo Welcome to SimpleXMG Configurator for cpuminer-opt!         https://github.com/JayDDee/cpuminer-opt
echo.
echo.
echo.





rem ASK CPU ARCHITECTURE

echo SELECT YOUR CPU ARCHITECTURE:
echo 1 - Core2, Nehalem, generic x86_64 with SSE2              (cpuminer-sse2.exe)
echo 2 - Westmere                                              (cpuminer-aes-sse42.exe)
echo 3 - Sandybridge, Ivybridge                                (cpuminer-avx.exe)
echo 4 - Haswell, Skylake, Kabylake, Coffeelake, Cometlake     (cpuminer-avx2.exe)
echo 5 - AMD Zen1, Zen2                                        (cpuminer-avx2-sha.exe)
echo 6 - Intel Alderlake, AMD Zen3                             (cpuminer-avx2-sha-vaes.exe)
echo 7 - Intel HEDT Skylake-X, Cascadelake                     (cpuminer-avx512.exe)
echo 8 - AMD Zen4, Intel Rocketlake, Icelake                   (cpuminer-avx512-sha-vaes.exe)
echo.





rem TYPE CPU ARCHITECTURE

:architecture
color 0B
set /p architecture=" Type 1-8 and hit Enter: "





rem CHECK CPU ARCHITECTURE

if "%architecture%"=="1" (
    set "command=cpuminer-sse2.exe -a m7m"
) else if "%architecture%"=="2" (
    set "command=cpuminer-aes-sse42.exe -a m7m"
) else if "%architecture%"=="3" (
    set "command=cpuminer-avx.exe -a m7m"
) else if "%architecture%"=="4" (
    set "command=cpuminer-avx2.exe -a m7m"
) else if "%architecture%"=="5" (
    set "command=cpuminer-avx2-sha.exe -a m7m"
) else if "%architecture%"=="6" (
    set "command=cpuminer-avx2-sha-vaes.exe -a m7m"
) else if "%architecture%"=="7" (
    set "command=cpuminer-avx512.exe -a m7m"
) else if "%architecture%"=="8" (
    set "command=cpuminer-avx512-sha-vaes.exe -a m7m"
) else (
    color 0C
    echo Invalid input.
    echo.
    goto architecture
)
echo.
echo.





rem ASK MINING TYPE

:type
color 0B
echo DO YOU WANT TO SOLO-MINE OR POOL-MINE?
set /p type="Type 'solo' or 'pool' and hit Enter: "





rem CHECK MINING TYPE

if /i "%type%"=="solo" (
    goto file





rem ASK POOL-MINING

) else if /i "%type%"=="pool" (
    echo.
    echo.
    set /p poolurl="ENTER THE FULL POOL URL (e. g. stratum+tcp://www.example.com:port): "
    echo.
    echo.
    set /p pooluser="ENTER YOUR POOL USERNAME (often a wallet address): "
    echo.
    echo.
    set /p poolpass="ENTER YOUR POOL PASSWORD (multi-crypto pools often use c=XMG): "
    echo.
    echo.
    set /p poolthreads="SET THE NUMBER OF THREADS: "
) else (
    color 0C
    echo Invalid input.
    echo.
    goto type
)





rem CHECK POOL-MINING INPUT

if not "%poolurl%"=="" (
    if not "%pooluser%"=="" (
        if not "%poolpass%"=="" (
            if not "%poolthreads%"=="" (
                set "command=%command% -o %poolurl% -u %pooluser% -p %poolpass% -t %poolthreads%"
                goto save
            )
        )
    )
)
color 0C
echo Invalid input.
echo.
goto type





rem LOOK FOR MAGI WALLET CONFIGURATION FILE

:file
echo.
echo.
set "file=%AppData%\Magi\magi.conf"
echo Looking for '%file%'...





rem IF THE FILE EXISTS

if exist "%file%" (
    echo 'magi.conf' found!
    echo.
    echo.
    echo MAKE SURE THE FOLLOWING LINES ARE INCLUDED IN YOUR 'magi.conf' FILE THAT JUST OPENED:
    echo rpcuser=SET_A_USERNAME
    echo rpcpassword=SET_A_PASSWORD
    echo rpcport=8232
    echo rpcallowip=127.0.0.1
    echo server=1





rem IF THE FILE DOESN'T EXIST

) else (
    echo Generating 'magi.conf'...





rem MAGI WALLET CONFIGURATION FILE CONTENT

    echo # Generated by SimpleXMG Configurator>> "%file%"
    echo.>> "%file%"
    echo.>> "%file%"
    echo.>> "%file%"
    echo # EDIT THE FOLLOWING LINES:>> "%file%"
    echo rpcuser=SET_A_USERNAME>> "%file%"
    echo rpcpassword=SET_A_PASSWORD>> "%file%"
    echo.>> "%file%"
    echo.>> "%file%"
    echo.>> "%file%"
    echo # RPC settings>> "%file%"
    echo rpcport=8232>> "%file%"
    echo rpcallowip=127.0.0.1>> "%file%"
    echo server=1 >> "%file%"
    echo.>> "%file%"
    echo # listen=1 to accept connections from outside>> "%file%"
    echo listen=1 >> "%file%"
    echo.>> "%file%"
    echo # Add nodes to connect to specific peers>> "%file%"
    echo addnode=104.128.225.215>> "%file%"
    echo addnode=206.189.74.45>> "%file%"
    echo addnode=45.58.48.63>> "%file%"
    echo addnode=82.65.215.193>> "%file%"
    echo addnode=51.89.116.25>> "%file%"
    echo addnode=146.59.3.53>> "%file%"
    echo addnode=91.164.199.47>> "%file%"
    echo addnode=51.89.116.26>> "%file%"
    echo addnode=163.172.122.60>> "%file%"
    echo addnode=yanis-boucherk.dynamic-dns.net>> "%file%"
    echo.>> "%file%"
    echo # posii=1 to enable PoS staking>> "%file%"
    echo posii=1 >> "%file%"
    echo.>> "%file%"
    echo # Transaction under stake with a value greater than the threshold is being splitted>> "%file%"
    echo stakesplitthreshold=750>> "%file%"
    echo.>> "%file%"
    echo # Transactions with values less than the threshold will combine into one>> "%file%"
    echo stakecombinethreshold=250>> "%file%"





rem SUCCESSFUL GENERATION MESSAGE

    echo Success!
    echo.
    echo.
    echo EDIT THE FOLLOWING LINES IN YOUR 'magi.conf' FILE THAT JUST OPENED:
    echo rpcuser=SET_A_USERNAME
    echo rpcpassword=SET_A_PASSWORD
)





rem OPEN MAGI WALLET CONFIGURATION FILE

start "" "%file%"
echo.
pause





rem ASK SOLO-MINING

echo.
echo.
set /p solouser="ENTER THE RPC USERNAME FROM YOUR 'magi.conf' FILE: "
echo.
echo.
set /p solopass="ENTER THE RPC PASSWORD FROM YOUR 'magi.conf' FILE: "
echo.
echo.
set /p solothreads="SET THE NUMBER OF THREADS: "





rem CHECK SOLO-MINING INPUT

:check
if not "%solouser%"=="" (
    if not "%solopass%"=="" (
        if not "%solothreads%"=="" (
            set "command=%command% -o http://127.0.0.1:8232 -u %solouser% -p %solopass% -t %solothreads%"
            goto save
        )
    )
)
color 0C
echo Invalid input.
echo.
goto type





rem SAVE THE MINING CONFIGURATION FILE

:save
echo.
echo.
echo Generating 'miner.bat' configuration file in the same location as SimpleXMG Configurator...
echo %command% > miner.bat
echo Success!
echo.
echo.
echo.





rem INSTRUCTIONS MESSAGE

echo INSTRUCTIONS:
echo Move the 'miner.bat' configuration file to the cpuminer-opt folder, otherwise the mining software won't start.
echo If you want to have the configuration file in a different location, then create a shortcut and keep the original file in the cpuminer-opt folder.
echo You can rename the configuration file to anything you like.
echo If you want to solo-mine, make sure your wallet is running and unlocked.
echo Run the configuration file to start mining.
echo.
echo.
echo.





rem THANK YOU MESSAGE

echo Thank you for using SimpleXMG by MagiZAP!
echo XMG donation address: 998QXLkP9zjf7G3AE5JdWkBS7Kt83A6kEu
echo.
echo You can now close this window.
pause