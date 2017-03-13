<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC"  %>
<%@ Import namespace="System.Xml" %>
<%  Dim id as String=Request.QueryString("pid")%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"  lang="en" >
<head>

<title>Aras Community Project Overview</title>
<meta name="Description" content="Aras is the leader in delivering Microsoft Enterprise Open Source Solutions to address strategic business initiatives such as PLM new product introduction and APQP quality compliance." />
<link rel="stylesheet" type="text/css" href="http://www.aras.com/styles/aras.css" />

<script language="JavaScript" type="text/JavaScript">
		function addForumEntry() {
		    if (top.login=="") {
			    var res= showModalDialog('login.htm',null,'dialogHeight:150px; dialogWidth:350px; status:0; help:0; resizable:0');
				if (!res) {
					top.login = "";
					top.usertype = "";
				} else {
					top.login=res.id;
					top.usertype=res.status;
				}
			}
			if (top.login=="") return;

		    // open a model dialog to ask for the Forum Entry.  The dialog may post back to an ASPX the message body
            var repaint = showModalDialog('addForumEntry.aspx?pid=<%=id%>&author='+top.login,null,'dialogHeight:300px; dialogWidth:540px; status:0; help:0; resizable:1');
            if (repaint) document.location="projectForums.aspx?pid=<%=id%>";
		}
		function openForum(id) {
			document.location ="viewForumEntry.aspx?fid="+id+"&pid=<%=id%>";
		}
</script>
</head>

<body>
	 <span style='font-size:11pt; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none'>
		<a href="JavaScript:addForumEntry();" ><img src="http://www.aras.com/communityProjects/icons/20x20new.gif" border="0" alt="Aras PLM">&nbsp;&nbsp;Start New Thread</a>
	 </span>
		<table border="1" bordercolor="SlateGrayLight" width="100%" cellpadding="0" cellspacing="0"
			style='font-size:10pt; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none' >
			<tr bgcolor="Honeydew">
				<th width="50%" align="left">Topic</th><th width="25%" align="left">Topic Starter</th><th width="5%">Replies</th><th width="20%">Last Post</th></tr>
			<%
		   LoadForums(id)
			Dim myXML as System.Xml.XmlDocument
			myXML = New XmlDocument()
			myXML.preserveWhiteSpace = trUE
			myXML.loadXML(Forums)
			Dim Nodes As System.Xml.XmlNodeList = myXML.selectNodes("//Item[@type='CP_Forum']")
			Dim Node As System.Xml.XmlElement
			For Each Node in Nodes
				Dim fid as String = Node.getAttribute("id")
				Dim topic as String = "?"
				Dim author as String  = "?"
				Dim dated as String  = ""
				Dim last_post as String  = ""
				Dim replies as String  = "0"

				Dim propNode As System.Xml.XmlElement = Node.selectSingleNode("author/Item/keyed_name")
				if not propNode is Nothing Then
					author = propNode.innertext
				End If
				propNode = Node.selectSingleNode("topic")
				if not propNode is Nothing Then
					topic = propNode.innertext
				End If
				propNode = Node.selectSingleNode("replies")
				if not propNode is Nothing Then
					replies = propNode.innertext
				End If
				propNode = Node.selectSingleNode("modified_on")
				if not propNode is Nothing Then
					last_post = propNode.innertext
					'  need to translate the DATE here  '
				End If

			%>
			<tr valign="middle">
				<td align='left'><a href="JavaScript:openForum('<%=fid%>');"><img src="http://www.aras.com/communityProjects/icons/16x16_openItem.gif" border="0"/>&nbsp;&nbsp;<%=topic%></a></td>
				<td align='left'><%=author%></td>
				<td align='center'><%=replies%></td>
				<td align='center'><%=last_post%></td>
			</tr>
			<%
			next
			%>
		</table>
	</body>
</html>
