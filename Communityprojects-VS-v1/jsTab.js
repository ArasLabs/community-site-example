/*
Simple Tab Bar <c> Scand LLC, 1998-2005
*/

function jsTabBar(){
	this.activeTab=null;
	this.tabsAr=new Array(0);
	this.offsetLeft=5;
	this.obj=document.createElement("DIV");
	this.obj.id="tabs_winlike";

	this.obj.onclick=function(){
		if(event.srcElement.tagName == "SPAN")
			event.srcElement.tabbarRef.setTabActive(event)
	}


	this.obj.onselectstart=function(){
		event.returnValue=false;
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
		if(!inObj.srcElement)
			var obj=inObj.obj;
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
