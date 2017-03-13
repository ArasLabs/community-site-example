<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<%@ Import namespace="System.Xml" %>
<%
	Dim id as String=Request.QueryString("pid")
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <title>project</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
	<link rel="stylesheet" type"text/css" href="http://www.aras.com/topNav.css" media="screen">
	<link rel="stylesheet" type"text/css" href="http://www.aras.com/formatting.css" media="screen">
	<link rel="stylesheet" type"text/css" href="http://www.aras.com/typefaces.css" media="screen">
	<link rel="stylesheet" type"text/css" href="http://www.aras.com/navTop.css" media="screen">
	<link rel="stylesheet" type"text/css" href="http://www.aras.com/navSide.css" media="screen">
	<link rel="stylesheet" type"text/css" href="http://www.aras.com/screen.css" media="screen">
	<link rel="stylesheet" type"text/css" href="http://www.aras.com/print.css" media="print">
	<link rel="Shortcut Icon" href="http://www.aras.com/aras.ico" type="image/x-icon" />
	<link rel="stylesheet" type="text/css" href="http://www.aras.com/layout.css" title="layout" media="screen" />
	<link rel="stylesheet" type="text/css" href="http://www.aras.com/landingPage.css" title="layout" media="screen" />
	<link rel="stylesheet" type="text/css" href="jsTab.css">
  
	<script src="jsTab.js"></script>
	<script language="JavaScript" src="jsToolbar.js"></script>

	<script>
	var tabbar=null;
	var currTabID="";
	function loadTabbar()  {
		if(tabbar!=null) return;
		if(!document.getElementById("tabbar_slot")) return;
		tabbar = new jsTabBar();

		tabbar.doOnTabChange = function(tabID){
			if (!tabID) return;
			if (currTabID == tabID.id) return;
			currTabID = tabID.id;
			var id="";
			if (currTabID == "overview")	{
				document.all.content_frame.src="projectOverview.aspx?pid=<%=id%>";
			}
			if (currTabID == "downloads")	{
				document.all.content_frame.src="projectFiles.aspx?pid=<%=id%>";
			}
			if (currTabID == "reviews")	{
				document.all.content_frame.src="projectReviews.aspx?pid=<%=id%>";
			}
			if (currTabID == "forums")	{
				document.all.content_frame.src="projectForums.aspx?pid=<%=id%>";
			}
		}
		tabbar.addTab(new jsTab("overview","Overview","150"));
		tabbar.addTab(new jsTab("downloads" ,"Downloads","150"));
		tabbar.addTab(new jsTab("reviews","Reviews","150"));	
		tabbar.addTab(new jsTab("forums","Forums","150"));
		tabbar.appendTo(document.getElementById("tabbar_slot"))
		tabbar.setTabActive(tabbar.getTabByIndex(0));
	}
  </script>
  </head>
  <body onLoad="loadTabbar();">
		<%
		    LoadProjectBrief(id)
			Dim myXML as System.Xml.XmlDocument
			myXML = New XmlDocument()
			myXML.preserveWhiteSpace = TRUE
			myXML.loadXML(Projects)
			Dim Node As System.Xml.XmlElement = myXML.selectSingleNode("//Item[@id='" & id & "']")
			if not Node is Nothing then
				dim name as String=" "
				dim description as String = " "
				dim download as String = "0"
				dim rating as String = "0"
				Dim propNode As System.Xml.XmlElement = Node.selectSingleNode("name")
				if not propNode is Nothing Then
					name = propNode.innertext
				End If	
				propNode = Node.selectSingleNode("description")
				if not propNode is Nothing Then
					description = propNode.innertext
				End If	
				propNode = Node.selectSingleNode("download")
				if not propNode is Nothing Then
					download = propNode.innertext
				End If	
				propNode = Node.selectSingleNode("rating")
				if not propNode is Nothing Then
					rating = propNode.innertext
				End If	
		%>
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr height="30px"><td align="left"><font style='font-size:14pt; font-family: tahoma, arial, helvetica, sans-serif;text-decoration: none'><%=name%></font></td></tr>
				<tr height="31px"><td align="left" ><div id="tabbar_slot" ></div></td></tr>
				<tr height="100%"><td><iframe id="content_frame" name="content_frame" width="100%" height="400" frameborder="0" src="ProjectOverview.aspx"></iframe></td></tr>
				</table>
				
				
		<%  
			End If	
		%>




  </body>
</html>
