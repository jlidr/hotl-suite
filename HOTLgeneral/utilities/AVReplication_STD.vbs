
If Msgbox("This will replicate your content to the other systems, potentially replacing data on the remote system(s).  Are you sure you want to do this?",vbYesNo) = vbYes then

  On error resume next
  Dim oshell, ofs, objnetwork,targets

  Set Oshell = createobject("wscript.shell")
  Set Ofs = CreateObject("Scripting.FileSystemObject")
  Set objNetwork = createobject("Wscript.Network")
  DMdir = oShell.RegRead("HKLM\SOFTWARE\WSI\Digital Media\1.0\InstallDir") & "Standard"
  sFullComputerName = split(lcase(objNetwork.ComputerName),".")
  sComputername = sFullComputername(0)

  ' Targets = array("AVFCST-DESK1","AVFCST-DESK2","AVFCST-DESK3","AVFCST-DESK4","AND-HOTL-FCST3","AND-HOTL-FCST1")
  ' Targets = array("AVFCST-DESK1","AVFCST-DESK2","AVFCST-DESK3","AVFCST-DESK4","AVFCST-HOTL1","AVFCST-HOTL2","AVFCST-HOTL3","AND-HOTL-FCST1","AND-HOTL-FCST3")
    Targets = array("ENRGYFCST-HOTL4")


  For each Target in Targets

    If lcase(target) = sComputername then
      wscript.echo "Skipping " & target
    else
      if ofs.folderexists ("\\" & target & "\DigitalMedia\Standard") then
        wscript.echo "Copying files to " & target
        'oshell.run("robocopy " & DMdir & " \\" & target & "\DigitalMedia\Custom /e /r:0 /w:0 /mt:16"),,true
        oshell.run("robocopy " & DMdir & " \\" & target & "\DigitalMedia\Standard /e /r:0 /w:0 /mt:16"),,true
      else
        wscript.echo "Cannot access " & "\\" & target & "\DigitalMedia\Standard"
      End if
    End if

    wscript.sleep 2000
    wscript.echo ""

  Next

  wscript.echo "Complete"
  wscript.sleep 10000

End if


