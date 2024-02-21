@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Code\"
"C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Code\call51\call51\Bin\c51.exe" --use-stdout  "C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Code\Lab4.c"
if not exist hex2mif.exe goto done
if exist Lab4.ihx hex2mif Lab4.ihx
if exist Lab4.hex hex2mif Lab4.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Code\Lab4.hex
