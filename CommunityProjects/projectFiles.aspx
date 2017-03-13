<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC"  %>
<%@ Import namespace="System.Xml" %>
<%
	Dim id as String=Request.QueryString("pid")
	Dim pname as String=Request.QueryString("name")
	dim licenseName as String = Request.QueryString("license")
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"  lang="en" >

<head>
 <title>projectOverview</title>

 <script language="JavaScript" type="text/JavaScript">
 function downloadFile(fid,license) {
	  if (top.project_is_exchange=='Yes') {
		if (top.login=="") {
			var res= showModalDialog('SubscriberLogin.htm',null,'dialogHeight:346px; dialogWidth:428px; status:0; help:0; resizable:0');
			if (!res) {
				top.login = "";
				top.usertype = "";
			} else {
				top.login=res.id;
				top.usertype=res.status;
			}
		}
		if (top.login=="" || (top.usertype!='Subscriber' && top.usertype!='Partner') ) {
			alert('File access limited to Aras Community Subscribers Only\nPlease contact info@aras.com for more information');
			return;
		}
	  }
	  if (license=="1") {
			// need a test on the Project header to see which License is being used
			var LicFileName = 'License-CL.htm';
			if ('<%=licenseName%>' == 'Microsoft Public License') LicFileName = 'License-PL.htm';

		 var res=showModalDialog(LicFileName,null,'dialogHeight:550px; dialogWidth:600px; status:0; help:0; resizable:0');
		 if (res=="0") return;
	  }
	  window.open("FileDownload.aspx?fid=" + fid + "&pid=<%=id%>&name=<%=pname%>")
 }
 </script>
</head>

<body>
		<table border="1" bordercolor="SlateGrayLight" width="100%" cellpadding="0" cellspacing="0" style='font-size:10pt; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none'>
			<tr bgcolor="Honeydew" style="font-size:11pt; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none">
				<th width="150" >Build</th><th width="100%">Contents</th>
			</tr>
			<%
		   LoadProjectFiles(id)
			Dim myXML as System.Xml.XmlDocument
			myXML = New XmlDocument()
			myXML.preserveWhiteSpace = trUE
			myXML.loadXML(Builds)
			Dim Nodes As System.Xml.XmlNodeList = myXML.selectNodes("//Item[@type='CP_Builds']")
			Dim Node As System.Xml.XmlElement
			Dim BuildFiles As System.Xml.XmlNodeList
			Dim BuildFile As System.Xml.XmlElement
			Dim version as String = "?"
			Dim notes as String  = "na"
			Dim License as String  = "1"
			dim fid as String = ""
			Dim propNode As System.Xml.XmlElement
			Dim fileNode As System.Xml.XmlElement

			For Each Node in Nodes
				propNode = Node.selectSingleNode("version")
				if not propNode is Nothing Then version = propNode.innertext
				propNode = Node.selectSingleNode("notes")
				if not propNode is Nothing Then notes = propNode.innertext


			%>
				<tr valign="middle">
					<td align='center' style="font-size:11pt; font-weight:bold;"><%=version%></td>
					<td align='left'><%=notes%><br/>
					<!-- <hr width="100%" size='1' color="Gainsboro"/> -->
					<table border="0" cellpadding="0" cellspacing="2" width="100%" style="font-size:9pt;">
					<!-- <tr height="10" ><th align="left">Filename</th><th align="right">Size (bytes)</th></tr> -->
					<tr height="10"><td colspan="2"><table width="100%" style="font-size:9pt;" cellpadding="0" cellspacing="0" border="1"><tr><th align="left" width="80%">Filename</th><th align="right">Size (bytes)</th></tr></table></td></tr>
			<%
					'<tr><td colspan="2"><hr width="100% size="1" color="Gainsboro"/></td></tr>

						BuildFiles = Node.selectNodes("Relationships/Item")
						for each BuildFile in BuildFiles
							propNode = BuildFile.selectSingleNode("license_required")
							if not propNode is Nothing Then License = propNode.innertext

						    fileNode = BuildFile.selectSingleNode("related_id/Item")
							fid=fileNode.getAttribute("id")
							dim fname as string =""
							dim fsize as string = "0"
							propNode = fileNode.selectSingleNode("filename")
							if not propNode is Nothing Then fname = propNode.innertext
							propNode = fileNode.selectSingleNode("file_size")
							if not propNode is Nothing Then fsize = propNode.innertext
			%>
							<tr><td width="80%"><a href="Javascript:downloadFile('<%=fid%>','<%=License%>');"><%=fname%></a></td><td width="20%" align="right"><%=fsize%></td></tr>
			<%
						Next
			%>
					</table>
					</td>
				</tr>
			<%
			next
			%>
		</table>
  </body>
</html>
