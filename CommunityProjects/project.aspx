<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <title>project</title>
<%
	Dim id as String=Request.QueryString("pid")
	dim name as String=" "
	dim description as String = " "
	dim licenseName as String = "Microsoft CL"
	dim download as String = "0"
	dim rating as String = "0"

	LoadProjectBrief(id)
	Dim myXML as System.Xml.XmlDocument
	myXML = New System.Xml.XmlDocument()
	myXML.preserveWhiteSpace = TRUE
	myXML.loadXML(Projects)
	Dim Node As System.Xml.XmlElement = myXML.selectSingleNode("//Item[@id='" & id & "']")
	if not Node is Nothing then
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
		propNode = Node.selectSingleNode("license")
		if not propNode is Nothing Then
			licenseName = propNode.innertext
		End If	
	End If
%>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
	<link rel="stylesheet" type href="http://www.aras.com/topNav.css" media="screen" css?? text>
	<link rel="stylesheet" type href="http://www.aras.com/formatting.css" media="screen" css?? text>
	<link rel="stylesheet" type href="http://www.aras.com/typefaces.css" media="screen" css?? text>
	<link rel="stylesheet" type href="http://www.aras.com/navTop.css" media="screen" css?? text>
	<link rel="stylesheet" type href="http://www.aras.com/navSide.css" media="screen" css?? text>
	<link rel="stylesheet" type href="http://www.aras.com/screen.css" media="screen" css?? text>
	<link rel="stylesheet" type href="http://www.aras.com/print.css" media="print" css?? text>
	<link rel="Shortcut Icon" href="http://www.aras.com/aras.ico" type="image/x-icon" >
	<link rel="stylesheet" type="text/css" href="http://www.aras.com/layout.css" title="layout" media="screen" >
	<link rel="stylesheet" type="text/css" href="http://www.aras.com/landingPage.css" title="layout" media="screen" >
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
				document.all.content_frame.src="projectFiles.aspx?pid=<%=id%>&name=<%=name%>&license=<%=licenseName%>";
			}
			if (currTabID == "reviews")	{
				document.all.content_frame.src="projectReviews.aspx?pid=<%=id%>";
			}
			if (currTabID == "forums")	{
				document.all.content_frame.src="projectForums.aspx?pid=<%=id%>";
			}
		}
		tabbar.addTab(new jsTab("overview","Overview","145"));
		tabbar.addTab(new jsTab("downloads" ,"Downloads","145"));
		tabbar.addTab(new jsTab("reviews","Reviews","145"));	
		tabbar.addTab(new jsTab("forums","Forums","145"));
		tabbar.appendTo(document.getElementById("tabbar_slot"))
		tabbar.setTabActive(tabbar.getTabByIndex(0));
	}
	
	function mailLink() {
		try {
			var theApp = new ActiveXObject("Outlook.Application")

			var theMailItem = theApp.CreateItem(0) // value 0 = MailItem
			theMailItem.to = "";
			theMailItem.Subject = "Aras Community Projects: <%=name%>";
			theMailItem.HTMLBody = "Here is a link to an interesting Aras Innovator community project<br><br><a href='http://www.aras.com/communityProjects/default.aspx?projectid=<%=id%>'>http://www.aras.com/communityProjects/default.aspx?projectid=<%=id%></a> <br><br>";


			// Now Open Outlook and display the email ready for editing and sending
			theMailItem.display()
		}
		catch (Excep)
		{
		alert('Internal Error: Can not connect to Outlook.  --> '+Excep.description);
		return;
		}
	}
  </script>
</HEAD>
<body onLoad="loadTabbar();" margin="0">

<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<tr height="30"><td align="left"><font style='FONT-SIZE:14pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none'><%=name%></font></td><td align="right"><a href="javascript:mailLink()"><font style='FONT-SIZE:10pt;'><u>EMail this Page</u></font></a></td></tr>
	<tr height="31"><td align="left"  colspan="2"><div id="tabbar_slot" ></div></td></tr>
	<tr height="100%"><td colspan="2"><iframe id="content_frame" name="content_frame" width="100%" height="520" frameborder="0"></iframe></td></tr>
</table>

</body>
</HTML>
