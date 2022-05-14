Rem This is specially useful to check shared drive overall usage as you can’t see the info through the explorer
@echo off
setlocal EnableDelayedExpansion

for /F "tokens=1* delims=:" %%a in ('fsutil volume diskfree %1 ') do for %%c in (%%b) do (
   set "D=%%c"
   set /A "D1=!D:~0,-8!,D2=1!D:~-8,-4!-10000,D3=1!D:~-4!-10000"
   for /L %%f in (1,1,3) do ( rem Number of divisions: KB, MB, GB
      set /A "F=0,C=0"
      for /L %%i in (1,1,3) do ( rem Quads in the number of bytes: 3*4 = 12 digits
         set /A "F+=^!^!D%%i"
         if !F! neq 0 set /A "D=C*10000+D%%i,D%%i=D/1024,C=D%%1024"
      )
   )
   set /A "C=C*10000/1024+10000
   echo %%a: !D3!.!C:~1,2! GB
)
