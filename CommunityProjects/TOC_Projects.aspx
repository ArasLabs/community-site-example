<%@ Import namespace="System.Xml" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC"%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"  lang="en" >
<head>
<title>TOC</title>
<meta name="Description" content="Aras is the leader in delivering Microsoft Enterprise Open Source Solutions to address strategic business initiatives such as PLM new product introduction and APQP quality compliance." />
<link rel="stylesheet" type="text/css" href="http://www.aras.com/styles/aras.css" />


<script language="JavaScript" type="text/JavaScript">
function onMain() {
	top.document.all.maincontent.src="projectMain.aspx";
}

function onCategory(which,id){

	top.document.all['maincontent'].src="projectBrowser.aspx?cat="+which;

}

function onProject(which,id){
	 
	    top.document.all.maincontent.src="project.aspx?pid=" + id;
}

function TABLE1_onclick() {

}

</script>
</head>
<body bgcolor="#e0e0e0" leftmargin="0" rightmargin="0" bottommargin="0" height="100%">
<div>
			<table border="0" width="100%" height="100" style="padding-right:0px; padding-left:0px; font-size:8pt; padding-bottom:0px; padding-top:0px; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none" cellpadding="0" cellspacing="0">
				<tr height="10"><td align="left" onclick="onMain();"><b><font style="font-size:11pt">Aras Projects</font></b><br/><hr width="100%"></td></tr>
				<tr height="10"><td align="left"><b><font style="font-size:9pt">Browse By Category</font></b></td></tr>
				<tr height="20" valign="top" margin="0">
					<td height="20">
						<div id=buttonFrame style="text-indent: 5px; height: 20px; text-align: left">
							<div id=button style="margin-top:0">
							<ul>
							<li>
							<a href="JavaScript:onCategory('Recent','0');"><b>Recent Updates...</b>
							</a>
							</li>
							</ul>
							</div>
						</div>
					</td>
				</tr>
			<%
				loadTOC()
				Dim CatsXML as System.Xml.XmlDocument
				CatsXML = New XmlDocument()
				CatsXML.preserveWhiteSpace = trUE
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
				<tr height="20" valign="top" margin="0">
					<td height="20">
						<div id=buttonFrame style="text-indent: 5px; height: 20px; text-align: left">
							<div id=button style="margin-top:0">
							<ul>
							<li>
							<a href="JavaScript:onCategory('<%=CatName%>','<%=catId%>');"><%=CatName%>
							</a>
							</li>
							</ul>
							</div>
						</div>
					</td>
				</tr>
				<%
				next
				%>

			<tr height="10"><td align="left">&nbsp;</td></tr>
		</table>
</div>
<div>
		<table border="0" width="100%" height="100" style="padding-right:0px; padding-left:0px; font-size:8pt; padding-bottom:0px; padding-top:0px; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none" cellpadding="0" cellspacing="0">
			<tr height="10"><td align="left" style="font-size:9ptl font-weight:bold;">Browse By Project</td></tr>
      <tr><td >
		<div style="height:345px; width:145px; overflow-x: hidden; overflow-y: scroll; " >
			<table border="0" height="100%" style="padding-right:0px; padding-left:5px; font-size:8pt; padding-bottom:0px; padding-top:0px; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none; border-spacing:0px" cellpadding="0" cellspacing="0" id="TABLE1" language="javascript" onclick="return TABLE1_onclick()">
				<%
				CatsXML.loadXML(Projects)
				Nodes  = CatsXML.selectNodes("//Item[@type='CP_CommunityProject']")
				For Each Node in Nodes
					Dim CatName as String = " "
					Dim CatId as String = Node.getAttribute("id")
					' Load the properties
				        Dim propNode As System.Xml.XmlElement = Node.SelectSingleNode("name")
				        If Not propNode Is Nothing Then
				            CatName = propNode.InnerText
				        End If

				%>
				<tr valign="top">
					<td >
						<div  >
							<div id=button >
							<ul>
							<li >
							<a href="JavaScript:onProject('<%=CatName%>','<%=catId%>');"><div style="width:115px; text-align:left; WORD-WRAP:break-word"><%=CatName%></div>
							</a>
							</li>
							</ul>
							</div>
						</div>
					</td>
				</tr>
				<%
				next
				%>
			</table>
		</div>
		</td></tr>
	</table>
	</div>

	</body>
</html>
