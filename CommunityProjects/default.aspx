<%@ Import namespace="System.Xml" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC"  %>
<%  Dim pid as String=Request.QueryString("projectid") %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"  lang="en" >
<head>

<title>Aras Community Projects</title>
<meta name="Description" content="Aras is the leader in delivering Microsoft Enterprise Open Source Solutions to address strategic business initiatives such as PLM new product introduction and APQP quality compliance." />
<link rel="stylesheet" type="text/css" href="http://www.aras.com/styles/aras.css" />

<% 	Dim PageTitle  ="Community Projects - Home Page"
	' get the base URL'
	Dim baseURL = request.url.toString()
	baseURL = left(baseURL, InStr(1, baseURL, "CommunityProjects", CompareMethod.Text)-1)

	Dim WhichPage as String = "projectMain.aspx"
	if pid <> "" then WhichPage="project.aspx?pid=" + pid
%>
<!-- #INCLUDE FILE="c:/inetpub/wwwroot/includes/arasTracking_v2.aspx" -->


<script language="JavaScript" type="text/JavaScript">
top.login = "";
top.usertype = "";

function Login() {
    // open a model dialog to ask for email address.   Check whether the address is real, and if so return it here.

    var res= showModalDialog('login.htm',null,'dialogHeight:150px; dialogWidth:350px; status:0; help:0; resizable:0');
    if (!res) {
		top.login = "";
		top.usertype = "";
	} else {
		top.login=res.id;
		top.usertype=res.status;
	}
}

function runSearch() {
    var target = top.document.getElementById("search_string");
    var searchstring = target.value;
    if (searchstring == "type search string here..." ) {
        target.value="";
        return;
    }

    if (searchstring=="") return;
    target = top.document.getElementById("maincontent");
	target.src="projectBrowser.aspx?search="+searchstring;
	clearSearch();
}

function clearSearch() {
    var target = top.document.getElementById("search_string");
    var searchstring = target.value;
    if (searchstring=="type search string here...") target.value="";
}

function jump2project() {
   var pid = '<%=pid%>';
   if (pid != "") {
   var target = top.document.getElementById("maincontent");
   if (pid.toString() == '347251944FBE46769DE987CE996E2895')
	 {
	    pid='DD32FF42D8B14CB28CD4732AAF2F5349';
	 }
   target.src="project.aspx?pid=" + pid;
   }
}

function onCategory(which,id){
    var target = top.document.getElementById("maincontent");
	target.src="projectBrowser.aspx?cat="+which;
}

</script>
</head>

<body>
<div id="ArasWrapper">
	<!-- #INCLUDE FILE="c:/inetpub/wwwroot/includes/TopNav_v2.aspx" -->
	<!-- #INCLUDE FILE="c:/inetpub/wwwroot/includes/PageHeader_v2.aspx" -->
	<!-- #INCLUDE FILE="c:/inetpub/wwwroot/includes/LowerNav_v2.aspx" -->

	<div id="MainContentWrapper" >

		<div id="MainTopGraphic">
			<img src="http://www.aras.com/images_v2/layoutfiles/frame_curve_withNav.gif" width="950" height="15" border="0" alt="Aras PLM"/>
		</div>

		<div id="SideBar" style="height:645px; overflow-y:scroll; ">
			<span style="font-family: 'Tahoma', Tahoma, Arial, sans-serif; font-weight: bold;	font-size: 11px;">Browse By Category</span>
			<div class="SideBarButton" style="width:126px; overflow:hidden; text-indent: 5px">
				<a href="JavaScript:onCategory('Recent','0');"><b>Recent Updates</b></a>
			</div>
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
			<div class="SideBarButton" style="width:126px; overflow:hidden; text-indent: 5px">
				<a href="javascript:onCategory('<%=CatName%>','<%=catId%>');"><%=CatName%></a>
			</div>

			<%
			next
			%>
			<span style="font-family: 'Tahoma', Tahoma, Arial, sans-serif; font-weight: bold;	font-size: 11px;">Browse By Project</span>
			<%
			CatsXML.loadXML(Projects)
			Nodes  = CatsXML.selectNodes("//Item[@type='CP_CommunityProject']")
			For Each Node in Nodes
				Dim CatName as String = " "
			        Dim CatId As String = Node.GetAttribute("id")
			        If CatId = "347251944FBE46769DE987CE996E2895" Then
			            CatId = "DD32FF42D8B14CB28CD4732AAF2F5349"
			        End If
				' Load the properties'
				Dim propNode As System.Xml.XmlElement = Node.selectSingleNode("name")
				if not propNode is Nothing Then
					CatName = propNode.innertext
				End If
			%>
			<div class="SideBarButton" style="width:126px; overflow:hidden; text-indent: 5px" >
				<a href="<%=baseURL%>communityprojects?projectid=<%=catId%>"><%=CatName%></a>
			</div>

			<%
			next
			%>

		</div> <!-- end of SideBar -->
		<div id="MainColumn" >
			<div id="frame" style="margin:0; padding:0; ">
				<div id="contentcenter" style="height:600; padding:0; margin:0;">
					<div class="MainContentContainer" style="width:100%; padding:0; margin:0; ">
						<table  width="98%" cellpadding="0" cellspacing="0">
							<tr id="search_row" valign="middle" >
								<td align="left"  width="50%" >
									&nbsp;
									<b>Search:</b>&nbsp;<input type="text" id="search_string" name="search_string" value="type search string here..." maxlength="40" onclick="JavaScript:clearSearch();" />
									<input type="button" id="search_button" name="search_button" value="Search" onclick="JavaScript:runSearch()"/>
								</td>
								<td align="right" width="50%" height="15">
									<a href="JavaScript:Login();"><b>Login</b></a>&nbsp;|&nbsp;
									<a href="http://www.aras.com/PLM-Software/100080.aspx"><b>Create an Account</b></a>
								</td>
							</tr>
							<tr><td colspan="2"><hr width="100%" size="1" style="padding:0px; margin:0px;"/></td></tr>
						</table>
					</div>
					<div id="containerFrame" style="padding:0; margin:0; ">
						<iframe width="100%" height="585" id="maincontent" name="maincontent" src="<%=WhichPage%>" frameborder="0" scrolling="auto"></iframe>
					</div>
	  			</div>
    			<br clear="all" />
			</div> <!-- end of MainContent -->
		</div> <!-- end of MainColumn -->
	</div> <!-- end of MainContentWrapper -->

	<!-- #INCLUDE FILE="c:/inetpub/wwwroot/includes/Footer_v2.aspx" -->
	<!-- #INCLUDE FILE="c:/inetpub/wwwroot/includes/Copyright_v2.aspx" -->
</div>
</body>
</html>

