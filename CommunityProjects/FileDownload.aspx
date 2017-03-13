<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC"  %>
<%@ Import namespace="System.IO" %>
<%	Dim pid as String=Request.QueryString("pid")
    dim fid as String=Request.QueryString("fid")
    dim name as String=Request.QueryString("name")
    GETFILE(pid,fid)

    ' log the download against the cookie
    Dim PageTitle="Community Projects - Downloaded - " & name
	' next section support cookie tracking of the end user
		Dim uniqueID As String = "unknown"
		Dim Cookie As HttpCookie
		If Request.Cookies("arascorp") Is Nothing Then
			dim cookieID=Guid.NewGuid().ToString("N").ToUpper()  'assign this visitor a unique ID
			Cookie = New HttpCookie("arascorp")
			Cookie.Expires = DateTime.MaxValue	' the cookie never expires
			Cookie.Path ="/" 	‘ the cookie applies to the whole aras site
			Cookie.Values.Add("arasid",cookieID)
			Response.AppendCookie(Cookie)
			uniqueID=cookieID  '  set the value for the hidden form field
		Else
			Cookie = Request.Cookies("arascorp")
			If Not Cookie Is Nothing Then
				uniqueID=Cookie.Values("arasid")
			Else
				uniqueID="error"
			End If
		End If

		' now add the visitor information to the Visitor log
		Dim ClientIP as String = Request.UserHostAddress
		Try
			Dim fs As FileStream = new FileStream("c:\inetpub\Logs\Visitor.Log", FileMode.OpenOrCreate, FileAccess.Write)
			Dim w As StreamWriter = new StreamWriter(fs)  '  create a Char writer
			w.BaseStream.Seek(0, SeekOrigin.End)   '  set the file pointer to the end
			w.Write( uniqueID & "," & PageTitle & "," & now & "," & ClientIP & chr(13))
			w.Flush()  '  update underlying file
			w.Close()  '  close the writer and underlying file
		Catch exc as exception

		Finally

		End Try
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"  lang="en" >
  <head>
    <title>FileDownload</title>
  </head>
  <body onLoad="JavaScript:window.location.href='<%=fileURL%>'">
  </body>
</html>
