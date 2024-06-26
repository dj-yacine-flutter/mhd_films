; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{E13315EA-3A3B-439C-BA8F-F86D13C46CD4}
AppName=MHD Films
AppVersion=1.0.0+9
VersionInfoVersion=1.0.0.+9
AppVerName=MHD Films v1.0.0+9
AppPublisher=Djeddi - Yacine
AppPublisherURL=https://github.com/dj-yacine-flutter/
AppSupportURL=https://github.com/dj-yacine-flutter/
AppUpdatesURL=https://github.com/dj-yacine-flutter/
DefaultDirName={autopf}\MHD Films
ChangesAssociations=yes
DisableProgramGroupPage=yes
LicenseFile=C:\Users\yacine\Desktop\code\mhd_films\LICENSE
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputBaseFilename=MHD-Films-Setup
SetupIconFile=C:\Users\yacine\Desktop\code\mhd_films\icons\film-reel.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\yacine\Desktop\code\mhd_films\build\windows\x64\runner\Release\mhd_films.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\yacine\Desktop\code\mhd_films\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Registry]
Root: HKA; Subkey: "Software\Classes\.exe\OpenWithProgids"; ValueType: string; ValueName: "MHDFilms.exe"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\MHDFilms.exe"; ValueType: string; ValueName: ""; ValueData: "MHD Films"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\MHDFilms.exe\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\mhd_films.exe,0"
Root: HKA; Subkey: "Software\Classes\MHDFilms.exe\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\mhd_films.exe"" ""%1"""
Root: HKA; Subkey: "Software\Classes\Applications\mhd_films.exe\SupportedTypes"; ValueType: string; ValueName: ".myp"; ValueData: ""

[Icons]
Name: "{autoprograms}\MHD Films"; Filename: "{app}\mhd_films.exe"
Name: "{autodesktop}\MHD Films"; Filename: "{app}\mhd_films.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\mhd_films.exe"; Description: "{cm:LaunchProgram,MHD Films}"; Flags: nowait postinstall skipifsilent

