@ECHO OFF
TITLE THIS WILL TAKE A WHILE WILL CLOSE AUTOMATICALLY
color b
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...
    
    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto start
    ) else (
        echo Failure: Current permissions inadequate.
    )
    
:start
bcdedit /set linearaddress57 OptOut
timeout /t 1
bcdedit /set increaseuserva 268435328
timeout /t 1
bcdedit /set firstmegabytepolicy UseAll
timeout /t 1
bcdedit /set avoidlowmemory 0x8000000
timeout /t 1
bcdedit /set nolowmem Yes
timeout /t 1
bcdedit /set allowedinmemorysettings 0x0
timeout /t 1
bcdedit /set isolatedcontext No
timeout /t 1
bcdedit /set vsmlaunchtype Off
timeout /t 1
bcdedit /set vm No
timeout /t 1
powershell "ForEach($v in (Get-Command -Name \"Set-ProcessMitigation\").Parameters[\"Disable\"].Attributes.ValidValues){Set-ProcessMitigation -System -Disable $v.ToString() -ErrorAction SilentlyContinue}"
powershell "Remove-Item -Path \"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\*\" -Recurse -ErrorAction SilentlyContinue"
powershell "Disable-MMAgent -MemoryCompression"
timeout /t 1
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
timeout /t 1
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=32768,MaximumSize=32768
timeout /t 1
bcdedit /set x2apicpolicy Enable
timeout /t 1
bcdedit /set configaccesspolicy Default
timeout /t 1
bcdedit /set MSI Default
timeout /t 1
bcdedit /set usephysicaldestination No
timeout /t 1
bcdedit /set usefirmwarepcisettings No
timeout /t 1
bcdedit /deletevalue useplatformclock
timeout /t 1
bcdedit /deletevalue disabledynamictick
timeout /t 1
bcdedit /set useplatformtick Yes
timeout /t 1
bcedit /set useplatformclock Yes
timeout /t 1
bcdedit /set useplatformtick Yes
timeout /t 1
netsh advfirewall set allprofiles state on
goto close
:close
exit
