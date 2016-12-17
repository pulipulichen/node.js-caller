#include <File.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>

Local $node_path = IniRead ( @ScriptDir & "\config.ini", "config", "node_path", "D:\Program Files\nodejs\" )
Local $node_modules = $node_path & "node_modules"
Local $node_js = $node_path & "node.exe"
EnvSet ( "NODE_PATH", $node_modules )
Local $set_env = 'set NODE_PATH=' & $node_modules &  @CRLF;

If $CmdLine[0] = 0 Then
   $CmdLine[0] = 1
   _ArrayAdd($CmdLine, "D:\Desktop\[巨量資料與統計分析]\期末報告\node.js\rdf_to_sqlite.js")
EndIf

For $i = 1 To $CmdLine[0]
   Local $file = $CmdLine[$i]
   IF FileExists($file) = False Then
	  ContinueLoop
   EndIf
   ;Local $cmd = $set_env & '"' &$node_js & '" "' & $file & '"' & @CRLF & 'pause'
   Local $cmd = $set_env & '"' &$node_js & '" %1' & @CRLF & 'pause'

   ;$cmd = 'pause'
   ;RunWait(@ComSpec & " /c " & $cmd)

   Local $dir = _PathFull($file & "\..")
   FileChangeDir($dir)
   ;ShellExecuteWait($node_js, $file, $dir)
   Local $temp = _TempFile(@TempDir, "nodejs", ".bat")
   FileWrite($temp, $cmd)
   ;MsgBox($MB_SYSTEMMODAL, "", $cmd)
   RunWait($temp & ' ' & $file)
   FileDelete($temp)

   ;Run(@ComSpec)
   ;WinWait("[CLASS:ConsoleWindowClass]")
   ;WinActivate("[CLASS:ConsoleWindowClass]")
   ;ControlSend("[CLASS:ConsoleWindowClass]", "", "", $cmd)
   ;ControlCommand("[CLASS:ConsoleWindowClass]", "", "", "AddString", $cmd)
   ;ControlSetText("[CLASS:ConsoleWindowClass]", "", "", $cmd)
Next