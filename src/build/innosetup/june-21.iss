; Based on ToneZ installer script, Copyright T0NIT0 RMX 2019.
; Based on Cabbage Installer Script, Copyright Rory Walsh 2017.
; Based on the Csound 6.09 Installer script by Mike Goggins. 

#define MyAppName "June-21"
#define MyAppVersion "0.9"
#define MyAppPublisher "MikeRodd"
#define MyAppURL "https://github.com/mikerodd/june-21"
#define BuildDir "/x64"

;CHANGE THIS !!!
#define MyPluginName "June-21"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{4E5C42B2-198C-4745-B869-3DCEFE7AC54E}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf64}\pluginfolder
DisableProgramGroupPage=yes
LicenseFile= "Utils/LICENSE"
OutputBaseFilename=June-21_x64_{#MyAppVersion}_Setup
SetupIconFile=Utils/june-21.ico
Compression=lzma
SolidCompression=yes
WizardSmallImageFile=Utils/June-21-banner.bmp
WizardImageFile=Utils/june-21-end.bmp
DisableDirPage=no
DisableReadyPage=yes
ChangesEnvironment=yes
UninstallFilesDir=C:\ProgramData\{#MyAppPublisher}\{#MyPluginName}\data
DirExistsWarning=no
AppendDefaultDirName=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Messages]
french.SelectDirLabel3=L'assistant va installer le plugin [name] dans le dossier suivant. Pour continuer, cliquez sur Suivant. Si vous souhaitez choisir un dossier différent, cliquez sur Parcourir.
french.SelectDirBrowseLabel=Plugin 64-bit
english.SelectDirLabel3=Setup will install [name] plugin into the following folder. To continue, click Next. If you would like to select a different folder, click Browse.
english.SelectDirBrowseLabel=64-bit plugin

[Files]
Source: "{#BuildDir}\{#MyPluginName}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs; Permissions: users-full;
Source: "{#BuildDir}/{#MyPluginName}\{#MyPluginName}.dll"; DestDir: "{app}"; Flags: ignoreversion; Permissions: users-full;
Source: "{#BuildDir}/{#MyPluginName}\libjsl.dll"; DestDir: "{app}"; Flags: ignoreversion; Permissions: users-full;
Source: "{#BuildDir}/{#MyPluginName}\{#MyPluginName}.exe"; DestDir: "{app}"; Flags: ignoreversion; Permissions: users-full;
Source: "{#BuildDir}/csound64.dll"; DestDir: "C:\Program Files\Csound6_x64\bin"; Flags: ignoreversion; Permissions: users-full;



[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};C:\Program Files\Csound6_x64\bin"; Check: NeedsAddPath('C:\Program Files\Csound6_x64\bin')
 

[Code]


function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,
    'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  { look for the path with leading and trailing semicolon }
  { Pos() returns 0 if not found }
  Result := Pos(';' + Param + ';', ';' + OrigPath + ';') = 0;
end;

//	ModPathName defines the name of the task defined above
//	ModPathType defines whether the 'user' or 'system' path will be modified;
//		this will default to user if anything other than system is set
//	setArrayLength must specify the total number of dirs to be added
//	Result[0] contains first directory, Result[1] contains second, etc.
const ModPathName = 'modifypath';
ModPathType = 'system';

function ModPathDir(): TArrayOfString;
begin
	setArrayLength(Result, 1);
	Result[0] := ExpandConstant('{app}');
end;

procedure ModPath();
var
	oldpath:	String;
	newpath:	String;
	updatepath:	Boolean;
	pathArr:	TArrayOfString;
	aExecFile:	String;
	aExecArr:	TArrayOfString;
	i, d:		Integer;
	pathdir:	TArrayOfString;
	regroot:	Integer;
	regpath:	String;
begin
	// Get constants from main script and adjust behavior accordingly
	// ModPathType MUST be 'system' or 'user'; force 'user' if invalid
	if ModPathType = 'system' then begin
		regroot := HKEY_LOCAL_MACHINE;
		regpath := 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';
	end else begin
		regroot := HKEY_CURRENT_USER;
		regpath := 'Environment';
	end;

	// Get array of new directories and act on each individually
	pathdir := ModPathDir();
	for d := 0 to GetArrayLength(pathdir)-1 do begin
		updatepath := true;

		// Modify WinNT path
		if UsingWinNT() = true then begin

			// Get current path, split into an array
			RegQueryStringValue(regroot, regpath, 'Path', oldpath);
			oldpath := oldpath + ';';
			i := 0;

			while (Pos(';', oldpath) > 0) do begin
				SetArrayLength(pathArr, i+1);
				pathArr[i] := Copy(oldpath, 0, Pos(';', oldpath)-1);
				oldpath := Copy(oldpath, Pos(';', oldpath)+1, Length(oldpath));
				i := i + 1;

				// Check if current directory matches app dir
				if pathdir[d] = pathArr[i-1] then begin
					// if uninstalling, remove dir from path
					if IsUninstaller() = true then begin
						continue;
					// if installing, flag that dir already exists in path
					end else begin
						updatepath := false;
					end;
				end;

				// Add current directory to new path
				if i = 1 then begin
					newpath := pathArr[i-1];
				end else begin
					newpath := newpath + ';' + pathArr[i-1];
				end;
			end;

			// Append app dir to path if not already included
			if (IsUninstaller() = false) AND (updatepath = true) then
				newpath := newpath + ';' + pathdir[d];

			// Write new path
			RegWriteStringValue(regroot, regpath, 'Path', newpath);

		// Modify Win9x path
		end else begin

			// Convert to shortened dirname
			pathdir[d] := GetShortName(pathdir[d]);

			// If autoexec.bat exists, check if app dir already exists in path
			aExecFile := 'C:\AUTOEXEC.BAT';
			if FileExists(aExecFile) then begin
				LoadStringsFromFile(aExecFile, aExecArr);
				for i := 0 to GetArrayLength(aExecArr)-1 do begin
					if IsUninstaller() = false then begin
						// If app dir already exists while installing, skip add
						if (Pos(pathdir[d], aExecArr[i]) > 0) then
							updatepath := false;
							break;
					end else begin
						// If app dir exists and = what we originally set, then delete at uninstall
						if aExecArr[i] = 'SET PATH=%PATH%;' + pathdir[d] then
							aExecArr[i] := '';
					end;
				end;
			end;

			// If app dir not found, or autoexec.bat didn't exist, then (create and) append to current path
			if (IsUninstaller() = false) AND (updatepath = true) then begin
				SaveStringToFile(aExecFile, #13#10 + 'SET PATH=%PATH%;' + pathdir[d], True);

			// If uninstalling, write the full autoexec out
			end else begin
				SaveStringsToFile(aExecFile, aExecArr, False);
			end;
		end;
	end;
end;

// Split a string into an array using passed delimeter
procedure MPExplode(var Dest: TArrayOfString; Text: String; Separator: String);
var
	i: Integer;
begin
	i := 0;
	repeat
		SetArrayLength(Dest, i+1);
		if Pos(Separator,Text) > 0 then	begin
			Dest[i] := Copy(Text, 1, Pos(Separator, Text)-1);
			Text := Copy(Text, Pos(Separator,Text) + Length(Separator), Length(Text));
			i := i + 1;
		end else begin
			 Dest[i] := Text;
			 Text := '';
		end;
	until Length(Text)=0;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
	taskname:	String;
begin
	taskname := ModPathName;
	if CurStep = ssPostInstall then
		if IsTaskSelected(taskname) then
			ModPath();
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
	aSelectedTasks:	TArrayOfString;
	i:				Integer;
	taskname:		String;
	regpath:		String;
	regstring:		String;
	appid:			String;
begin
	// only run during actual uninstall
	if CurUninstallStep = usUninstall then begin
		// get list of selected tasks saved in registry at install time
		appid := '{#emit SetupSetting("AppId")}';
		if appid = '' then appid := '{#emit SetupSetting("AppName")}';
		regpath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\'+appid+'_is1');
		RegQueryStringValue(HKLM, regpath, 'Inno Setup: Selected Tasks', regstring);
		if regstring = '' then RegQueryStringValue(HKCU, regpath, 'Inno Setup: Selected Tasks', regstring);

		// check each task; if matches modpath taskname, trigger patch removal
		if regstring <> '' then begin
			taskname := ModPathName;
			MPExplode(aSelectedTasks, regstring, ',');
			if GetArrayLength(aSelectedTasks) > 0 then begin
				for i := 0 to GetArrayLength(aSelectedTasks)-1 do begin
					if comparetext(aSelectedTasks[i], taskname) = 0 then
						ModPath();
				end;
			end;
		end;
	end;
end;

function NeedRestart(): Boolean;
var
	taskname:	String;
begin
	taskname := ModPathName;
	if IsTaskSelected(taskname) and not UsingWinNT() then begin
		Result := True;
	end else begin
		Result := False;
	end;
end;





// link in installer footer
procedure URLLabelOnClick(Sender: TObject);
var
	ErrorCode: Integer;
begin
	ShellExecAsOriginalUser('open', '{#MyAppURL}', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure InitializeWizard;
var
	URLLabel: TNewStaticText;
begin
	URLLabel := TNewStaticText.Create(WizardForm);
	URLLabel.Caption := ExpandConstant('https://github.com/mikerodd/june-21/');
	URLLabel.Cursor := crHand;
	URLLabel.OnClick := @URLLabelOnClick;
	URLLabel.Parent := WizardForm;
	URLLabel.Font.Style := URLLabel.Font.Style + [fsUnderline];
	URLLabel.Font.Color := clBlue;
	URLLabel.Top := WizardForm.ClientHeight - URLLabel.Height - 15;
	URLLabel.Left := ScaleX(20);
end;



procedure CurPageChanged(CurPageID: Integer);
begin
  // On fresh install the last pre-install page is "Select Program Group".
  // On upgrade the last pre-install page is "Read to Install"
  // (forced even with DisableReadyPage)
  if (CurPageID = wpSelectDir) or (CurPageID = wpReady) then
    WizardForm.NextButton.Caption := SetupMessage(msgButtonInstall)
  // On the Finished page, use "Finish" caption.
  else if (CurPageID = wpFinished) then
    WizardForm.NextButton.Caption := SetupMessage(msgButtonFinish)
  // On all other pages, use "Next" caption.
  else
    WizardForm.NextButton.Caption := SetupMessage(msgButtonNext);
end;



