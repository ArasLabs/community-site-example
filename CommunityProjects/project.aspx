<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"  lang="en" >
<head>
<title>project</title>

<meta name="Description" content="Aras is the leader in delivering Microsoft Enterprise Open Source Solutions to address strategic business initiatives such as PLM new product introduction and APQP quality compliance." />
<link rel="stylesheet" type="text/css" href="http://www.aras.com/styles/aras.css" />
<link rel="stylesheet" type="text/css" href="jsTab.css" />
<%
	Dim id as String=Request.QueryString("pid")
	dim pname as String=" "
	dim description as String = " "
	dim licenseName as String = "Microsoft CL"
	dim download as String = "0"
	dim rating as String = "0"

	LoadProjectBrief(id)
	Dim myXML as System.Xml.XmlDocument
	myXML = New System.Xml.XmlDocument()
	myXML.preserveWhiteSpace = trUE
	myXML.loadXML(Projects)
	Dim Node As System.Xml.XmlElement = myXML.selectSingleNode("//Item[@id='" & id & "']")
	if not Node is Nothing then
		Dim propNode As System.Xml.XmlElement = Node.selectSingleNode("name")
		if not propNode is Nothing Then
			pname = propNode.innertext
		End If
		propNode = Node.selectSingleNode("description")
		if not propNode is Nothing Then
			description = propNode.innertext
		End If
		propNode = Node.selectSingleNode("download")
		if not propNode is Nothing Then
			download = propNode.innertext
		End If
		propNode = Node.selectSingleNode("rating")
		if not propNode is Nothing Then
			rating = propNode.innertext
		End If
		propNode = Node.selectSingleNode("license")
		if not propNode is Nothing Then
			licenseName = propNode.innertext
		End If
	End If
%>

<script language="JavaScript" type="text/JavaScript"   src="jsToolbar.js" ></script>

<script language="JavaScript" type="text/JavaScript">
var tabbar=null;
var currTabID="overview";

function jsTabBar(){
	this.activeTab=null;
	this.tabsAr=new Array(0);
	this.offsetLeft=5;
	this.obj=document.createElement("div");
	this.obj.id="tabs_winlike";

	this.obj.onclick=function(ev){
		 // first test for IE
		if(window.event) {  // ie
			if (window.event.srcElement.tagName == "SPAN") 	window.event.srcElement.tabbarRef.setTabActive(window.event)
			return;
		}  // now test for FoxFire
		if(ev.target.tagName == "SPAN") ev.target.tabbarRef.setTabActive(ev)
	}

	this.onselectstart=function(ev){
		ev.returnValue=false;
	}

	this.appendTo=function(parent){
		parent.appendChild(this.obj)
	}

	this.addTab=function(tab){
		this.obj.appendChild(tab.obj);
		if(tab.obj.previousSibling!=null){
			tab.obj.style.left=parseInt(tab.obj.previousSibling.style.left)+parseInt(tab.obj.previousSibling.style.width)
		} else {
			tab.obj.style.left=this.offsetLeft
		}
		tab.obj.tabbarRef=this;
		this.tabsAr[this.tabsAr.length]=tab;
	}


	this.getTabByIndex=function(ind){
		return this.tabsAr[ind]
	}

	this.setTabActive=function(inObj){
		if(inObj==null)
			return;
		if(!inObj.srcElement) {
			 if (inObj.target)
				 var obj=inObj.target;
			 else
				 var obj=inObj.obj;
			}
		else
			var obj=inObj.srcElement;

		if(obj.className!="active"){
			obj.className="active";
			obj.style.left=parseInt(obj.style.left)-2;
			obj.style.width=parseInt(obj.offsetWidth)+2;
			this.inact();
			this.activeTab=obj;
			this.doOnTabChange(obj)
		}
	}

	this.inact=function(){
		if(this.activeTab!=null){
			this.activeTab.className="inactive";
			this.activeTab.style.left=parseInt(this.activeTab.style.left)+2;
			this.activeTab.style.width=parseInt(this.activeTab.style.width)-2;
		}
	}

	this.doOnTabChange=function(obj){
	  // not doing anything
	}

}

function jsTab(id, label, width){
	this.obj=document.createElement("SPAN");
	this.obj.style.width=width;
	this.obj.id=id;
	this.obj.innerHTML=label;
	this.obj.className="inactive";
	this.getAllTabsRight=function(){
		var outAr=new Array();
		nTab=this.obj;
		while(nTab.nextSibling!=null){
			var nTab=nTab.nextSibling
			if (nTab.tagName && nTab.tagName=="SPAN"){
				outAr[outAr.length]=nTab;
			}
		}
		return outAr;
	}

	this.show=function(state){
		var tabsAr=this.getAllTabsRight(this.obj);
		if(this.obj.style.display=="none" && state==true){
			for(var i=0;i<tabsAr.length;i++){
				tabsAr[i].style.left=parseInt(tabsAr[i].style.left)+parseInt(this.obj.style.width);
			alert(tabsAr[i].style.left)
			}
		this.obj.style.display="";
	}

	if(this.obj.style.display!="none" && state==false){
		for(var i=0;i<tabsAr.length;i++){
			tabsAr[i].style.left=parseInt(tabsAr[i].style.left)-parseInt(this.obj.style.width);
		}
		this.obj.style.display="none";
		}
	}
}

function loadTabbar()  {
	if(tabbar!=null) return;
	if(!document.getElementById("tabbar_slot")) return;
	tabbar = new jsTabBar();

	tabbar.doOnTabChange = function(tabID){
		if (!tabID) return;
		if (currTabID == tabID.id) return;
		currTabID = tabID.id;
		var id="";
		var target = document.getElementById("content_frame");
		if (currTabID == "overview")	{
			target.src="projectOverview.aspx?pid=<%=id%>";
		}
		if (currTabID == "downloads")	{
			target.src="projectFiles.aspx?pid=<%=id%>&license=<%=licenseName%>&name=<%=pname%>";
		}
		if (currTabID == "reviews")	{
			target.src="projectReviews.aspx?pid=<%=id%>";
		}
		if (currTabID == "forums")	{
			target.src="projectForums.aspx?pid=<%=id%>";
		}
	}
	tabbar.addTab(new jsTab("overview","Overview","145"));
	tabbar.addTab(new jsTab("downloads" ,"Downloads","145"));
	tabbar.addTab(new jsTab("reviews","Reviews","145"));
	tabbar.addTab(new jsTab("forums","Forums","145"));
	tabbar.appendTo(document.getElementById("tabbar_slot"))
	tabbar.setTabActive(tabbar.getTabByIndex(0));
}

function mailLink() {
	try {
		var theApp = new ActiveXObject("Outlook.Application")

		var theMailItem = theApp.CreateItem(0) // value 0 = MailItem
		theMailItem.to = "";
		theMailItem.Subject = "Aras Community Projects: <%=pname%>";
		theMailItem.HTMLBody = "Here is a link to an interesting Aras Innovator community project<br/><br/><a href='http://www.aras.com/communityProjects?projectid=<%=id%>'>http://www.aras.com/communityProjects/default.aspx?projectid=<%=id%></a> <br/><br/>";


		// Now Open Outlook and display the email ready for editing and sending
		theMailItem.display()
	}
	catch (Excep)
	{
	alert('Internal Error: Can not connect to Outlook.  --> '+Excep.description);
	return;
	}
}
</script>
</head>
<body onLoad="loadTabbar();" >
<div style="overflow-x: hidden; overflow-y: hidden; margin-top: 0px; padding-right:0px; padding-left:0px; font-size:8pt; padding-bottom:0px; padding-top:0px; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none" >

<table border="0" width="95%" cellpadding="0" cellspacing="0" >
	<tr ><td align="left" style='font-size:14pt; font-family:tahoma, arial, helvetica, sans-serif; text-decoration:none'><%=pname%></td><td align="right" style="font-size:10pt;"><a href="javascript:mailLink()"><u>EMail this Page</u></a></td></tr>
	<tr height="31"><td align="left"  colspan="2"><div id="tabbar_slot" ></div></td></tr>
	<tr height="100%"><td colspan="2"><iframe id="content_frame" name="content_frame" width="100%" height="520" frameborder="0" src="projectOverview.aspx?pid=<%=id%>" ></iframe></td></tr>
</table>

</div>
</body>
</html>
