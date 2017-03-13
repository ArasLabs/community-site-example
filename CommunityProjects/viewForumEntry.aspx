<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC"  %>
<%@ Import namespace="System.Xml" %>
<%
	Dim fid as String=Request.QueryString("fid")
	Dim pid as String=Request.QueryString("pid")
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"  lang="en" >
<head>
 <title>viewForumEntry</title>
<meta name="Description" content="Aras is the leader in delivering Microsoft Enterprise Open Source Solutions to address strategic business initiatives such as PLM new product introduction and APQP quality compliance." />
<link rel="stylesheet" type="text/css" href="http://www.aras.com/styles/aras.css" />

<script language="JavaScript" type="text/JavaScript">
	function addForumReply() {
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
			var repaint = showModalDialog('addForumReply.aspx?fid=<%=fid%>&author='+top.login,null,'dialogHeight:300px; dialogWidth:540px; status:0; help:0; resizable:1');
			if (repaint) document.location="viewForumEntry.aspx?fid=<%=fid%>"
	}

	function backToTopic() {
		  document.location="projectForums.aspx?pid=<%=pid%>";

	}
</script>
</head>
<body >
  	    <span style='font-size:11pt; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none'>
			 <a href="JavaScript:addForumReply();" ><img src="http://www.aras.com/Communityprojects/icons/20x20new.gif" border="0" alt="New Aras PLM Project">&nbsp;&nbsp;Post a Reply</a>&nbsp;&nbsp;&nbsp;
			 <a href="JavaScript:backToTopic();" >BACK to Topic</a>
	    </span>

  <%
  		    LoadForumEntry(fid)
			Dim myXML as System.Xml.XmlDocument
			myXML = New XmlDocument()
			myXML.preserveWhiteSpace = trUE
			myXML.loadXML(ForumEntry)
			dim author as String=" "
			dim topic as String=" "
			dim message as String = " "
			dim last_post as String = ""

			dim Rauthor as String=""
			dim Rmessage as String=""
			dim Rposted as String = ""

			Dim propNode As System.Xml.XmlElement
			Dim Node As System.Xml.XmlElement = myXML.selectSingleNode("//Item[@id='" & fid & "']")

			if not Node is Nothing then
				propNode = Node.selectSingleNode("author/Item/keyed_name")
				if not propNode is Nothing Then author = propNode.innertext
				propNode = Node.selectSingleNode("topic")
				if not propNode is Nothing Then topic = propNode.innertext
				propNode = Node.selectSingleNode("message")
				if not propNode is Nothing Then message = propNode.innertext
				propNode = Node.selectSingleNode("modified_on")
				if not propNode is Nothing then last_post=propNode.innertext
%>
				<table border="0" width="100%" cellpadding="2" cellspacing="0" style='font-size:10pt; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none'>
				<tr bgcolor=Gainsboro  valign="middle"><td><%=author%>&nbsp;&nbsp;<%=last_post%></td></tr>
				<tr bgcolor=Gainsboro ><td><u><%=topic%></u><br/></td></tr>
				<tr height="10" bgcolor="Gainsboro"><td>&nbsp;</td></tr>
				<tr bgcolor=Gainsboro ><td><%=message%></td></tr>
				<tr><td><hr size="1"/></td></tr>
<%
				Dim Rnodes as System.Xml.XmlNodeList = Node.selectNodes("Relationships/Item[@type='CP_Forum_Reply']")
				Dim Rnode As System.Xml.XmlElement
				for each Rnode in Rnodes
					propNode = Rnode.selectSingleNode("author/Item/keyed_name")
					if not propNode is Nothing Then Rauthor = propNode.innertext
					propNode = Rnode.selectSingleNode("message")
					if not propNode is Nothing Then message = propNode.innertext
					propNode = Rnode.selectSingleNode("created_on")
					if not propNode is Nothing Then Rposted = propNode.innertext
%>
					<tr valign="middle"><td><%=author%>&nbsp;&nbsp;<%=Rposted%></td></tr>
					<tr><td>Re: <%=topic%></td></tr>
					<tr height="10"><td>&nbsp;</td></tr>
					<tr><td><%=message%><hr size="1"/></td></tr>
<%
				Next
			End If
%>

	</table>
</body>
</html>
