; Instalador de la aplicación CarlosLeon
; Licencia GPL 20160926


; Definición general del instalador
!include "MUI2.nsh"  
!define NOMBRE "CarlosLeon"
!define VERSION "UT1_1" 
!define ICONO "icono.ico"


Name "${NOMBRE} - ${VERSION}"
Icon "icono.ico"
OutFile "CarlosLeon.exe"
SetCompressor LZMA


;Directorio de Instalación por defecto
InstallDir $PROGRAMFILES\CarlosLeon

;Variables
  Var StartMenuFolder

;Configuración de la interfaz de instalación
!define MUI_ICON "icono.ico"
!define MUI_ABORTWARNING


;Páginas del Instalador
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "licencia.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES 
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_DIRECTORY
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;Idiomas
!insertmacro MUI_LANGUAGE "Spanish"


Section "aplicacion"
	SetOutPath $INSTDIR
	File dist\Tarea01.jar
	File licencia.txt
	File icono.ico
	WriteUninstaller "$INSTDIR\desinstalar.exe" ;creamos el desinstalador
	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
		CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
		CreateShortCut "$SMPROGRAMS\$StartMenuFolder\CarlosLeon.lnk" "$INSTDIR\Tarea01.jar"
		CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Licencia.lnk" "$INSTDIR\licencia.txt"
		CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Desinstalar.lnk" "$INSTDIR\desinstalar.exe"
	!insertmacro MUI_STARTMENU_WRITE_END
	CreateShortcut "$DESKTOP\CarlosLeon.lnk" "$INSTDIR\Tarea01.jar"
SectionEnd

Section "Uninstall"
	Delete "$PROGRAMFILES\CarlosLeon\Tarea01.jar"
	Delete "$PROGRAMFILES\CarlosLeon\licencia.txt"
	Delete "$PROGRAMFILES\CarlosLeon\icono.ico"
	Delete "$PROGRAMFILES\CarlosLeon\desinstalar.exe"
	Delete "$SMPROGRAMS\$StartMenuFolder\CarlosLeon.lnk"
	Delete "$SMPROGRAMS\$StartMenuFolder\Licencia.lnk"
	Delete "$SMPROGRAMS\$StartMenuFolder\Desinstalar.lnk"
	RMDir "$SMPROGRAMS\$StartMenuFolder\CarlosLeon"
	Delete "$DESKTOP\CarlosLeon.lnk"
	Delete "${NSISDIR}\CarlosLeon"
	
SectionEnd

Function .onInstSuccess
  MessageBox MB_OK "El programa ${NOMBRE} ${VERSION} se ha instalado correctamente. Usa el acceso directo del escritorio para acceder a la aplicación."
FunctionEnd