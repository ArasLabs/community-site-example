<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<%@ Import namespace="System.Xml" %>
<%		    Dim id as String=Request.QueryString("pid")%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>projectOverview</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script>
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
	</HEAD>
	<body>
	    <font style='FONT-SIZE:11pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none'>
	    <a href="JavaScript:addForumEntry();" ><img src="icons/20x20new.gif" border="0">&nbsp;&nbsp;Start New Thread</a>
	    </font>
		<table border="1" bordercolor="SlateGrayLight" width="100%" cellpadding="0" cellspacing="0"
			style='FONT-SIZE:10pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none' >
			<tr bgcolor="Honeydew">
				<th width="50%" align="left">Topic</th><th width="25%" align="left">Topic Starter</th><th width="5%">Replies</th><th width="20%">Last Post</th></tr>
			<%
		    LoadForums(id)
			Dim myXML as System.Xml.XmlDocument
			myXML = New XmlDocument()
			myXML.preserveWhiteSpace = TRUE
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
				End If	

			%>
			<TR valign="middle">
				<TD align='left'><a href="JavaScript:openForum('<%=fid%>');"><img src="icons/16x16_openItem.gif" border="0"/>&nbsp;&nbsp;<%=topic%></a></td>
				<TD align='left'><%=author%></TD>
				<TD align='center'><%=replies%></TD>
				<TD align='center'><%=last_post%></TD>
			</TR>
			<%
			next
			%>
		</table>
	</body>
</HTML>
