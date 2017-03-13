<%@ Page CodeBehind="AddReview.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="CommunityProjects.AddReview" %>
<%
	Dim id as String=Request.QueryString("pid")
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
    if (forumEntryform.message.value=="" || forumEntryform.topic.value=="") {
        alert('Please enter you Topic and Text before Saving');
        return;
    }
    var DataToSend = "author="+forumEntryform.author.value+"&message="+forumEntryform.message.value+"&project="+forumEntryform.project.value+"&topic="+forumEntryform.topic.value;
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.Open("POST","AddForumEntrySave.aspx",false);
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
   if (document.body.clientHeight > 180) forumEntryform.message.rows=(document.body.clientHeight-130)/14;
}
</script>
</head>
<body MS_POSITIONING="GridLayout" onResize="ResizeMe()" onload="ResizeMe();">
<form  id="forumEntryform" name="forumEntryform">
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr valign="middle" height="50">
	<td colspan="1"><b>Topic:</b>&nbsp;</td>
	<td colspan="2"><input id="topic" name="topic" maxlength="64" size="74"></td>
</tr>
<tr valign="middle" height="100%">
	<td colspan="1"><b>Text:</b>&nbsp;</td>
	<td colspan="2"><textarea id="message" name="message" cols="57" rows="5" wrap="soft"></textarea></td>
</tr>
<tr height="50">
	<td>&nbsp;<input type="hidden" id="author" name="author" value="<%=author%>"><input type="hidden" id="project" name="project" value="<%=id%>"></td>
	<td align="center" width="50%"><input type="button" id="cancel" name="cancel" value="cancel" onclick="doCancel();"></td>
	<td align="center" width="50%"><input type="button" id="save" name="save" value="save" onclick="doSave();"></td>
</tr>
</table>
</form>
</body>
</html>
