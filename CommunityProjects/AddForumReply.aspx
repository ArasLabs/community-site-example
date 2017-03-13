<%@ Page CodeBehind="AddForumReply.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="CommunityProjects.AddForumReply"  %>
<%
	Dim fid as String=Request.QueryString("fid")
	Dim author as String=Request.QueryString("author")
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Login</title>
<meta name=vs_defaultClientScript content="JavaScript">
<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
<meta name=ProgId content=VisualStudio.HTML>
<meta name=Originator content="Microsoft Visual Studio .NET 7.1">
<script>
function doSave() {
    if (forumReplyform.message.value=="" ) {
        alert('Please enter your reply Text before Saving');
        return;
    }
	var DataToSend = "author="+forumReplyform.author.value+"&message="+forumReplyform.message.value+"&entry="+forumReplyform.entry.value;
	// alert(DataToSend);
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.Open("POST","AddForumReplySave.aspx",false);
	xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp.send(DataToSend);

	returnValue=true;
    window.close();
}
function doCancel() {
   returnValue=false;
   window.close();
}

function ResizeMe() {
   if (document.body.clientHeight > 160) forumReplyform.message.rows=(document.body.clientHeight-100)/14;
}
</script>
</head>
<body MS_POSITIONING="GridLayout" onResize="ResizeMe()" onload="ResizeMe();">
<form id="forumReplyform" name="forumReplyform">
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr valign="middle" height="100%">
	<td colspan="1"><b>Text:</b>&nbsp;</td>
	<td colspan="2"><textarea id="message" name="message" cols="57" rows="5" wrap="soft"></textarea></td>
</tr>
<tr height="50">
	<td>&nbsp;<input type="hidden" id="author" name="author" value="<%=author%>"><input type="hidden" id="entry" name="entry" value="<%=fid%>"></td>
	<td align="center" width="50%"><input type="button" id="cancel" name="cancel" value="cancel" onclick="doCancel();"></td>
	<td align="center" width="50%"><input type="button" id="save" name="save" value="save" onclick="doSave();"></td>
</tr>
</table>
</form>
</body>
</html>
