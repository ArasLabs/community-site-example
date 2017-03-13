<%@ Import namespace="System.Xml" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>projectOverview</title>
		<%		    Dim id as String=Request.QueryString("pid")%>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script>
		function addReview() {
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

		    // open a model dialog to ask for the review.  The dialog may post back to an ASPX the review body
            var repaint = showModalDialog('addReview.aspx?pid=<%=id%>&email='+top.login,null,'dialogHeight:200px; dialogWidth:500px; status:0; help:0; resizable:0');
            if (repaint) document.location="projectReviews.aspx?pid=<%=id%>";
		}
		</script>
	</HEAD>
	<body rightmargin="0">
		<a href="JavaScript:addReview();">Add Review</a><br>
		<table border="1" bordercolor="#a0a000" width="100%" cellpadding="0" cellspacing="0" style='FONT-SIZE:11pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none'>
			<tr bgcolor="honeydew">
				<th width="25%">
					Rating</th><th width="75%">Review</th></tr>
			<%
		    LoadReviews(id)
			Dim myXML as System.Xml.XmlDocument
			myXML = New XmlDocument()
			myXML.preserveWhiteSpace = TRUE
			myXML.loadXML(Reviews)
			Dim Nodes As System.Xml.XmlNodeList = myXML.selectNodes("//Item[@type='CP_Reviews']")
			Dim Node As System.Xml.XmlElement
			For Each Node in Nodes
				Dim Name as String = "?"
				Dim Rating as String  = "0.0"
				Dim Review as String  = "na"
				Dim propNode As System.Xml.XmlElement = Node.selectSingleNode("author/Item/keyed_name")
				if not propNode is Nothing Then
					Name = propNode.innertext
				End If	
				propNode = Node.selectSingleNode("review")
				if not propNode is Nothing Then
					Review = propNode.innertext
				End If	
				propNode = Node.selectSingleNode("rating")
				if not propNode is Nothing Then
					Rating = propNode.innertext & ".0"
				End If	


			%>
			<TR valign="middle">
				<TD align='center'><%=Name%><br>
					<%=Rating%>
					<br>
					<img border="0" src="icons/review-<%=Rating%>-5-stars.gif"></TD>
				<TD align='left'><%=Review%></TD>
			</TR>
			<%
			next
			%>
		</table>
	</body>
</HTML>
