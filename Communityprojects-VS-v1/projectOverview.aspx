<%@ Import namespace="System.Xml" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>projectOverview</title>
		<%
	Dim id as String=Request.QueryString("pid")
%>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script>
    function buildURL(){
		var file_url = QueryString("file_url").toString();
		file_url = encodeURI(file_url);
	}
    
		</script>
	</HEAD>
	<body>
		<%
  		    LoadProjectDetail(id)
			Dim myXML as System.Xml.XmlDocument
			myXML = New XmlDocument()
			myXML.preserveWhiteSpace = TRUE
			myXML.loadXML(Projects)
			dim author as String=" "
			dim name as String=" "
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
				propNode = Node.selectSingleNode("name")
				if not propNode is Nothing Then name = propNode.innertext
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
%>
		<table border="0" width="100%" height="100%" cellpadding="0" cellspacing="2" style='FONT-SIZE:11pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none'>
			<tr height="100%" valign="top">
				<td width="160">
					<table cellpadding="0" cellspacing="0" width="160" border="0">
						<tr>
							<td style="HEIGHT: 73px"><a href="<%=ScreenShot%>" target="_blank"><img width="160" src="<%=thumbnail%>"></a>
							<td style="HEIGHT: 73px"></td>
						<tr height="10" style="BORDER-BOTTOM-COLOR: slategray; BORDER-BOTTOM-STYLE: solid">
							<td><img src="http://www.aras.com/images/spacer.gif" width="200" height="10">&nbsp;</td>
						</tr>
						<tr height="20" style="BORDER-BOTTOM-COLOR: slategray; BORDER-BOTTOM-STYLE: solid">
							<td align="center">Downloads:&nbsp;&nbsp;&nbsp;<%=downloads%><br>
								<br>
							</td>
						</tr>
						<tr height="120" style="BORDER-BOTTOM-COLOR: slategray; BORDER-BOTTOM-STYLE: solid">
							<td align="center">
								<table width="100%" align="center" cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td width="15%"><br>
											<br>
											<br>
											&nbsp;</td>
										<TD align="center" width="70%">
											<DIV style="BORDER-LEFT-COLOR: slategray; BORDER-BOTTOM-COLOR: slategray; BORDER-TOP-STYLE: solid; BORDER-TOP-COLOR: slategray; BORDER-RIGHT-STYLE: solid; BORDER-LEFT-STYLE: solid; BORDER-RIGHT-COLOR: slategray; BORDER-BOTTOM-STYLE: solid">
												Average rating of
												<H2><%=rating%></H2>
												out of 5 stars<BR>
												<img src="icons/review-<%=rating%>-5-stars.gif" border=0>
											</DIV>
										</TD>
										<td width="15%" height="20">&nbsp;</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<td width="100%" align="left">
					<table width="100%" border="0" cellpadding="0" cellspacing="4" style="FONT-SIZE:9pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif">
						<tr>
							<td colspan="3"><font style="FONT-SIZE:8pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif"><%=description%></font></td>
						</tr>
						<tr>
							<td colspan="3"><font style="FONT-SIZE:11pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif"><br>
									<b>Project Info</b></font><hr width="100%">
							</td>
						</tr>
						<tr valign="bottom">
							<td align="left" width="250"><b>Author</b></td>
							<td width="12">&nbsp;</td>
							<td align="left" width="100%"><%=author%></td>
						</tr>
						<tr height="5">
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr valign="bottom">
							<td align="left"><b>License</b></td>
							<td>&nbsp;</td>
							<td align="left"><%=license%></td>
						</tr>
						<tr height="5">
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr valign="bottom">
							<td align="left"><b>Versions<br>
									Supported</b></td>
							<td>&nbsp;</td>
							<td align="left"><%=versions%></td>
						</tr>
						<tr height="5">
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr valign="bottom">
							<td align="left"><b>Category</b></td>
							<td>&nbsp;</td>
							<td align="left"><%=cp_category%></td>
						</tr>
						<tr height="5">
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr valign="bottom">
							<td align="left"><b>Level</b></td>
							<td>&nbsp;</td>
							<td align="left"><%=cp_level%></td>
						</tr>
						<tr height="5">
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr valign="bottom">
							<td align="left"><b>Type</b></td>
							<td>&nbsp;</td>
							<td align="left"><%=cp_type%></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</HTML>
