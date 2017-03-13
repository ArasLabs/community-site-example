<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<%@ Import namespace="System.Xml" %>
<%	Dim pid as String=Request.QueryString("pid")
    dim fid as String=Request.QueryString("fid")
    GETFILE(pid,fid)
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <title>FileDownload</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
  </head>
  <body onLoad="JavaScript:window.location.href='<%=fileURL%>'">
  </body>
</html>
