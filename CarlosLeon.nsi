;Instalador de la aplicación CarlosLeon
;Es una aplicación de ejemplo, para comprobar como se crea por script el instalador
;No se modifica el registro de Windows.
;Licencia GPL 20160926


;Definición general del instalador
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
!define MUI_ABORTWARNING

;Páginas del Instalador
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "licencia.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES 
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
!insertmacro MUI_PAGE_FINISH

;Páginas del Desinstalador
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_DIRECTORY
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;Idiomas
!insertmacro MUI_LANGUAGE "Spanish"

;Definimos la sección que instalará la aplicación.
Section "aplicacion"
	SetOutPath $INSTDIR
	;ficheros que se incluirán en la aplicación.
	File dist\Tarea01.jar
	File licencia.txt
	File icono.ico
	;creación del desinstalador
	WriteUninstaller "$INSTDIR\desinstalar.exe"
	;creación del menú de inicio
	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
		CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
		CreateShortCut "$SMPROGRAMS\$StartMenuFolder\CarlosLeon.lnk" "$INSTDIR\Tarea01.jar"
		CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Licencia.lnk" "$INSTDIR\licencia.txt"
		CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Desinstalar.lnk" "$INSTDIR\desinstalar.exe"
	!insertmacro MUI_STARTMENU_WRITE_END
	;creación del acceso directo del escritorio
	CreateShortcut "$DESKTOP\CarlosLeon.lnk" "$INSTDIR\Tarea01.jar"
SectionEnd

;Seccion de desinstalación. Esta sección siempre se debe llamar así para que funcione
;el desinstalador correctamente.
Section "Uninstall"
	;borrado de los archivos de la aplicación
	Delete "$PROGRAMFILES\CarlosLeon\desinstalar.exe"
	Delete "$PROGRAMFILES\CarlosLeon\Tarea01.jar"
	Delete "$PROGRAMFILES\CarlosLeon\licencia.txt"
	Delete "$PROGRAMFILES\CarlosLeon\icono.ico"
	RMDir /r "$INSTDIR"  ;parametro /r para borrar el directorio aunque no esté vacío
	;borrado del acceso directo del escritorio
	Delete "$DESKTOP\CarlosLeon.lnk"
	;borrado del menú de inicio.
	!insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
		Delete "$SMPROGRAMS\$StartMenuFolder\CarlosLeon.lnk" 
		Delete "$SMPROGRAMS\$StartMenuFolder\Licencia.lnk" 
		Delete "$SMPROGRAMS\$StartMenuFolder\Desinstalar.lnk"
		RMDir "$SMPROGRAMS\$StartMenuFolder\"
SectionEnd

;Mensaje de confirmación de la desinstalación correcta del programa.
Function un.onUninstSuccess
  MessageBox MB_OK "El programa ${NOMBRE} ${VERSION} se ha desinstalado correctamente."
FunctionEnd