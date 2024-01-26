@echo off

echo Running on %ComputerName%
rem call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64
call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -arch=x64 -host_arch=x64

set IncludeDirectory=include
set SourceDirectory=src
set OutputDirectory_D=debug
set OutputDirectory_R=release

IF NOT EXIST "%OutputDirectory_D%*" (
	mkdir %OutputDirectory_D%
)
IF NOT EXIST "%OutputDirectory_R%*" (
	mkdir %OutputDirectory_R%
)

set CompilerFlags=/GS /TC /W3 /Gm- /WX- /Gd /nologo
set CompilerFlags=%CompilerFlags% /Zc:wchar_t /Zc:inline /fp:precise /errorReport:prompt /Zc:forScope
set CompilerFlags=%CompilerFlags% /D "WIN32" /D "_WINDOWS" /D "_GLFW_USE_CONFIG_H" /D "_CRT_SECURE_NO_WARNINGS" /D "_MBCS"
set IncludeFolders=/I"%IncludeDirectory%" /I"%SourceDirectory%"
set LinkerFlags=/MACHINE:X64 /NOLOGO
set CompilerFlags_D=%CompilerFlags% /Od /Ob0 /MTd /RTC1 /Zi /Fd"%OutputDirectory_D%\glfw3.pdb" /D "CMAKE_INTDIR=\"%OutputDirectory_D%\""
set CompilerFlags_R=%CompilerFlags% /O2 /Ob2 /MT /D "NDEBUG" /D "CMAKE_INTDIR=\"%OutputDirectory_R%\""

rem +--------------------------------------------------------------+
rem [                            Debug                             ]
rem +--------------------------------------------------------------+
echo [Compiling Debug Library]
set ObjectFiles=
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\context.obj"        "%SourceDirectory%\context.c"        & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\context.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\egl_context.obj"    "%SourceDirectory%\egl_context.c"    & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\egl_context.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\init.obj"           "%SourceDirectory%\init.c"           & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\init.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\input.obj"          "%SourceDirectory%\input.c"          & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\input.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\monitor.obj"        "%SourceDirectory%\monitor.c"        & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\monitor.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\null_init.obj"      "%SourceDirectory%\null_init.c"      & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\null_init.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\null_joystick.obj"  "%SourceDirectory%\null_joystick.c"  & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\null_joystick.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\null_monitor.obj"   "%SourceDirectory%\null_monitor.c"   & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\null_monitor.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\null_window.obj"    "%SourceDirectory%\null_window.c"    & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\null_window.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\osmesa_context.obj" "%SourceDirectory%\osmesa_context.c" & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\osmesa_context.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\platform.obj"       "%SourceDirectory%\platform.c"       & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\platform.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\vulkan.obj"         "%SourceDirectory%\vulkan.c"         & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\vulkan.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\wgl_context.obj"    "%SourceDirectory%\wgl_context.c"    & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\wgl_context.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\win32_init.obj"     "%SourceDirectory%\win32_init.c"     & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\win32_init.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\win32_joystick.obj" "%SourceDirectory%\win32_joystick.c" & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\win32_joystick.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\win32_module.obj"   "%SourceDirectory%\win32_module.c"   & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\win32_module.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\win32_monitor.obj"  "%SourceDirectory%\win32_monitor.c"  & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\win32_monitor.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\win32_thread.obj"   "%SourceDirectory%\win32_thread.c"   & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\win32_thread.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\win32_time.obj"     "%SourceDirectory%\win32_time.c"     & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\win32_time.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\win32_window.obj"   "%SourceDirectory%\win32_window.c"   & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\win32_window.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\window.obj"         "%SourceDirectory%\window.c"         & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\window.obj"
cl /c %CompilerFlags_D% %IncludeFolders% /Fo"%OutputDirectory_D%\debug.obj"          "%SourceDirectory%\debug.c"          & set ObjectFiles=%ObjectFiles% "%OutputDirectory_D%\debug.obj"
LINK /lib %LinkerFlags% /OUT:"%OutputDirectory_D%\glfw3.lib" %ObjectFiles%

rem +--------------------------------------------------------------+
rem [                           Release                            ]
rem +--------------------------------------------------------------+
echo [Compiling Release Library]
set ObjectFiles=
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\context.obj"        "%SourceDirectory%\context.c"        & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\context.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\egl_context.obj"    "%SourceDirectory%\egl_context.c"    & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\egl_context.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\init.obj"           "%SourceDirectory%\init.c"           & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\init.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\input.obj"          "%SourceDirectory%\input.c"          & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\input.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\monitor.obj"        "%SourceDirectory%\monitor.c"        & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\monitor.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\null_init.obj"      "%SourceDirectory%\null_init.c"      & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\null_init.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\null_joystick.obj"  "%SourceDirectory%\null_joystick.c"  & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\null_joystick.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\null_monitor.obj"   "%SourceDirectory%\null_monitor.c"   & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\null_monitor.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\null_window.obj"    "%SourceDirectory%\null_window.c"    & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\null_window.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\osmesa_context.obj" "%SourceDirectory%\osmesa_context.c" & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\osmesa_context.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\platform.obj"       "%SourceDirectory%\platform.c"       & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\platform.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\vulkan.obj"         "%SourceDirectory%\vulkan.c"         & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\vulkan.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\wgl_context.obj"    "%SourceDirectory%\wgl_context.c"    & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\wgl_context.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\win32_init.obj"     "%SourceDirectory%\win32_init.c"     & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\win32_init.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\win32_joystick.obj" "%SourceDirectory%\win32_joystick.c" & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\win32_joystick.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\win32_module.obj"   "%SourceDirectory%\win32_module.c"   & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\win32_module.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\win32_monitor.obj"  "%SourceDirectory%\win32_monitor.c"  & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\win32_monitor.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\win32_thread.obj"   "%SourceDirectory%\win32_thread.c"   & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\win32_thread.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\win32_time.obj"     "%SourceDirectory%\win32_time.c"     & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\win32_time.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\win32_window.obj"   "%SourceDirectory%\win32_window.c"   & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\win32_window.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\window.obj"         "%SourceDirectory%\window.c"         & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\window.obj"
cl /c %CompilerFlags_R% %IncludeFolders% /Fo"%OutputDirectory_R%\debug.obj"          "%SourceDirectory%\debug.c"          & set ObjectFiles=%ObjectFiles% "%OutputDirectory_R%\debug.obj"
LINK /lib %LinkerFlags% /OUT:"%OutputDirectory_R%\glfw3.lib" %ObjectFiles%

rem set ObjectFiles=
rem cl /nologo /Fo:object1.obj /c main.cpp & set ObjectFiles=%ObjectFiles% object1.obj
rem cl /nologo /Fo:object2.obj /c test.cpp & set ObjectFiles=%ObjectFiles% object2.obj
rem link /lib /nologo %ObjectFiles% /OUT:test.exe

del %OutputDirectory_D%\*.obj > NUL 2> NUL
del %OutputDirectory_R%\*.obj > NUL 2> NUL
