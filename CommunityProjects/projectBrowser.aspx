<%@ Import namespace="System.Xml" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC"  %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"  lang="en" >
<head>
<title>projectOverview</title>
<meta name="Description" content="Aras is the leader in delivering Microsoft Enterprise Open Source Solutions to address strategic business initiatives such as PLM new product introduction and APQP quality compliance." />
<link rel="stylesheet" type="text/css" href="http://www.aras.com/styles/aras.css" />

<%	Dim cat as String=Request.QueryString("cat")
	Dim search as String = Request.QueryString("search")
%>

<script language="JavaScript" type="text/JavaScript">
function openProject(id)  {
		var target = top.document.getElementById("maincontent");

		target.src="project.aspx?pid=" + id;
}
</script>
</head>
	<body height="100%">
		<span style="font-family:tahoma, arial, helvetica, sans-serif; font-size:16px; font-weight: bold;  ">
			<%
			if Cat <> "" then
			%>
				<%=cat%>
			<%
			else
			%>
			Search Results For '<u><%=search%>'</u>
			<%
			End if
			%>
		</span>
		<br/>
		<div>
		<table border="1" bordercolor="#a0a000" width="95%" cellpadding="2" cellspacing="0" style="font-size:9pt; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none; ">
			<tr bgcolor="honeydew" style="font-size:11pt; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none">
				<th width="18%" style="height: 19px">Downloads</th>
				<th width="25%" style="height: 19px">Name</th>
				<th width="57%" style="height: 19px">Description</th>
			</tr>
			<%
			if (cat<> "") then
			    LoadProjectList(cat)
			else
				LoadProjectListSearch(search)
			end if
			Dim myXML as System.Xml.XmlDocument
			myXML = New XmlDocument()
			myXML.preserveWhiteSpace = trUE
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
			        id = Node.GetAttribute("id")
			        If id = "347251944FBE46769DE987CE996E2895" Then
			            id = "DD32FF42D8B14CB28CD4732AAF2F5349"
			        End If
			        propNode = Node.SelectSingleNode("name")
			        If Not propNode Is Nothing Then name = propNode.InnerText
			        propNode = Node.SelectSingleNode("rating")
			        If Not propNode Is Nothing Then rating = propNode.InnerText
			        propNode = Node.SelectSingleNode("description")
			        If Not propNode Is Nothing Then description = Left(propNode.InnerText, 280) & " ..."
			        propNode = Node.SelectSingleNode("downloads")
			        If Not propNode Is Nothing Then downloads = propNode.InnerText

			%>
			<tr valign="middle">
				<td align="center" style="font-size:11px; font-weight: bold"><%=Downloads%>
					<!-- <br/><img border="0" src="http://www.aras.com/communityProjects/icons/review-<%=Rating%>-5-stars.gif" alt="Aras PLM Stars">  -->&nbsp;
				</td>
				<td align='left'><a href="JavaScript:openProject('<%=id%>');"><%=name%></a></td>
				<td align='left'><%=description%></td>
			</r>
			<%
			next
			%>
		</table>
		</div>
	</body>
</html>
