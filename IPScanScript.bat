@echo off
REM Set the netmask (1 = 8 bits, 0 = 0 bits)
set /a O1s=1
set /a O2s=1
set /a O3s=1
set /a O4s=0

REM Set octet values for this network scan
set /a O1=192
set /a O2=168
set /a O3=1
set /a O4=0

REM Set the IP scan range and make the default value be set by the netmask
If %O1s% EQU 0 ( 
	set /a O1m=255 )
If %O2s% EQU 0 (
	set /a O2m=255 )
If %O3s% EQU 0 (
	set /a O3m=255 )
If %O4s% EQU 0 (
	set /a O4m=255 )

REM Set ICMP echo parameters for this scan
set /a ntimeout=1
set /a necho=1


REM Set the results output filename
set resultsfile=C:\temp\output_%computername%_%date:~-7,2%%date:~-10,2%%date:~-4,4%_%time:~-11,2%%time:~-8,2%-%time:~-5,2%%time:~-2,2%.txt

:O4increment
If %O4s% EQU 1 (
	goto:O3increment )
set /a O4+=1 
echo Scanning for %O1%.%O2%.%O3%.%O4%
ping -n %ntimeout% -w %necho% %O1%.%O2%.%O3%.%O4% | FIND /i "TTL" >> %resultsfile%
If %O4% lss %O4m% (
	goto:O4increment else goto:O3increment )

:O3increment
If %O3s% EQU 1 (
	goto:O2increment )
set /a O3+=1
If %O4s% EQU 0 (
set /a O4=0 )
If %O3% LEQ %O3m% (
	goto:O4increment else goto:O2increment )

:O2increment
If %O2s% EQU 1 (
	goto:O1increment )
set /a O2+=1
If %O4s% EQU 0 (
set /a O4=0 )
If %O3s% EQU 0 (
set /a O3=0 )
If %O2% LEQ %O2m% (
	goto:O4increment else goto:O1increment )

:O1increment
If %O1s% EQU 1 ( exit else ^ )
set /a O1+=1
If %O4s% EQU 0 (
set /a O4=0 )
If %O3s% EQU 0 (
set /a O3=0 )
If %2s% EQU 0 (
set /a O2=0 )
If %O1% LEQ %O1m% (
	goto:O4increment else exit )