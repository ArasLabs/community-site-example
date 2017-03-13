<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<%@ Import namespace="System.Xml" %>
<%		    Dim cat as String=Request.QueryString("cat")%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>projectOverview</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	<script>
	function openProject(id)  {
	
		   top.document.all.main.src="project.aspx?pid=" + id;
	}
	</script>
	</HEAD>
	<body>
	<font style="FONT-SIZE:16pt;"><b><%=cat%></b></font>
		<table border="1" bordercolor="SlateGrayLight" width="100%" cellpadding="0" cellspacing="0" style='FONT-SIZE:9pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none'>
			<tr bgcolor="Honeydew" style="FONT-SIZE:11pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none">
				<th width="15%">Rating</th><th width="25%">Name</th><th width="60%">Description</th>
			</tr>
			<%
		    LoadProjectList(cat)
			Dim myXML as System.Xml.XmlDocument
			myXML = New XmlDocument()
			myXML.preserveWhiteSpace = TRUE
			myXML.loadXML(Projects)
			Dim Nodes As System.Xml.XmlNodeList = myXML.selectNodes("//Item[@type='CP_CommunityProject']")
			Dim Node As System.Xml.XmlElement
			Dim name as String = "?"
			Dim rating as String  = "0.0"
			Dim description as String  = "na"
			Dim downloads as String  = "0"
			dim id as String = ""
			Dim propNode As System.Xml.XmlElement
			
			For Each Node in Nodes
			    id = node.getAttribute("id")
				propNode = Node.selectSingleNode("name")
				if not propNode is Nothing Then name = propNode.innertext
				propNode = Node.selectSingleNode("rating")
				if not propNode is Nothing Then rating = propNode.innertext
				propNode = Node.selectSingleNode("description") 
				if not propNode is Nothing Then description = propNode.innertext 
				propNode = Node.selectSingleNode("downloads") 
				if not propNode is Nothing Then downloads = propNode.innertext 

			%>
			<TR valign="middle">
				<TD align='center'><font style="FONT-SIZE:11pt;"><b><%=Rating%></b></font><Br><img border="0" src="icons/review-<%=Rating%>-5-stars.gif"></TD>
				<TD align='left'><a href="JavaScript:openProject('<%=id%>');"><%=name%></a></TD>
				<TD align='left'><%=description%></TD>
			</TR>
			<%
			next
			%>
		</table>
	</body>
</HTML>
