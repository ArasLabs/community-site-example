<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC"  %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"  lang="en" >
<head>

<title>projectOverview</title>
<meta name="Description" content="Aras is the leader in delivering Microsoft Enterprise Open Source Solutions to address strategic business initiatives such as PLM new product introduction and APQP quality compliance." />
<link rel="stylesheet" type="text/css" href="http://www.aras.com/styles/aras.css" />

<%
	Dim id as String=Request.QueryString("pid")
  	LoadProjectDetail(id)
	Dim myXML as System.Xml.XmlDocument
	myXML = New System.Xml.XmlDocument()
	myXML.preserveWhiteSpace = trUE
	myXML.loadXML(Projects)

	dim author as String=" "
	dim authorEmail as String=" "
	dim name as String="unknown"
	dim url as String=" "
	dim description as String = " "
	dim downloads as String = "0"
	dim rating as String = "0.0"
	dim is_exchange as String = "0"
	dim is_open as String = "1"
	dim is_commercial as String = "0"
	dim is_verified as String = "0"
	dim cp_level as String = ""
	dim cp_category as String=""
	dim versions as String = ""
	dim license as String = ""
	Dim dev_status as String=""
	dim screenshot as string =""
	dim thumbnail as String = ""
	Dim propNode As System.Xml.XmlElement
	Dim Node As System.Xml.XmlElement = myXML.selectSingleNode("//Item[@id='" & id & "']")
	if not Node is Nothing then
		propNode = Node.selectSingleNode("author/Item/keyed_name")
		if not propNode is Nothing Then author = propNode.innertext
		propNode = Node.selectSingleNode("author/Item/email")
		if not propNode is Nothing Then authorEmail = propNode.innertext

		propNode = Node.selectSingleNode("name")
		if not propNode is Nothing Then name = propNode.innertext
		propNode = Node.selectSingleNode("url")
		if not propNode is Nothing Then url = propNode.innertext
		propNode = Node.selectSingleNode("description")
		if not propNode is Nothing Then description = propNode.innertext
		propNode = Node.selectSingleNode("downloads")
		if not propNode is Nothing Then downloads = propNode.innertext
		propNode = Node.selectSingleNode("rating")
		if not propNode is Nothing Then
			rating = propNode.innertext
			if rating.indexOf(".") = -1 then rating=rating & ".0"
		End If
		propNode = Node.selectSingleNode("is_verified")
		if not propNode is Nothing Then is_verified = propNode.innertext
		if is_verified="1" then
		   is_verified="Yes"
		else
		   is_verified="No"
		End If
		propNode = Node.selectSingleNode("is_open")
		if not propNode is Nothing Then is_open = propNode.innertext
		if is_open = "1" then
		   is_open = "Yes"
		else
		   is_open = "No"
		End If
		propNode = Node.selectSingleNode("is_exchange")
		if not propNode is Nothing Then is_exchange = propNode.innertext
		if is_exchange="1" then
		   is_exchange="Yes"
		else
		   is_exchange="No"
		end if
		propNode = Node.selectSingleNode("is_commercial")
		if not propNode is Nothing Then is_commercial = propNode.innertext
		if is_commercial="1" then
		   is_commercial="Yes"
		else
		   is_commercial="No"
		end if

		propNode = Node.selectSingleNode("cp_level")
		if not propNode is Nothing Then cp_level = propNode.innertext
		propNode = Node.selectSingleNode("cp_category")
		if not propNode is Nothing Then cp_category = propNode.innertext
		propNode = Node.selectSingleNode("versions")
		if not propNode is Nothing Then versions = propNode.innertext
		propNode = Node.selectSingleNode("license")
		if not propNode is Nothing Then license = propNode.innertext
		propNode = Node.selectSingleNode("dev_status")
		if not propNode is Nothing Then dev_status = propNode.innertext
		propNode = Node.selectSingleNode("screenshot")
		if not propNode is Nothing Then screenshot = propNode.innertext
		propNode = Node.selectSingleNode("thumbnail")
		if not propNode is Nothing Then thumbnail = propNode.innertext
	End If

	Dim PageTitle="Community Projects - " & name
	' next section support cookie tracking of the end user
	Dim uniqueID As String = "unknown"
	Dim Cookie As HttpCookie
	If Request.Cookies("arascorp") Is Nothing Then
		dim cookieID=Guid.NewGuid().ToString("N").ToUpper()  'assign this visitor a unique ID
		Cookie = New HttpCookie("arascorp")
		Cookie.Expires = DateTime.MaxValue	' the cookie never expires
		Cookie.Path ="/" 	‘ the cookie applies to the whole aras site
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
	Dim ClientIP as String = Request.UserHostAddress
	Try
		Dim fs As FileStream = new FileStream("c:\inetpub\Logs\Visitor.Log", FileMode.OpenOrCreate, FileAccess.Write)
		Dim w As StreamWriter = new StreamWriter(fs)  '  create a Char writer
		w.BaseStream.Seek(0, SeekOrigin.End)   '  set the file pointer to the end
		w.Write( uniqueID & "," & PageTitle & "," & now & "," & ClientIP & chr(13))
		w.Flush()  '  update underlying file
		w.Close()  '  close the writer and underlying file
	Catch exc as exception

	Finally

	End Try
%>

<script language="JavaScript" type="text/JavaScript">
//set the Project Is-Exchange flag on the top object for later use
 top.project_is_exchange = "0"

function buildURL(){
		var file_url = QueryString("file_url").toString();
		file_url = encodeURI(file_url);
}

function helpVerified() {
		// open a model dialog to show the help
		showModalDialog('helpVerified.htm',null,'dialogHeight:300px; dialogWidth:540px; status:0; help:0; resizable:1');
}
function helpType() {
		// open a model dialog to show the help
		showModalDialog('helpType.htm',null,'dialogHeight:300px; dialogWidth:540px; status:0; help:0; resizable:1');
}
function helpLevel() {
		// open a model dialog to show the help
		showModalDialog('helpLevel.htm',null,'dialogHeight:350px; dialogWidth:540px; status:0; help:0; resizable:1');
}

function addReview() {
		 parent.document.Script.tabbar.setTabActive(parent.document.Script.tabbar.getTabByIndex(2));

}
</script>
</head>
<body margin="0" width="100%" scroll="no">
		<script language="JavaScript" type="text/JavaScript">top.project_is_exchange='<%=is_exchange%>';</script>
		<table border="0" width="100%" height="100%" cellpadding="0" cellspacing="1" style='font-size:11pt; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none'>
			<tr height="100%" valign="top">
				<td width="180" >
					<table cellpadding="0" cellspacing="0" width="170" border="0">
						<tr>
							<td style="height: 73px">
								<a href="<%=ScreenShot%>" target="_blank"><img width="160" src="<%=thumbnail%>" alt="Aras PLM"></a>
							</td>
						</tr>
						<tr height="10" style="border-bottom-color: slategray; border-bottom-style: solid">
							<td>
								&nbsp;
							</td>
						</tr>
						<tr height="20" style="border-bottom-color: slategray; border-bottom-style: solid">
							<td align="center">
								Downloads:&nbsp;&nbsp;&nbsp;<%=downloads%>
								<br/>
								<br/>
							</td>
						</tr>
						<tr height="120" style="border-bottom-color: slategray; border-bottom-style: ">
							<td align="center">
								<table width="100%" align="center" cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td width="15%">
											<br/>
											<br/>
											<br/>
											&nbsp;
										</td>
										<td align="center" width="70%">
											<div style="border-left-color: slategray; border-bottom-color: slategray; border-top-style: solid; border-top-color: slategray; border-right-style: solid; border-left-style: solid; border-right-color: slategray; border-bottom-style: solid">
												<% if rating = 0.0 then %>
												Be the First to Review<br/>this Project
												<br/>
												<a href="JavaScript:addReview()">Click Here</a>
												<img src="http://www.aras.com/communityProjects/icons/review-<%=rating%>-5-stars.gif" border=0>

												<% else  %>
												Average rating of
												<H2><%=rating%></H2>
												out of 5 stars<br/>
												<img src="http://www.aras.com/communityProjects/icons/review-<%=rating%>-5-stars.gif" border=0>
												<% End If %>
											</div>
										</td>
										<td width="15%" height="20">
											&nbsp;
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<td align="left" >
					<table  border="0" cellpadding="0" cellspacing="0" style="padding:0px 0px 0px 0px; font-size:9pt; font-family:tahoma, arial, helvetica, sans-serif">
						<tr height="10" padding-top="0">
							<td colspan="3"  style="font-weight: bold;font-size:11pt; font-family:tahoma, arial, helvetica, sans-serif; ">
								Description
							</td>
						</tr>
						<tr>
							<td colspan="3" style="border:1px solid #999; ">
								<textarea style="overflow-x: hidden; overflow-y: scroll; font-size:8pt; font-family:tahoma, arial, helvetica, sans-serif; height:175px; width:506px;"><%=description%></textarea>
							</td>
						</tr>
						<tr >
							<td colspan="3" style="font-weight: bold;font-size:11pt; font-family:tahoma, arial, helvetica, sans-serif">
								Project Info<hr width="100%">
							</td>
						</tr>
						<tr valign="bottom" height="15">
							<td align="left" style="padding:0px 0px 10px 0px;"><b>Author</b></td>
							<td width="12">&nbsp;</td>
							<% if AuthorEmail = "" Then  %>
							<td align="left" width="100%" style="padding:0px 0px 10px 0px;"><%=author%></td>
							<% else %>
							<td align="left" width="100%" style="padding:0px 0px 10px 0px;"><a href="mailto:<%=authorEmail%>?subject=About your Aras Community Solution: <%=name%>"><%=author%></a></td>
							<% End IF %>

						</tr>
						<%
							If is_commercial = "Yes" Then
						%>
						<tr valign="bottom" height="15">
							<td align="left" style="padding:0px 0px 10px 0px;"><b>Web Site</b></td>
							<td width="12">&nbsp;</td>
							<td align="left" width="100%" style="padding:0px 0px 10px 0px;"><a href="<%=url%>" target="_blank"><%=url%></a></td>
						</tr>
						<%
						   End If
						%>
						<tr valign="bottom" height="15">
							<td align="left" style="padding:0px 0px 10px 0px;"><b>License</b></td>
							<td>&nbsp;</td>
							<td align="left" style="padding:0px 0px 10px 0px;"><%=license%></td>
						</tr>
						<tr valign="bottom" height="15">
							<td align="left" style="padding:0px 0px 10px 0px;"><b>Versions<br/>Supported</b></td>
							<td>&nbsp;</td>
							<td align="left" style="padding:0px 0px 10px 0px;"><%=versions%></td>
						</tr>
						<tr valign="bottom" height="15">
							<td align="left" style="padding:0px 0px 10px 0px;"><b>Category</b></td>
							<td>&nbsp;</td>
							<td align="left" style="padding:0px 0px 10px 0px;"><%=cp_category%></td>
						</tr>
						<tr valign="middle" height="15">
							<td align="left" style="padding:0px 0px 10px 0px;"><a href="JavaScript:helpLevel();"><b>Level</b></a></td>
							<td>&nbsp;</td>
							<td align="left" style="padding:0px 0px 10px 0px;"><%=cp_level%></td>
						</tr>
						<tr valign="bottom" height="15">
							<td align="left" ><a href="JavaScript:helpVerified();"><b>Verified?</b></a></td>
							<td>&nbsp;</td>
							<td align="left"><%=is_verified%></td>
						</tr>

						<tr valign="middle" height="15"><td>&nbsp;</td></tr>

						<tr valign="middle" >
							<td align="left" ><a href="JavaScript:helpType();"><b>Type</b></a></td>
							<td>&nbsp;</td>
							<td align="left">
								<table  border="0" cellspacing="0" style="padding:0px 0px 10px 0px; font-size:9pt; font-family:tahoma, arial, helvetica, sans-serif">
								<tr><td><b>Open:</b></td><td width="3">&nbsp;</td><td><%=is_open%></td></tr>
								<tr><td><b>Subscribers Only:</b></td><td width="3">&nbsp;</td><td><%=is_exchange%></td></tr>
								<tr><td><b>Commercial:</b></td><td width="3">&nbsp;</td><td><%=is_commercial%></td></tr>
								</table>
							</td>
						</tr>

					</table>
				</td>
			</tr>
		</table>
	</body>
</html>
