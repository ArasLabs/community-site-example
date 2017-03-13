<%@ Import namespace="System.Xml" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC"  %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"  lang="en" >
<head>
<title>projectOverview</title>
<%		    Dim id as String=Request.QueryString("pid")%>
<meta name="Description" content="Aras is the leader in delivering Microsoft Enterprise Open Source Solutions to address strategic business initiatives such as PLM new product introduction and APQP quality compliance." />
<link rel="stylesheet" type="text/css" href="http://www.aras.com/styles/aras.css" />

<script language="JavaScript" type="text/JavaScript">
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

</head>
<body rightmargin="0">
		<a href="JavaScript:addReview();">Add Review</a><br/>
		<table border="1" bordercolor="#a0a000" width="100%" cellpadding="0" cellspacing="0" style='font-size:11pt; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none'>
			<tr bgcolor="honeydew">
				<th width="25%">
					Rating</th><th width="75%">Review</th></tr>
			<%
		   LoadReviews(id)
			Dim myXML as System.Xml.XmlDocument
			myXML = New XmlDocument()
			myXML.preserveWhiteSpace = trUE
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
			<tr valign="middle">
				<td align='center'><%=Name%><br/>
					<%=Rating%>
					<br/>
					<img border="0" src="http://www.aras.com/communityProjects/icons/review-<%=Rating%>-5-stars.gif"></td>
				<td align='left'><%=Review%></td>
			</tr>
			<%
			next
			%>
		</table>
	</body>
</html>
