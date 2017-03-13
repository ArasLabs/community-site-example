<%@ Page CodeBehind="AddReview.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="CommunityProjects.AddReview"  %>
<%
	Dim id as String=Request.QueryString("pid")
	Dim email as String=Request.QueryString("email")
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
    if (reviewform.review.value=="") {
        alert('Please enter you comments before Saving');
        return;
    }
	var DataToSend = "user="+reviewform.user.value+"&review="+reviewform.review.value+"&rating="+reviewform.rating.options[reviewform.rating.selectedIndex].value + "&project="+reviewform.project.value;
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.Open("POST","AddReviewSave.aspx",false);
	xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp.send(DataToSend);
	returnValue=true;
	window.close();
}
function doCancel() {
   returnValue=false;
   window.close();
}

</script>
</head>
<body MS_POSITIONING="GridLayout" >
<form action="AddReviewSave.aspx" method="post" id="reviewform" name="reviewform">
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr valign="middle">
	<td valign="middle"><b>Rating</b><br/></b><select id="rating" name="rating"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5"selected>5</option></select></td>
	<td colspan="2"><textarea id="review" name="review" cols="50" rows="8" wrap="soft"></textarea></td>
</tr>
<tr>
	<td>&nbsp;<input type="hidden" id="user" name="user" value="<%=email%>"><input type="hidden" id="project" name="project" value="<%=id%>"></td>
	<td align="center" width="50%"><input type="button" id="cancel" name="cancel" value="cancel" onclick="doCancel();"></td>
	<td align="center" width="50%"><input type="button" id="save" name="save" value="save" onclick="doSave();"></td>
</tr>
</table>
</form>
</body>
</html>
