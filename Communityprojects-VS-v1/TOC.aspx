<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC"%>
<%@ Import namespace="System.Xml" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
		<title>TOC</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
<link rel="stylesheet" type href="http://www.aras.com/images/tempLayoutFiles/temp_formatting.css" media="screen" css?? text>
<link rel="stylesheet" type href="http://www.aras.com/images/tempLayoutFiles/temp_typefaces.css" media="screen" css?? text>
<link rel="stylesheet" type href="http://www.aras.com/images/tempLayoutFiles/temp_navTop.css" media="screen" css?? text>
<link rel="stylesheet" type href="http://www.aras.com/images/tempLayoutFiles/temp_navSide.css" media="screen" css?? text>
<link rel="stylesheet" type href="http://www.aras.com/images/tempLayoutFiles/temp_screen.css" media="screen" css?? text>
<link rel="stylesheet" type href="http://www.aras.com/images/tempLayoutFiles/temp_print.css" media="print" css?? text>
<link rel="Shortcut Icon" href="http://www.aras.com/aras.ico" type="image/x-icon" >
<link rel="stylesheet" type="text/css" href="http://www.aras.com/images/tempLayoutFiles/temp_layout.css" title="layout" media="screen" >
<link rel="stylesheet" type="text/css" href="http://www.aras.com/images/tempLayoutFiles/temp_landingPage.css" title="layout" media="screen" >
		
		<script>
		function onMain() {
		   top.document.all.main.src="projectMain.aspx";
		}
		
		function onCategory(which,id){
		   top.document.all.main.src="projectBrowser.aspx?cat="+which;
		}
		   
		function onProject(which,id){
		   top.document.all.main.src="project.aspx?pid=" + id;
		}
		
		
		</script>
</HEAD>
	<body >
		<table border="0" width="100%" style='FONT-SIZE:8pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none'>
		<tr height="10"><td align="left" colspan="2" onclick="onMain();"><b><font style="FONT-SIZE:11pt">Aras Projects</font></b><br><hr width="100%"></td></tr>
		<tr height="10"><td align="left" colspan="2"><b>Browse By Category</b></td></tr>
		<%
		    loadTOC()
			Dim CatsXML as System.Xml.XmlDocument
			CatsXML = New XmlDocument()
			CatsXML.preserveWhiteSpace = TRUE
			CatsXML.loadXML(Categories)
			Dim Nodes As System.Xml.XmlNodeList = CatsXML.selectNodes("//Item[@type='Value']")
			Dim Node As System.Xml.XmlElement
			For Each Node in Nodes
				Dim CatName as String = " "
				Dim CatId as String = Node.getAttribute("id")
				' Load the properties
				Dim propNode As System.Xml.XmlElement = Node.selectSingleNode("value")
				if not propNode is Nothing Then
					CatName = propNode.innertext
				End If	
			%>
			<TR height="10">
				<TD align='center' width='5'>&nbsp;</TD>
				<TD align='left' onclick="onCategory('<%=CatName%>','<%=catId%>');"> <%=CatName%></TD>
			</TR>
			<%
			next
			%>


		<tr height="10"><td align="left" colspan="2"><b>Browse By Project</b></td></tr>
			<%
			CatsXML.loadXML(Projects)
			Nodes  = CatsXML.selectNodes("//Item[@type='CP_CommunityProject']")
			For Each Node in Nodes
				Dim CatName as String = " "
				Dim CatId as String = Node.getAttribute("id")
				' Load the properties
				Dim propNode As System.Xml.XmlElement = Node.selectSingleNode("name")
				if not propNode is Nothing Then
					CatName = propNode.innertext
				End If	
			%>
			<TR height="10">
				<TD align='left' width='5'> &nbsp;</TD>
				<TD align='left' onclick="onProject('<%=CatName%>','<%=catId%>');"> <%=CatName%></TD>
			</TR>
			<%
			next
			%>
		</table>

	</body>
</HTML>
