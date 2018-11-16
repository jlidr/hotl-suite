On error resume next
Dim oShell,objFSO,sFile
Dim MyTVC,sComputer,HOTLver,MAXver,WINDSid,SerialNum,Hardware,OS,Skybase

Set oshell = Createobject("wscript.shell")

'   Collect all the desired values from the registry
MYTVC = oShell.RegRead("HKLM\SOFTWARE\WSI\TruVu Workgroup\MyTVC")
Skybase = oShell.RegRead("HKLM\SOFTWARE\WSI\TruVu Workgroup\MySKYBASE")
sComputer = oShell.ExpandEnvironmentStrings("%COMPUTERNAME%")
HOTLver = oShell.RegRead("HKLM\Software\WSI\HOTL Client\version")
MAXver = oShell.RegRead("HKLM\Software\WSI\TruVu Max\1.0\version")
WINDSid = oShell.RegRead("HKLM\Software\WSI\TruVu Workgroup\MyWindsID")
SerialNum = oShell.RegRead("HKLM\Software\Wow6432Node\Hewlett-Packard\HPActiveSupport\Devices\SerialNumber")
Hardware = oShell.RegRead("HKLM\Software\Wow6432Node\Hewlett-Packard\HPActiveSupport\Devices\ProductName")
OS = oShell.RegRead("HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\ProductName")

set objFSO = CreateObject("Scripting.FileSystemObject")

'   Make the output file also contain the computer name
outFile="c:\versions_" & sComputer & ".txt"

objfso.CreateTextFile outFile,true
Set sFile = objfso.OpenTextFile(outFile,2)

'   Write out the collected information
sFile.writeline "System Name: " & sComputer
sFile.writeline "MyTVC: " & MyTVC
sFile.writeline "MySKYBASE: " & MySKYBASE
sFile.writeline "HOTL version: " & HOTLver
sFile.writeline "Max version: " & MAXver
sFile.writeline "WINDS ID: " & WINDSid
sFile.writeline "Serial Number: " & SerialNum
sFile.writeline "Hardware: " & Hardware
sFile.writeline "OS: " & OS

'   Close out the file
sFile.close
