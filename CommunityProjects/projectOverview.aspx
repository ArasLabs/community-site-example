<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>projectOverview</title>
<%
	Dim id as String=Request.QueryString("pid")
  	LoadProjectDetail(id)
	Dim myXML as System.Xml.XmlDocument
	myXML = New System.Xml.XmlDocument()
	myXML.preserveWhiteSpace = TRUE
	myXML.loadXML(Projects)
	
	dim author as String=" "
	dim authorEmail as String=" "
	dim name as String="unknown"
	dim url as String=" "
	dim description as String = " "
	dim downloads as String = "0"
	dim rating as String = "0.0"
	dim cp_type as String = ""
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
		propNode = Node.selectSingleNode("cp_type")
		if not propNode is Nothing Then cp_type = propNode.innertext
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
	Dim fs As FileStream = new FileStream("c:\inetpub\Logs\Visitor.Log", FileMode.OpenOrCreate, FileAccess.Write)
	Dim w As StreamWriter = new StreamWriter(fs)  '  create a Char writer
	w.BaseStream.Seek(0, SeekOrigin.End)   '  set the file pointer to the end
	w.Write( uniqueID & "," & PageTitle & "," & now & chr(13))
	w.Flush()  '  update underlying file
	w.Close()  '  close the writer and underlying file
	'  done  cookies
%>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		
		<script>
			//set the Project Type on the top object for later use
		    top.project_type = ""

			function buildURL(){
				var file_url = QueryString("file_url").toString();
				file_url = encodeURI(file_url);
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
	</HEAD>
	<body margin="0" width="100%" scroll="no">
		<script>top.project_type='<%=cp_type%>';</script>
		<table border="0" width="100%" height="100%" cellpadding="0" cellspacing="2" style='FONT-SIZE:11pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none'>
			<tr height="100%" valign="top">
				<td width="180">
					<table cellpadding="0" cellspacing="0" width="160" border="0">
						<tr>
							<td style="HEIGHT: 73px">
								<a href="<%=ScreenShot%>" target="_blank"><img width="180" src="<%=thumbnail%>"></a>
							</td>
						</tr>
						<tr height="10" style="BORDER-BOTTOM-COLOR: slategray; BORDER-BOTTOM-STYLE: solid">
							<td>
								<img src="http://www.aras.com/images/spacer.gif" width="180" height="10">
							</td>
						</tr>
						<tr height="20" style="BORDER-BOTTOM-COLOR: slategray; BORDER-BOTTOM-STYLE: solid">
							<td align="center">
								Downloads:&nbsp;&nbsp;&nbsp;<%=downloads%>
								<br>
								<br>
							</td>
						</tr>
						<tr height="120" style="BORDER-BOTTOM-COLOR: slategray; BORDER-BOTTOM-STYLE: solid">
							<td align="center">
								<table width="100%" align="center" cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td width="15%">
											<br>
											<br>
											<br>
											&nbsp;
										</td>
										<td align="center" width="70%">
											<DIV style="BORDER-LEFT-COLOR: slategray; BORDER-BOTTOM-COLOR: slategray; BORDER-TOP-STYLE: solid; BORDER-TOP-COLOR: slategray; BORDER-RIGHT-STYLE: solid; BORDER-LEFT-STYLE: solid; BORDER-RIGHT-COLOR: slategray; BORDER-BOTTOM-STYLE: solid">
												<% if rating = 0.0 then %>
												Be the First to Review<br>this Project
												<br>
												<a href="JavaScript:addReview()">Click Here</a>
												<img src="icons/review-<%=rating%>-5-stars.gif" border=0>

												<% else  %>
												Average rating of
												<H2><%=rating%></H2>
												out of 5 stars<BR>
												<img src="icons/review-<%=rating%>-5-stars.gif" border=0>
												<% End If %>
											</DIV>
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
					<table  border="0" cellspacing="0" style="padding:0px 0px 10px 0px; FONT-SIZE:9pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif">
						<tr height="10" padding-top="0">
							<td colspan="3" ><font style="FONT-SIZE:11pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif">
								<b>Description</b></font><hr width="100%">
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<textarea style="overflow-x: hidden; overflow-y: scroll; border:0; FONT-SIZE:8pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; height:190; width:380;"><%=description%></textarea>
							</td>
						</tr>
						<tr height="15">
							<td colspan="3"><font style="FONT-SIZE:11pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif">
								<b>Project Info</b></font><hr width="100%">
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
							If cp_type = "Commercial" Then
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
							<td align="left" style="padding:0px 0px 10px 0px;"><b>Versions<br>Supported</b></td>
							<td>&nbsp;</td>
							<td align="left" style="padding:0px 0px 10px 0px;"><%=versions%></td>
						</tr>
						<tr valign="bottom" height="15">
							<td align="left" style="padding:0px 0px 10px 0px;"><b>Category</b></td>
							<td>&nbsp;</td>
							<td align="left" style="padding:0px 0px 10px 0px;"><%=cp_category%></td>
						</tr>
						<tr valign="bottom" height="15">
							<td align="left" ><b>Level</b></td>
							<td>&nbsp;</td>
							<td align="left"><a href="JavaScript:helpLevel();"><%=cp_level%></a></td>
						</tr>
						<tr valign="bottom" height="15">
							<td align="left" ><b>Type</b></td>
							<td>&nbsp;</td>
							<td align="left"><a href="JavaScript:helpType();"><%=cp_type%></a></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</HTML>
