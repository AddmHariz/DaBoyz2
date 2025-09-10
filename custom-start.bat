@echo off
setlocal

echo.

REM You can change RAM settings here
REM Set the maximum and minimum RAM for the server

echo Starting server...
java -Xmx8G -Xms8G -jar fabric-server-launch.jar



echo Server process has exited.

echo Verifying shutdown and session safety...

:waitForSessionLockRelease
(
    REM Try to lock the file to confirm it is not in use
    >"world\session.lock" (
        echo session.lock is not locked. Proceeding...
    )
) 2>nul || (
    echo session.lock is still in use. Waiting...
    timeout /t 2 >nul
    goto waitForSessionLockRelease
)

echo Done shutting down! Please commit and push your gameplay and changes to github
pause
