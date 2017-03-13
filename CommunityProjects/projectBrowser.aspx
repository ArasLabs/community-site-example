<%@ Import namespace="System.Xml" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>projectOverview</title>
		<%	Dim cat as String=Request.QueryString("cat")
		    Dim search as String = Request.QueryString("search")
		%>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script>
	function openProject(id)  {
	
		   top.document.all.maincontent.src="project.aspx?pid=" + id;
	}
		</script>
	</HEAD>
	<body>
		<font style="FONT-SIZE:16pt"><b>
				<%
				if Cat <> "" then
				%>
				   <%=cat%>
				<%
				else 
				%>
				Searching for '<b><%=search%>'</b>
				<%
				End if
				%>
				
			</b></font>
		<table border="1" bordercolor="#a0a000" width="100%" cellpadding="0" cellspacing="0" style='FONT-SIZE:9pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none'>
			<tr bgcolor="honeydew" style="FONT-SIZE:11pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none">
				<th width="18%" style="HEIGHT: 19px">
					Downloads</th><th width="25%" style="HEIGHT: 19px">Name</th><th width="57%" style="HEIGHT: 19px">Description</th>
			</tr>
			<%
			if (cat<> "") then 
			    LoadProjectList(cat)
			else
				LoadProjectListSearch(search)
			end if
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
				if not propNode is Nothing Then description = left(propNode.innertext,280) & " ..."
				propNode = Node.selectSingleNode("downloads") 
				if not propNode is Nothing Then downloads = propNode.innertext 

			%>
			<TR valign="middle">
				<TD align='center'><font style="FONT-SIZE:11pt"><b><%=Downloads%></b></font>
				<!-- <Br><img border="0" src="icons/review-<%=Rating%>-5-stars.gif">  -->
				</TD>
				<TD align='left'><a href="JavaScript:openProject('<%=id%>');"><%=name%></a></TD>
				<TD align='left'><%=description%></TD>
			</TR>
			<%
			next
			%>
		</table>
	</body>
</HTML>
