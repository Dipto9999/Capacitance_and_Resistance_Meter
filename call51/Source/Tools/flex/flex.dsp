# Microsoft Developer Studio Project File - Name="flex" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=flex - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "flex.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "flex.mak" CFG="flex - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "flex - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "flex - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "flex - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "USG" /YX /FD /c
# ADD BASE RSC /l 0x1009 /d "NDEBUG"
# ADD RSC /l 0x1009 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386 /out:"../bin/flex.exe"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ  /c
# ADD CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /D "USG" /YX /FD /GZ  /c
# ADD BASE RSC /l 0x1009 /d "_DEBUG"
# ADD RSC /l 0x1009 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /out:"../bin/flex.exe" /pdbtype:sept

!ENDIF 

# Begin Target

# Name "flex - Win32 Release"
# Name "flex - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\ccl.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\dfa.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\ecs.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\gen.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\main.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\misc.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\nfa.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\parse.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\scan.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\skel.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\sym.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\tblcmp.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\yylex.c

!IF  "$(CFG)" == "flex - Win32 Release"

!ELSEIF  "$(CFG)" == "flex - Win32 Debug"

# SUBTRACT CPP /D "USG"

!ENDIF 

# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project
