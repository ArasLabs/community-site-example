<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<%@ Import namespace="System.Xml" %>
<%	Dim id as String=Request.QueryString("pid") %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <title>projectOverview</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    
    <script>
    
    function downloadFile(fid) {
        window.open("FileDownload.aspx?fid=" + fid + "&pid=<%=id%>")
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
			Dim Files As System.Xml.XmlNodeList
			Dim version as String = "?"
			Dim notes as String  = "na"
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
					<TD align='left'><b><%=notes%></b><br>
					<hr width="100%" size='1' color="Gainsboro"/>
					<table border="0" cellpadding="0" cellspacing="4" width="100%" style="FONT-SIZE:9pt;">
					<tr><th align="left">Filename</th><th>Size (bytes)</th></tr>
					<tr><td colspan="2"><hr width="100% size="1" color="Gainsboro"/></td></tr>
			<%
						Files = Node.selectNodes("Relationships/Item/related_id/Item")
						for each fileNode in Files
							fid=fileNode.getAttribute("id")
							dim fname as string =""
							dim fsize as string = "0"
							propNode = fileNode.selectSingleNode("filename")
							if not propNode is Nothing Then fname = propNode.innertext
							propNode = fileNode.selectSingleNode("file_size")
							if not propNode is Nothing Then fsize = propNode.innertext
			%>
							<tr><td width="80%"><a href="Javascript:downloadFile('<%=fid%>');"><%=fname%></a></td><td width="20%" align="right"><%=fsize%></td></tr>
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
