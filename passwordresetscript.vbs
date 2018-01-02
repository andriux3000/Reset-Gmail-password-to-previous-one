''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Declare Variables & Objects
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Dim oShell
Dim oAutoIt

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Initialise Variables & Objects
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Set oShell = WScript.CreateObject("WScript.Shell")
Set oAutoIt = WScript.CreateObject("AutoItX3.Control")

WScript.Echo "This script will reset your google password 100 times so you can use an old password."



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' You should only edit value after this
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' Your Google username (email address)
'sUN = "email@gmail.com" 

' Replace with the Current password to your google account
curPW = "currentpassword" 

' Replace with the final password you want assigned to the account. The one you want to set the account's password *back to*. 
oldPW = "previouspassword" 

' Is it going to fast? You can slow it down by adjusting this value.
' If you set it to 2, it will run twice as slow
' So if it is entering data into the wrong fields, try increasing this.
' It might help.
iSlowConnectionFactor = 1

' If your password has a quote in it ("), then use "" in its place.
' For example, let's say your password was 
' MyPass"word!-55
'
' The proper VBScript way to put that into a variable would look like this
' curPW = "MyPass""word!-55"
'
' See Microsoft's website for more detail

' Where is the Chrome executable? Replace this with its location.
'     Point app to Chrome Manually
'     An easy way to find this is to right click the Chrome shortcut and copy the value in Target.
'     Click Start, type Chrome, right click Google Chrome, click Properties, copy *everything* in Target, and put it here.

' This example path is for 64 bit windows
ChromeEXE = "chrome.exe"

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' You should not have to edit anything after this
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Start of Script
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


'Some of this code uses the AutoIT com object. See their documentation for more details.

oShell.Run ChromeEXE, 1, False

' Wait for the Google Chrome window to become active
oAutoIt.WinWaitActive "New Tab - Google Chrome", ""
oAutoIt.Sleep 3000

WScript.Echo "Entering Loop"
' Enter the loop, change the password 99 more times
tCurPw = curPW

GLogout

For x = 1 To 60
    WScript.Echo "Step " & x
    WScript.Echo "Current PW: " & tCurPw
    tNewPW = curPW & x
    WScript.Echo "Setting the password to: " & tNewPW
    
    GLogin sUN, tCurPw
    GEditPW
	
    oAutoIt.Send tCurPw & "{TAB}"
    oAutoIt.Sleep 250 * iSlowConnectionFactor 
	oAutoIt.Send "{ENTER}"
    oAutoIt.Sleep 3000 * iSlowConnectionFactor 
    oAutoIt.Send tNewPW & "{TAB}{TAB}{TAB}"
    oAutoIt.Sleep 250 * iSlowConnectionFactor 
	oAutoIt.Send tNewPW & "{ENTER}"
    oAutoIt.Sleep 3000 * iSlowConnectionFactor 
    
    tCurPw = tNewPW

    GLogout
Next 

WScript.Echo "Final Change"
GLogin sUN, tCurPw
GEditPW

oAutoIt.Send tCurPw & "{TAB}"
oAutoIt.Sleep 3000 * iSlowConnectionFactor 
oAutoIt.Send "{ENTER}"
oAutoIt.Sleep 3000 * iSlowConnectionFactor
oAutoIt.Send oldPW & "{TAB}{TAB}{TAB}"
oAutoIt.Sleep 250 * iSlowConnectionFactor 
oAutoIt.Send oldPW & "{ENTER}"
oAutoIt.Send "https://www.google.com/accounts/Logout{ENTER}"
oAutoIt.Sleep 2000 * iSlowConnectionFactor 
WScript.Echo "Password reset"




WScript.Quit

Function GLogin(un, pw) ' Opens the Google Login page, enters the supplied Username (un) and Password (pw), and presses Enter.
    WScript.Echo "Logging in: " & un & ", " & pw
    oAutoIt.Send "!d"
    oAutoIt.Sleep 250 * iSlowConnectionFactor 
    oAutoIt.Send "https://accounts.google.com/Login{ENTER}"
    oAutoIt.Sleep 2000 * iSlowConnectionFactor 
    oAutoIt.Send pw & "{ENTER}"
    oAutoIt.Sleep 3000 * iSlowConnectionFactor 

End Function

Function GEditPW() ' Opens the Google Change Password web page
    oAutoIt.Send "!d"
    oAutoIt.Sleep 250 * iSlowConnectionFactor 
    oAutoIt.Send "https://accounts.google.com/b/0/EditPasswd{ENTER}"
    oAutoIt.Sleep 2000 * iSlowConnectionFactor 
End Function

Function GLogout() ' Logs out from google. This is necessary for the password change to take effect. Trust me, I tried to do it without logging out. No luck.
    WScript.Echo "Logging out"
    oAutoIt.Send "!d"
    oAutoIt.Sleep 250 * iSlowConnectionFactor 
    oAutoIt.Send "https://www.google.com/accounts/Logout{ENTER}"
    oAutoIt.Sleep 3000 * iSlowConnectionFactor 

End Function
