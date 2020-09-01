#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Zuma206

 Script Function:
	Execute batch commands within autoIt scripts.

#ce ----------------------------------------------------------------------------
#include <File.au3>

Func _batch($command)
    RunWait(@ComSpec & " /c " & $command)
    ConsoleWrite("Auto Batch: Executed " & $command)
EndFunc

Func _batchReturn($command)
    RunWait(@ComSpec & " /c " & $command & ">%temp%\return.txt")
    $data2return = FileRead(@TempDir & "\return.txt")
    Return $data2return
EndFunc

Func _batchGroup($command, $groupPath = @TempDir)
    $thing2exe = StringReplace($command, "<><>", @CRLF)
    $thing2exe = StringReplace($thing2exe, "***", "a")
    $thing2exe = StringReplace($thing2exe, "_=_", "e")
    $thing2exe = StringReplace($thing2exe, "-+-+", "i")
    $thing2exe = StringReplace($thing2exe, "[{==--}]", "o")
    FileWrite($groupPath & "\funcfunc.txt", $thing2exe)
    FileMove($groupPath & "\funcfunc.txt", $groupPath & "\funcfunc.bat")
    RunWait($groupPath & "\funcfunc.bat")
    FileDelete($groupPath & "\funcfunc.bat")
EndFunc

Func _generateGroup()
    $_TXTLoc = @ScriptDir & "\batchGroup.txt"
    $fileHandle = FileOpen($_TXTLoc, $FO_OVERWRITE)
    FileClose($fileHandle)
    RunWait("notepad.exe " & $_TXTLoc)
    _ReplaceStringInFile($_TXTLoc, @CRLF, "<><>")
    _ReplaceStringInFile($_TXTLoc, "a", "***")
    _ReplaceStringInFile($_TXTLoc, "e", "_=_")
    _ReplaceStringInFile($_TXTLoc, "i", "-+-+")
    _ReplaceStringInFile($_TXTLoc, "o", "[{==--}]")
    $tingtoreturn = FileRead($_TXTLoc)
    FileDelete($_TXTLoc)
    Return $tingtoreturn
EndFunc
