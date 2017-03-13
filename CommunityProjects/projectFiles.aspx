<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<%@ Import namespace="System.Xml" %>
<%	
	Dim id as String=Request.QueryString("pid") 
	Dim name as String=Request.QueryString("name") 
	dim licenseName as String = Request.QueryString("license")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <title>projectOverview</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    
    <script>
    function downloadFile(fid,license) {
        if (top.project_type=='Exchange') {
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
			if (top.login=="" || (top.usertype!='Unlimited' && top.usertype!='Partner') ) {
				alert('File access limited to Aras Community Exchange members\nPlease contact info@aras.com for more information');
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
        window.open("FileDownload.aspx?fid=" + fid + "&pid=<%=id%>&name=<%=name%>")
    }
    </script>
  </HEAD>
  <body>
		<table border="1" bordercolor="SlateGrayLight" width="100%" cellpadding="0" cellspacing="0" style='FONT-SIZE:10pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none'>
			<tr bgcolor="Honeydew" style="FONT-SIZE:11pt; FONT-FAMILY:tahoma, arial, helvetica, sans-serif; TEXT-DECORATION:none">
				<th width="150" >Build</th><th width="100%">Contents</th>
			</tr>
			<%
		    LoadProjectFiles(id)
			Dim myXML as System.Xml.XmlDocument
			myXML = New XmlDocument()
			myXML.preserveWhiteSpace = TRUE
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
				<TR valign="middle">
					<TD align='center'><font style="FONT-SIZE:11pt;"><b><%=version%></b></font></TD>
					<TD align='left'><%=notes%><br>
					<!-- <hr width="100%" size='1' color="Gainsboro"/> -->
					<table border="0" cellpadding="0" cellspacing="2" width="100%" style="FONT-SIZE:9pt;">
					<!-- <tr height="10" ><th align="left">Filename</th><th align="right">Size (bytes)</th></tr> -->
					<tr height="10"><td colspan="2"><table width="100%" style="FONT-SIZE:9pt;" cellpadding="0" cellspacing="0" border="1"><tr><th align="left" width="80%">Filename</th><th align="right">Size (bytes)</th></tr></table></td></tr>
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
					</TD>
				</TR>
			<%
			next
			%>
		</table>
  </body>
</HTML>
