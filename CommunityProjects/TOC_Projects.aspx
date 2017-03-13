<%@ Import namespace="System.Xml" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
	<title>TOC</title>
	<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
	<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
	<meta name="vs_defaultClientScript" content="JavaScript">
	<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	<link rel="stylesheet" type href="http://www.aras.com/styles/LandingPage.css" css?? text>
	
<style type="text/css"> .innerb {height:345px; width:145px; overflow-x: hidden; overflow-y: scroll; }
	</style>
	
<script>
function onMain() {
	top.document.all.maincontent.src="projectMain.aspx";
}

function onCategory(which,id){

	top.document.all['maincontent'].src="projectBrowser.aspx?cat="+which;

}
	
function onProject(which,id){
	top.document.all.maincontent.src="project.aspx?pid=" + id;
}

</script>
</HEAD>
<body bgcolor="#e0e0e0" leftmargin="0" rightmargin="0" bottommargin="0" height="100%">
<div>
			<table border="0" width="100%" height="100" style="PADDING-RIGHT:0px; PADDING-LEFT:0px; FONT-SIZE:8pt; PADDING-BOTTOM:0px; PADDING-TOP:0px; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none" cellpadding="0" cellspacing="0">
				<tr height="10"><td align="left" onclick="onMain();"><b><font style="FONT-SIZE:11pt">Aras Projects</font></b><br><hr width="100%"></td></tr>
				<tr height="10"><td align="left"><b><font style="FONT-SIZE:9pt">Browse By Category</font></b></td></tr>
				<TR height="20" valign="top" margin="0">
					<td height="20">
						<DIV id=buttonFrame style="TEXT-INDENT: 5px; HEIGHT: 20px; TEXT-ALIGN: left">
							<DIV id=button style="top-margin:0">
							<UL>
							<li>
							<A href="JavaScript:onCategory('Recent','0');"><b>Recent Updates...</b>
							</A>
							</li>
							</UL>
							</DIV>
						</DIV>
					</td>
				</TR>
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
				<TR height="20" valign="top" margin="0">
					<td height="20">
						<DIV id=buttonFrame style="TEXT-INDENT: 5px; HEIGHT: 20px; TEXT-ALIGN: left">
							<DIV id=button style="top-margin:0">
							<UL>
							<li>
							<A href="JavaScript:onCategory('<%=CatName%>','<%=catId%>');"><%=CatName%>
							</A>
							</li>
							</UL>
							</DIV>
						</DIV>
					</td>
				</TR>
				<%
				next
				%>

			<tr height="10"><td align="left"><img src="http://www.aras.com/images/spacer.gif" width="10" height="10" border="0"></td></tr>
		</table>
</div>
<div>
		<table border="0" width="100%" height="100" style="PADDING-RIGHT:0px; PADDING-LEFT:0px; FONT-SIZE:8pt; PADDING-BOTTOM:0px; PADDING-TOP:0px; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none" cellpadding="0" cellspacing="0">
			<tr height="10"><td align="left"><b><font style="FONT-SIZE:9pt">Browse By Project</font></b></td></tr>
      <tr><td >
		<div class="innerb" >
			<table border="0" height="100%" style="PADDING-RIGHT:0px; PADDING-LEFT:5px; FONT-SIZE:8pt; PADDING-BOTTOM:0px; PADDING-TOP:0px; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none; border-spacing:0px" cellpadding="0" cellspacing="0">
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
				<TR valign="top">
					<td >
						<DIV  >
							<DIV id=button > 
							<UL>
							<li >
							<A href="JavaScript:onProject('<%=CatName%>','<%=catId%>');"><div style="WIDTH:115px; TEXT-ALIGN:left; WORD-WRAP:break-word"><%=CatName%></div>
							</A>
							</li>
							</UL>
							</DIV>
						</DIV>
					</td>
				</TR>
				<%
				next
				%>
			</table>
		</div>
		</td></tr>
	</table>
	</div>

	</body>
</HTML>
