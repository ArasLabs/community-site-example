<%@ Import namespace="System.Xml" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="default.aspx.vb" Inherits="CommunityProjects._default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<HTML>
  <HEAD>

<title>ArasWorks - Innovator Community</title>

<meta name="Description" content="Aras Corporation is the leader in delivering Microsoft Enterprise Open Source Solutions to address strategic business initiatives such as PLM new product introduction and APQP quality compliance." >
<meta name="Keywords" content="aras, aras innovator, microsoft open source, microsoft enterprise solutions, apqp, apqp software, plm, plm software" >

<link rel="stylesheet" type"text/css" href="http://www.aras.com/images/tempLayoutFiles/temp_formatting.css" media="screen">
<link rel="stylesheet" type"text/css" href="http://www.aras.com/images/tempLayoutFiles/temp_typefaces.css" media="screen">
<link rel="stylesheet" type"text/css" href="http://www.aras.com/images/tempLayoutFiles/temp_navTop.css" media="screen">
<link rel="stylesheet" type"text/css" href="http://www.aras.com/images/tempLayoutFiles/temp_navSide.css" media="screen">
<link rel="stylesheet" type"text/css" href="http://www.aras.com/images/tempLayoutFiles/temp_screen.css" media="screen">
<link rel="stylesheet" type"text/css" href="http://www.aras.com/images/tempLayoutFiles/temp_print.css" media="print">
<link rel="Shortcut Icon" href="http://www.aras.com/aras.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="http://www.aras.com/images/tempLayoutFiles/temp_layout.css" title="layout" media="screen" />
<link rel="stylesheet" type="text/css" href="http://www.aras.com/images/tempLayoutFiles/temp_landingPage.css" title="layout" media="screen" />

<script language="VBScript" type="text/VBScript">
	<%@ Import Namespace="System.IO" %>
	<%
	Dim PageTitle="ArasWorks - Home Page"
	'  this section supports the Google Keyword passing
			Dim keyword = Request.QueryString("keyword")
			if keyword = "" then
			  keyword = "NULL"
			End if
	' done keywords

	' next section support cookie tracking of the end user
			Dim uniqueID As String = "unknown"
			Dim Cookie As HttpCookie
				If Request.Cookies("arascorp") Is Nothing Then
							dim cookieID=Guid.NewGuid().ToString("N").ToUpper()  'assign this visitor a unique ID
							Cookie = New HttpCookie("arascorp")
							Cookie.Expires = DateTime.MaxValue	' the cookie never expires
							Cookie.Path ="/" 				‘ the cookie applies to the whole aras site
							Cookie.Values.Add("arasid",cookieID)
							Response.AppendCookie(Cookie)
							uniqueID=cookieID  '  set the value for the hidden form field
				Else
				Cookie = Request.Cookies("arascorp")
						If Not Cookie Is Nothing Then
								uniqueID=Cookie.Values("arasid")
							Else
								uniqueID="error"
						End If
				End If


' now add the visitor information to the Visitor log
		Dim fs As FileStream = new FileStream("c:\inetpub\Logs\Visitor.Log", FileMode.OpenOrCreate, FileAccess.Write)
		Dim w As StreamWriter = new StreamWriter(fs)  '  create a Char writer
			w.BaseStream.Seek(0, SeekOrigin.End)   '  set the file pointer to the end
			w.Write( uniqueID & "," & PageTitle & "," & now & chr(13))
			w.Flush()  '  update underlying file
			w.Close()  '  close the writer and underlying file
		'  done  cookies
	%>
</script>

<script language="JavaScript" >
top.login = "";

function Login() {
    // open a model dialog to ask for email address.   Check whether the address is real, and if so return it here.
    
    top.login= showModalDialog('login.htm',null,'dialogHeight:150px; dialogWidth:350px; status:0; help:0; resizable:0');
}

function runSearch() {
    alert('Will run a search now');
}

function clearSearch() {
  var searchstring = document.all.search_string.value;
  if (searchstring=="type search string here...") document.all.search_string.value="";
}

</script>
</HEAD>

<body>
<!-- #INCLUDE FILE="c:/inetpub/wwwroot/includes/TopNav.aspx" -->
<!-- #INCLUDE FILE="c:/inetpub/wwwroot/includes/Header1.aspx" -->
<!-- #INCLUDE FILE="c:/inetpub/wwwroot/includes/LowerNav.aspx" -->

<div id="printHeader">
	<img src="http://www.aras.com/images/nav/printHeader.jpg">
</div>

<div id="curveTable">
	<img src="http://www.aras.com/images/LayoutFiles/frame_curve_wide.gif" width="774" height="15">
</div>

<div id="frameTable">

	<div id="frame">
		<div id="contentleft">
			<iframe width="100%" height="100%" name="toc" id="toc" src="TOC.ASPX" frameborder="0" ></iframe>
		</div>

		<div id="contentcenter">
			<div ID="containerFrame">
				<table  width="100%" cellpadding="0" cellspacing="0">
				<tr id="search_row" valign="middle" >
					<td align="left"  width="50%" height="15">
						&nbsp;
						<!--
						<b>Search:</b>&nbsp;<input type="text" id="search_string" name="search_string" value="type search string here..." maxlength="40" onClick="JavaScript:clearSearch();" >
						<Input type="button" id="search_button" name="search_button" value="Search" onClick="JavaScript:runSearch()">
						-->
					</td>
					<td align="right" width="50%">
						<a href="JavaScript:Login();"><b>Login</b></a>&nbsp;|&nbsp;
						<a href="http://www.aras.com/SendToInnovatorX/100080.aspx"><b>Create an Account</b></a>
					</td>
				</tr>
				<tr><td colspan="2"><hr width="100%" size="1" ></td></tr>
				</table>
			</div>


			<div id="containerFrame"><iframe width="100%" height="100%" id="main" name="main" src="projectMain.aspx" frameborder="0"></iframe></div>


	  	</div>

    	<br clear="all" >
		<!-- without this little <br /> NS6 and IE5PC do not stretch the frame div down to encopass the content DIVs -->
		<br >
		<br >
   </div>

  <!-- #INCLUDE FILE="c:/inetpub/wwwroot/includes/footer.aspx" -->

</div>

<div id="printFooter">
Contact Aras: [978] 691-8900 © 2007 Aras Corporation. All Rights Reserved.
</div>

<!-- #INCLUDE FILE="c:/inetpub/wwwroot/includes/copyright.aspx" -->
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-461988-1";
urchinTracker();
</script>

</body>
</HTML>
