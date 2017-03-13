/*------------------------------------------------------------------------------
               Toolbar  object
--------------------------------------------------------------------------------*/
/**
  *     @desc: toolbar object
  *     @param: width - object width
  *     @param: height - object height
  *     @param: name - toolbar display name
  *     @type: public
  *     @topic: 0
  */
function jToolbarX(parentNode, width, height, name) {
  this.width=width;  this.height=height;
  this.xmlDoc=0;
  this.topNod=0;  this.dividerCell=0;  this.firstCell=0;  this.nameCell=0;  this.crossCell=0;
  this.items=new Array();  this.itemsCount=0;
  this.defaultAction=0;
  this.onShow=0;  this.onHide=0;
  this.oldMouseMove=0;
  this.buttonWidth=26;
  this.buttonHeight=22;
  this.bg_color="#D4D0C8";
  this.labels_are_visible = true;
  this.parentNode = parentNode;
  
  this.ouid = "jToolbarX$object$" + parentNode.uniqueID;//ouid - this object unique ID
  window[this.ouid] = this;
  
  this.create_self(name);
  
  this.xmlUnit = new xmlLoader();
  return this;
}

/**
  *     @desc: create object HTML
  *     @type: private
  *     @topic: 0
  */
jToolbarX.prototype.create_self = function jToolbarX_create_self( name ) {
  if(!this.width) this.width=1;  if(!this.height) this.height=1;
  var table=document.createElement("table");
  table.style.display="none";
  table.width=this.width;  table.height=this.height;
  table.className="toolbarTable";
  table.cellSpacing=1;  table.cellPadding=0;
  this.topNod=table;
  table.setAttribute("UNSELECTABLE", "on");
  table.onselectstart = this.generateHandler("badDummy");
  
  var tbody=document.createElement("tbody");
  var tr=document.createElement("tr");
  //handle
  var td=document.createElement("td");
  td.width="3px";
  td.innerHTML="<div class='toolbarHandle'>&nbsp;</div>";
  this.dividerCell=td;
  tr.appendChild(td);
  
  td=document.createElement("td");
  this.preNameCell=td;
  td.className="toolbarName";
  if (name) td.innerHTML=name;
  td.style.display="none";
  tr.appendChild(td);
  //main zone
  td=document.createElement("td");
  this.firstCell=td;
  tr.appendChild(td);
  //name zone
  td=document.createElement("td");
  this.nameCell=td;
  tr.appendChild(td);
  td.className="toolbarName"; td.align="right"; td.width="100%"; if (name) td.innerHTML=name;
  //end cross
  td=document.createElement("td");
  this.crossCell=td;
  tr.appendChild(td);
  
  tbody.appendChild(tr);
  table.appendChild(tbody);
  
  var div = document.createElement("<div style='overflow-x:hidden;'>");
  div.appendChild(table);
  this.parentNode.appendChild(div);
  
  div.style.setExpression("width", this.getFullMethodName("getWidthValue(document.body.offsetWidth)"));
  
  var c=document.createElement("<input type='text' id='inpf' style='position:absolute;height:0px;width:0px;'>");
  this.parentNode.appendChild(c);
}

/**
  *     @desc: load XML from file
  *     @type: public
  *     @param: file - file name
  *     @topic: 0,2
  */
jToolbarX.prototype.loadXML = function jToolbarX_loadXML(file) {
  this.xmlUnit.load(file, "parseXMLTree", this);
}

/**
  *     @desc: show toolbar
  *     @type: public
  *     @topic: 0,2
  */
jToolbarX.prototype.show = function jToolbarX_show() {
  this.topNod.style.display = "";
  if (this.onShow) this.onShow();
  this.checkScrollSize();
}

/**
  *     @desc: hide toolbar
  *     @type: public
  *     @topic: 0
  */
jToolbarX.prototype.hide = function jToolbarX_hide() {
  this.topNod.style.display = "none";
  if (this.onHide) this.onHide();
}

/**
  *     @desc: hide item
  *     @type: public
  *     @param: id - item id
  *     @topic: 0
  */
jToolbarX.prototype.hideItem = function jToolbarX_hideItem(id) {
  var z = this.getItem(id);
  if (z) {
    z.getTopNode().style.display="none";
    z.hide=1;
  }
}

/**
  *     @desc: show item
  *     @type: public
  *     @param: id - item id
  *     @topic: 0
  */
jToolbarX.prototype.showItem = function jToolbarX_showItem(id) {
  var z=this.getItem(id);
  if (z) {
    z.getTopNode().style.display="";
    z.hide=0;
  }
}

jToolbarX.prototype.getFullMethodName = function jToolbarX_getFullMethodName( fn ) {
  return "window." + this.ouid + "." + fn;
}

jToolbarX.prototype.generateHandler = function jToolbarX_generateHandler( fn ) {
  return (new Function( "return " + this.getFullMethodName(fn) + "();"));
}

jToolbarX.prototype.getDisplayValue = function jToolbarX_getDisplayValue( w ) {
  //w == document.body.offsetWidth
  var JS_toolbarTable = this.topNod;
  var res = (w < JS_toolbarTable.offsetWidth + JS_toolbarTable.parentElement.offsetParent.offsetLeft || this.tbScrollInt) ? "block" : "none";
  return res;
}

jToolbarX.prototype.getWidthValue = function jToolbarX_getWidthValue( w ) {
  //w == document.body.offsetWidth
  var JS_toolbarTable = this.topNod;
  var res = w - JS_toolbarTable.parentElement.offsetParent.offsetLeft-(this.scrollButtons && this.scrollButtons.style.display=="block" ? 30:0);
  return res;
}

jToolbarX.prototype.getId = function jToolbarX_getId() {
  return this.id;
}

jToolbarX.prototype.getBounds = function jToolbarX_getBounds() {
  var rect = new Object();
  rect.x = this.topNod.offsetLeft;
  rect.y = this.topNod.offsetTop;
  rect.width = this.topNod.width;
  rect.height =  this.topNod.height;
  return rect;
}

jToolbarX.prototype.checkScrollSize = function jToolbarX_checkScrollSize () {
  if (this.scrollButtons) return;
  
  this.tbScrollInt = null;
  
  var f_scrollRight = this.generateHandler("scrollRight");
  var f_scrollLeft  = this.generateHandler("scrollLeft");
  var f_scrollStop  = this.generateHandler("scrollStop");
  
  var sb = document.createElement("div");
  this.scrollButtons = sb;
  
  var b1 = document.createElement("button");
  b1.style.cssText="font:9pt System;";
  b1.innerText = "<";
  
  b1.onmousedown = f_scrollRight;
  b1.onmouseup = f_scrollStop;
  b1.onmouseout = f_scrollStop;
  sb.appendChild(b1);
  
  var b2 = document.createElement("button");
  b2.style.cssText="font:9pt System;";
  b2.innerText = ">";
  b2.onmousedown = f_scrollLeft;
  b2.onmouseup = f_scrollStop;
  b2.onmouseout = f_scrollStop;
  sb.appendChild(b2);
  
  this.parentNode.appendChild( sb );
  sb.style.cssText = "position:absolute;right:-1;height:100%;background-color:#D4D0C8;padding-left:7;padding-top:1;";
  sb.style.setExpression("top", "parentNode.offsetTop+1");
  sb.style.setExpression("display", this.getFullMethodName("getDisplayValue(document.body.offsetWidth)"));
}

jToolbarX.prototype.scrollLeft = function jToolbarX_scrollLeft() {
  this.scrollStop();
  this.tbScrollInt = setInterval( this.getFullMethodName("scrollMeL();"), 10);
}

jToolbarX.prototype.scrollRight = function() {
  this.scrollStop();
  this.tbScrollInt = setInterval( this.getFullMethodName("scrollMeR();"), 10);
}

jToolbarX.prototype.scrollStop = function jToolbarX_scrollStop() {
  if (this.tbScrollInt) {
    clearInterval(this.tbScrollInt);
    this.tbScrollInt = null;
  }
}

jToolbarX.prototype.scrollMeL = function jToolbarX_scrollMeL() {
  var tb = this.topNod;
  tb.parentElement.scrollLeft += 10;
}

jToolbarX.prototype.scrollMeR = function jToolbarX_scrollMeR() {
  var tb = this.topNod;
  tb.parentElement.scrollLeft -= 10;
}

jToolbarX.prototype.onClickNew = function jToolbarX_onClickNew(id) {
  window[this.parentNod.on_click](this);
}

/**
  *     @desc: parse xml
  *     @type: private
  *     @topic: 2
  */
jToolbarX.prototype.parseXMLTree = function jToolbarX_parseXMLTree(node) {
  var that = this;
  
  if (!node) {
    node=that.xmlUnit.getTopNode();
    if (node.tagName=="toolbarapplet") {
      that.buttonWidth=node.getAttribute("buttonsize").split(",")[0]||that.buttonWidth;
      that.buttonHeight=node.getAttribute("buttonsize").split(",")[1]||that.buttonHeight;
      that.on_load=node.getAttribute("on_load");
      that.on_click=node.getAttribute("on_click");
      that.setDefaultAction(that.onClickNew);
      that.on_menu_show=node.getAttribute("on_menu_show");
      that.on_menu_click=node.getAttribute("on_menu_click");
      that.labels_are_visible=node.getAttribute("showlabels")=="true";
      that.bg_color=node.getAttribute("bgcolor") || that.bg_color;
      that.topNod.parentElement.parentElement.style.backgroundColor=that.bg_color;
      that.top_border=node.getAttribute("top_border")=="1";
      if (that.top_border) that.topNod.parentElement.parentElement.style.borderTop="1px solid white";
    }
    node=node.childNodes(0);
  }
  
  var toolbarAlign=node.getAttribute("toolbarAlign");
  if (toolbarAlign) that.setAlign(toolbarAlign);
  
  var absolutePosition=node.getAttribute("absolutePosition");
  if (absolutePosition=="yes"){
    that.topNod.style.position="absolute";
    that.topNod.style.top=node.getAttribute("left")||0;
    that.topNod.style.left=node.getAttribute("top")||0;
  }
  
  if ((absolutePosition!="auto")&&(absolutePosition!="yes")) that.dividerCell.style.display="none";
  
  var name=node.getAttribute("name"); if(name) that.setTitle(name);
  
  that.id = node.getAttribute("id");
  
  var width=node.getAttribute("width");    var height=node.getAttribute("height");
  that.setSize(width,height);
  
  var imageTextButtonCssClass=node.getAttribute("imageTextButtonCssClass");
  var globalTextCss=node.getAttribute("globalTextCss");
  
  for (var i=0; i<node.childNodes.length; i++) {
    var localItem=node.childNodes[i];
    if (localItem.nodeType==1) {
      switch(localItem.tagName) {
        case "button":
        case "choice":
          var img = localItem.getAttribute("src")||localItem.getAttribute("image"); if (img!="") img=that.imagebase+img;
          var objectData=new Array(img,localItem.getAttribute("width")||that.buttonWidth,localItem.getAttribute("height")||that.buttonHeight,localItem.getAttribute("id"),localItem.getAttribute("imaction"),localItem.getAttribute("tooltip"),localItem.getAttribute("className")||imageTextButtonCssClass,localItem.getAttribute("disableImage"),localItem.getAttribute("textClassName")||globalTextCss,localItem.getAttribute("text")?localItem.getAttribute("text"):(localItem.childNodes[0]?localItem.childNodes[0].data:""));
          objectData[10]="";
          objectData[11]="";
          for (var j=0; j<localItem.childNodes.length; j++) {
            if (localItem.childNodes[j].tagName == "choiceitem") {
              objectData[10] += (j>0?",":"") + (localItem.childNodes[j].getAttribute("value")?localItem.childNodes[j].getAttribute("value"):localItem.childNodes[j].text);
              objectData[11] += (j>0?",":"") + localItem.childNodes[j].text;
            }
            else if ((localItem.childNodes[j].nodeType==1)&&(localItem.childNodes[j].tagName == "option")) {
              if (objectData[10]) objectData[10]+=","+localItem.childNodes[j].getAttribute("value");
              else objectData[10]=localItem.childNodes[j].getAttribute("value");
              if (localItem.childNodes[j].childNodes[0]) {
                if (objectData[11]) objectData[11]+=","+localItem.childNodes[j].childNodes[0].data;
                else objectData[11]=localItem.childNodes[j].childNodes[0].data;
              }
              else objectData[11]+=",";
            }
          }
          
          var TempNode=that.buttonObjectFactory(localItem.tagName,objectData);
          
          if (TempNode) {
            that.addItem(TempNode);
            if (that.labels_are_visible && TempNode.topNod.all(sc_tb_text)) TempNode.topNod.all(sc_tb_text).style.display="";
            if (localItem.getAttribute("disabled")=="true") TempNode.disable();
            if (localItem.getAttribute("state")==="0") TempNode.setState(false);
            if (localItem.getAttribute("state")==="1") TempNode.setState(true);
          }
          break;
        
        case "separator":
          var imid=localItem.getAttribute("id");
          that.addItem(new jToolbarDividerX(imid));
          break;
        
        case "edit":
          that.addItem(new jEditBoxX(localItem.getAttribute("id"), localItem.getAttribute("label"), localItem.getAttribute("text"), localItem.getAttribute("size")));
          break;
      }
    }
  }
  
  if (that.on_load) eval(that.on_load+"()");
}

/**
  *     @desc: create toolbar buttons
  *     @param: objectName - button name
  *     @param: dataList - array of data      
  *     @type: private
  *     @topic: 0
  */
jToolbarX.prototype.buttonObjectFactory = function jToolbarX_buttonObjectFactory(objectName,dataList) {
  switch(objectName) {
    case "button":
      try {
        var TempNode= new jImageTextButtonX(dataList[0],dataList[9],dataList[1],dataList[2],dataList[4],dataList[3],dataList[5],dataList[6],dataList[8],dataList[7]);
        return TempNode;
      } catch(e){};
      break;
    
    case "choice":
    //snn
//      try{
        var TempNode= new jScrollButtonX(dataList[3],dataList[10],dataList[11],dataList[4],dataList[1],dataList[2],dataList[6],dataList[9]);
        return TempNode;
//      } catch(e){};
      break;
  }
  
  return null;
}

jToolbarX.prototype.showToolbar = function jToolbarX_showToolbar(id) {
  var node = this.xmlUnit.getTopNode()
  if (!node) return;
  node = node.selectSingleNode('toolbar[@id="'+id+'"]');
  if (!node) return;
  
  this.removeToolbar();
  this.parseXMLTree(node);
  this.showLabels( this.labels_are_visible );
}

jToolbarX.prototype.removeToolbar = function jToolbarX_removeToolbar() {
  for (var i=this.itemsCount-1; i>=0;  i--) {
    this.removeItemById(this.items[i].id);
  }
}

/**
  *     @desc: remove item
  *     @type: public
  *     @param: id - item id
  *     @topic: 0
  */
jToolbarX.prototype.removeItemById = function jToolbarX_removeItemById(id) {
  var z=this.getItemIndex(id);
  if (z>=0) {
    if (this.items[z].removeItem) this.items[z].removeItem();
    this.firstCell.parentNode.removeChild(this.items[z].getTopNode());
    this.items[z]=0;
    this.itemsCount--;
    for (var i=z; i<this.itemsCount; i++) {
      this.items[i]=this.items[i+1];
    }
  }
}

jToolbarX.prototype.getActiveToolbar = function jToolbarX_getActiveToolbar() {
  return this;
}

jToolbarX.prototype.showLabels = function jToolbarX_showLabels(flag) {
  this.labels_are_visible = flag;
  var texts = document.all(sc_tb_text);
  if(texts) for(var i=0; i<texts.length; i++) texts[i].style.display=flag?"":"none";
}

jToolbarX.prototype.badDummy = function jToolbarX_badDummy() {
  if (event.srcElement.tagName != "INPUT") return false;
}

/**
  *     @desc: set action hadler on toolbar showing
  *     @param: fun - item object
  *     @type: public
  *     @topic: 0
  */
jToolbarX.prototype.setOnShow = function jToolbarX_setOnShow(fun) {
  this.onShow = fun;
}

/**
  *     @desc: set toolbar name
  *     @type: public
  *     @param: name - set name shown on toolbar
  *     @topic: 0
  */
jToolbarX.prototype.setTitle = function jToolbarX_setTitle(name) {
  this.nameCell.innerHTML=name;
  this.preNameCell.innerHTML=name;
}

jToolbarX.prototype.setImageBase = function jToolbarX_setImageBase(imagebase) {
  this.imagebase = imagebase;
}

/**
  *     @desc: set default action
  *     @type: public
  *     @param: action - set default action
  *     @topic: 0
  */
jToolbarX.prototype.setDefaultAction = function jToolbarX_setDefaultAction(action) {
  this.defaultAction=action;
}

/**  
  *     @desc: set toolbar size
  *     @type: public
  *     @param: w - width
  *     @param: h - height
  *     @topic: 0
  */
jToolbarX.prototype.setSize = function jToolbarX_setSize(w,h) {
  if(w) this.topNod.width=w;
  if(h) this.topNod.height=h;
};

/**  
  *     @desc: set action hadler on toolbar hiding
  *     @param: fun - item object
  *     @type: public
  *     @topic: 0
  */
jToolbarX.prototype.setOnHide = function jToolbarX_setOnHide(fun) {
  this.onHide=fun;
}

/**
  *     @desc: add item to toolbar
  *     @param: item - item object
  *     @param: position  - item position [not implemented]
  *     @type: public
  *     @topic: 0
  */
jToolbarX.prototype.addItem = function jToolbarX_addItem(item,position) {
  this.items[this.itemsCount]=item;
  this.firstCell.parentNode.insertBefore(item.getTopNode(),this.firstCell);
  item.parentNod=this;
  if (this.defaultAction) item.setAction(this.defaultAction);
  this.itemsCount++;
}

/**
  *     @desc: set item individual action
  *     @param: id - item identificator
  *     @param: action  - js function called onAction
  *     @type: public
  *     @topic: 0
  */
jToolbarX.prototype.setItemAction=function jToolbarX_setItemAction(id,action) {
  var z=this.getItemIndex(id);
  if (z>=0){
    this.items[z].setSecondAction(action);
  }
}

/**
  *     @desc: return item index in collection by position
  *     @type: private
  *     @param: pos - item position
  *     @topic: 0
  */
jToolbarX.prototype.getItemIndexByPosition = function jToolbarX_getItemIndexByPosition(pos) {
  var j=0;
  for (var i=0; i<this.itemsCount; i++) {
    if (this.items[i].hide!=1) j++;
    if (j==pos) return i;
  }
  return -1;
}

jToolbarX.prototype.getComponentCount = function jToolbarX_getComponentCount() {
  return this.itemsCount;
}

jToolbarX.prototype.getComponent = function jToolbarX_getComponent(i) {
  return this.items[i];
}

jToolbarX.prototype.disable = function jToolbarX_disable(){
  for (var i=0; i<this.itemsCount; i++) {
    if(this.items[i].disable) this.items[i].disable();
  }
}

jToolbarX.prototype.enable = function jToolbarX_enable() {
  for (var i=0; i<this.itemsCount; i++) {
    if(this.items[i].enable) this.items[i].enable();
  }
}

/**
  *     @desc: return item index in collection by id
  *     @type: private
  *     @param: id - item id
  *     @topic: 0
  */
jToolbarX.prototype.getItemIndex = function jToolbarX_getItemIndex(id) {
  for (var i=0; i<this.itemsCount; i++) {
    if (this.items[i].id==id) return i;
  };
  return -1;
}

/**
  *     @desc: return item by id
  *     @type: public
  *     @param: id - item id
  *     @topic: 0
  */
jToolbarX.prototype.getItem = function jToolbarX_getItem(id) {
  var z=this.getItemIndex(id);
  if (z>=0) return this.items[z];
}

jToolbarX.prototype.getElement = jToolbarX.prototype.getItem;

/**
  *     @desc: return item by position
  *     @type: public
  *     @param: id - item position
  *     @topic: 0
  */
jToolbarX.prototype.getItemByPosition = function jToolbarX_getItemByPosition(id) {
  var z=this.getItemIndexByPosition(id);
  if (z>=0) return this.items[z];
}
/*------------------------------------------------------------------------------
                End of Toolbar object
--------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
                HDivider object
--------------------------------------------------------------------------------*/
/**
  *     @desc: horisontal divider object
  *     @param: id - identificator
  *     @type: public
  *     @topic: 0
  */
function jToolbarDividerX(id) {
  this.topNod=0;
  if (id) this.id=id;
  else this.id=0;
  
  this.create_self();
  
  return this;
}

jToolbarDividerX.prototype.create_self = function jToolbarDividerX_create_self() {
  var td=document.createElement("td");
  this.topNod=td; td.align="center"; td.style.paddingRight="2"; td.style.paddingLeft="2"; td.width="4px";
  td.innerHTML="<div class='toolbarDivider'></div>";
}

jToolbarDividerX.prototype.getTopNode = function jToolbarDividerX_getTopNode() {
  return this.topNod;
}

jToolbarDividerX.prototype.setAction = function jToolbarDividerX_setAction(action) {
}

jToolbarDividerX.prototype.getBounds = function jToolbarDividerX_getBounds() {
  var rect = new Object();
  rect.x = this.topNod.offsetLeft;
  rect.y = this.topNod.offsetTop;
  rect.width = this.topNod.width;
  rect.height = this.topNod.height;
  return rect;
}

/*------------------------------------------------------------------------------
                End of hDivider object
--------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
                Edit box with label object
--------------------------------------------------------------------------------*/
function jEditBoxX(id, label, text, size) {
  this.topNod=0;
  this.action=0;
  this.persAction=0;
  this.className="defaultEditLabel";
  this.editClassName="defaultEditText";
  this.text=text||"";
  this.size=size||5;
  this.label=label||"";
  this.id=id||0;
  
  this.create_self();
  return this;
}

/**
  *     @desc: self creating
  *     @type: private
  *     @topic: 0
  */
jEditBoxX.prototype.create_self = function jEditBoxX_create_self() {
  var td = document.createElement("td");
  this.topNod=td;
  td.align="center";
  td.noWrap=true;
  td.innerHTML = 
    "<table width='100%' height='100%' cellpadding='0' cellspacing='0'>" +
      "<tr>" +
        "<td width='100%' style='padding-left:5px;padding-right:2px' align='left' class='"+this.className+"' nowrap>"+this.label+"</td>" +
        "<td><input id='"+sc_tb+this.id+"' type=text size="+this.size+" value='"+this.text+"'></td>" +
      "</tr>" +
    "</table>";
  td.className=this.className;
}

jEditBoxX.prototype.getTopNode = function jEditBoxX_getTopNode() {
  return this.topNod;
}

jEditBoxX.prototype.setAction = function jEditBoxX_setAction(action) {
}

jEditBoxX.prototype.setText = function jEditBoxX_setText(newText) {
  document.getElementById(sc_tb+this.id).value = newText==null?"":newText;
}

jEditBoxX.prototype.getText = function jEditBoxX_getText() {
  return document.getElementById(sc_tb+this.id).value;
}

jEditBoxX.prototype.setEnabled = function jEditBoxX_setEnabled(b) {
  document.getElementById(sc_tb+this.id).disabled = !b;
}

jEditBoxX.prototype.getBounds = function jEditBoxX_getBounds() {
  var rect = new Object();
  rect.x = this.topNod.offsetLeft;
  rect.y = this.topNod.offsetTop;
  rect.width = this.topNod.width;
  rect.height =  this.topNod.height;
  return rect;
}

/*------------------------------------------------------------------------------
                End of Edit box with label object
--------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
                Dropdown object
--------------------------------------------------------------------------------*/
/**
  *     @desc: dropdown object
  *     @param: id - identificator 
  *     @param: valueList - list of values 
  *     @param: displayList - list of display values
  *     @param: action - default action
  *     @param: width - object width
  *     @param: height - object height
  *     @param: className - css class
  *     @type: public
  *     @topic: 0  
  */
function jScrollButtonX (id,valueList,displayList,action,width,height,className,text) {
  this.topNod=0;
  this.action=0;
  this.persAction=0;
  this.selElement=0;
  this.className=className||"toolbarNormalButton";
  if (id) this.id=id; else this.id=0;
  
  this.ouid = "";//will be assigned later in create_self
  
  this.create_self( text, className, action, valueList, displayList  );
  return this;
}

jScrollButtonX.prototype.getTopNode = function jScrollButtonX_getTopNode() {
  return this.topNod;
}

/**
  *     @desc: disable object
  *     @type: public
  *     @topic: 0
  */
jScrollButtonX.prototype.disable = function jScrollButtonX_disable() {
  this.selElement.disabled = true;
}

/**
  *     @desc: enable object
  *     @type: public
  *     @topic: 0
  */
jScrollButtonX.prototype.enable = function jScrollButtonX_enable() {
  this.selElement.disabled = false;
}

jScrollButtonX.prototype.getBounds = function jScrollButtonX_getBounds() {
  var rect = new Object();
  rect.x = this.topNod.offsetLeft;
  rect.y = this.topNod.offsetTop;
  rect.width = this.topNod.width;
  rect.height =  this.topNod.height;
  return rect;
}

jScrollButtonX.prototype.getFullMethodName = function jScrollButtonX_getFullMethodName( fn ) {
  return "window." + this.ouid + "." + fn;
}

jScrollButtonX.prototype.generateHandler = function jScrollButtonX_generateHandler( fn ) {
  return (new Function( "return " + this.getFullMethodName(fn) + "();"));
}

/**
  *     @desc: self creating
  *     @type: private
  *     @topic: 0
  */
jScrollButtonX.prototype.create_self = function jScrollButtonX_create_self( text, className, action, valueList, displayList ) {
  var td=document.createElement("td");
  this.topNod=td;  td.align="center";
  td.noWrap=true;
  if (text) td.innerText=text;
  
  var sel=document.createElement("select");
  this.selElement=sel;
  
  this.ouid = "jScrollButtonX$object$" + td.uniqueID;//ouid - this object unique ID
  window[this.ouid] = this;
  
  sel.onchange = this.generateHandler("onclickX");
  //snn
  //sel.onchange=this.onclickX;
  if (className) sel.className=className;
  if (action) sel.style.height=height;
  var temp1=valueList.split(",");
  
  var temp2;
  if (displayList) temp2=displayList.split(",");
  else temp2=valueList.split(",");
  
  for (var i=0; i<temp1.length; i++) {
    sel.options[sel.options.length]=new Option(temp2[i],temp1[i]);
  }
  
  td.appendChild(sel);
  td.className="toolbarNormalButton";
}

/**
  *     @desc: set personal onSelect action (action must return false for preventing calling default action after personal), action function take one parametr - selected string value
  *     @type: public
  *     @topic: 0
  */
jScrollButtonX.prototype.setSecondAction = function jScrollButtonX_setSecondAction(action) {
  this.persAction=action;
}

/**
  *     @desc: inner onSelect handler
  *     @type: private
  *     @topic: 0
  */
jScrollButtonX.prototype.onclickX = function jScrollButtonX_onclickX() {
  //snn
  if ((!this.persAction)||(this.persAction(this.selElement.value)))
    if (this.action) {
      this.action(this.id,this.selElement.value);
    }
}

/**
  *     @desc: set default onSelect action
  *     @type: private
  *     @topic: 0
  */
jScrollButtonX.prototype.setAction = function jScrollButtonX_setAction(action) {
  this.action=action;
}

/**
  *     @desc: add string to dropdown
  *   @param: value - string value (sended to action function)
  *   @param: display - displayed string
  *     @type: public
  *     @topic: 0
  */
jScrollButtonX.prototype.addOption = function jScrollButtonX_addOption(value,display) {
  this.selElement.options[this.selElement.options.length]=new Option(display,value);
}

/**
  *     @desc: add string to dropdown
  *   @param: value - string value (sended to action function)
  *   @param: display - displayed string
  *     @type: public
  *     @topic: 0
  */
jScrollButtonX.prototype.add = function jScrollButtonX_add(value,display) {
  if (display == undefined) display = value;
  this.addOption(value,display);
}

jScrollButtonX.prototype.addItem = jScrollButtonX.prototype.add;

/**
  *     @desc: remove string from dropdown
  *   @param: value - string value 
  *     @type: public
  *     @topic: 0
  */
jScrollButtonX.prototype.removeOption = function jScrollButtonX_removeOption(value) {
  var z=this.getIndexByValue(value);
  if (z>=0) this.selElement.removeChild(this.selElement.options[z]);
}

/**
  *     @desc: remove all string from dropdown
  *     @type: public
  *     @topic: 0
  */
jScrollButtonX.prototype.removeAll = function jScrollButtonX_removeAll() {
  while (this.selElement.options.length)
    this.selElement.options.remove(this.selElement.options[0]);
}

/**
  *     @desc: change string value
  *   @param: oldValue - old string value
  *   @param: newValue - new string value
  *     @type: public
  *     @topic: 0
  */
jScrollButtonX.prototype.setOptionValue = function jScrollButtonX_setOptionValue(oldValue,newValue) {
  var z=this.getIndexByValue(value);
  if (z>=0) this.selElement.options[z].value=newValue;
}

/**
  *     @desc: change string text
  *   @param: oldValue - old string value 
  *   @param: newText - new string text
  *     @type: public
  *     @topic: 0
  */
jScrollButtonX.prototype.setOptionText = function jScrollButtonX_setOptionText(oldValue,newText) {
  var z=this.getIndexByValue(value);
  if (z>=0) this.selElement.options[z].text=newText;
}

/**
  *     @desc: select string by value
  *   @param: value - string value
  *     @type: public
  *     @topic: 0
  */
jScrollButtonX.prototype.setSelected = function(value) {
  var z=this.getIndexByValue(value);
  if (z>=0) this.selElement.options[z].selected=true;
}

/**
  *     @desc: return string index in dropdown by value (return -1 if string with given value not found)
  *   @param: value - string value
  *     @type: public
  *     @topic: 0
  */
jScrollButtonX.prototype.getIndexByValue = function jScrollButtonX_getIndexByValue(value) {
  for (var i=0; i<this.selElement.options.length; i++) {
    if (this.selElement.options[i].value==value) return i;
  }
  return -1;
}

jScrollButtonX.prototype.getItem = function jScrollButtonX_getItem(i) {
  return i>=0&&i<this.selElement.options.length ? this.selElement.options[i].value : null;
}

jScrollButtonX.prototype.getSelectedItem = function jScrollButtonX_getSelectedItem() {
  return this.getItem(this.selElement.selectedIndex);
}

jScrollButtonX.prototype.getSelectedIndex = function jScrollButtonX_getSelectedIndex() {
  return this.selElement.selectedIndex;
}

jScrollButtonX.prototype.getItemCount = function jScrollButtonX_getItemCount() {
  return this.selElement.options.length;
}
jScrollButtonX.prototype.remove = jScrollButtonX.prototype.removeOption;

jScrollButtonX.prototype.getId = function jScrollButtonX_getId() {
  return this.id;
}
jScrollButtonX.prototype.setEnabled = function jScrollButtonX_setEnabled(b) {
  if(b) this.enable(); else this.disable();
}

/*------------------------------------------------------------------------------
                End of Dropdown object
--------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
                Image button with text object
--------------------------------------------------------------------------------*/
/**
  *     @desc: image button with text object
  *     @param: src - image href
  *     @param: text - button text
  *     @param: width - object width
  *     @param: height - object height
  *     @param: action - default action
  *     @param: id - identificator
  *     @param: tooltip - image tooltip
  *     @param: className - css class for button (button use 3 css classes - [className],[className]Over,[className]Down)
  *     @param: textClassName - css class for text
  *     @param: disableImage - alter image for disable mode [optional]
  *     @type: public
  *     @topic: 0
  */ 
var sc_tb = "sc_tb_";
var sc_tb_text= sc_tb + "text";

function jImageTextButtonX(src,text,width,height,action,id,tooltip,className,textClassName,disableImage) {
  this.topNod=0;
  this.action=0;  this.persAction=0;
  this.className=className||"defaultButton";
  this.textClassName=textClassName||"defaultButtonText";
  this.src=src;  this.disableImage=disableImage;
  this.tooltip=tooltip||"";  this.id=id||0;
  
  this.ouid = "";//will be assigned later in create_self
  
  this.create_self( text, width, height );
  return this;
}

jImageTextButtonX.prototype = new ButtonPrototype();

jImageTextButtonX.prototype.getFullMethodName = function jImageTextButtonX_getFullMethodName( fn ) {
  return "window." + this.ouid + "." + fn;
}

jImageTextButtonX.prototype.generateHandler = function jImageTextButtonX_generateHandler( fn ) {
  return (new Function( "return " + this.getFullMethodName(fn) + "();"));
}

/**
  *     @desc: self creating
  *     @type: private
  *     @topic: 0
  */
jImageTextButtonX.prototype.create_self = function jImageTextButtonX_create_self( text, width, height ) {
  var td = document.createElement("td");

  this.ouid = "jImageTextButtonX$object$" + td.uniqueID;//ouid - this object unique ID
  window[this.ouid] = this;
  
  this.topNod=td; td.height=height; td.width=width; td.align="center";
  td.noWrap=true;
  td.innerHTML = 
    "<table width='100%' height='100%' cellpadding='0' cellspacing='0' title='"+this.tooltip+"'>" +
      "<tr>" +
        "<td align=center"+(this.src==""?" style='display:none'":"")+"><img src='"+this.src+"' border='0' style='padding-left:2px; padding-right:2px;'></td>" +
        "<td width='100%' style='"+(this.src==""?"":"display:none;")+"padding-left:5px;padding-right:2px' align='left' class='"+this.textClassName+"' nowrap id='"+sc_tb_text+(this.src==""||text==""?"_always":"")+"'>"+text+"</td>" +
      "</tr>" +
    "</table>";
  td.className=this.className;
  
  var f_dummy = new Function("");
  
  td.onmouseover_e = this.generateHandler("onmouseoverX");
  td.onmouseout_e  = this.generateHandler("onmouseoutX");
  td.onmousedown_e = this.generateHandler("onmousedownX");
  td.onmouseup_e   = this.generateHandler("onmouseupX");
  
  td.onmouseover_d = f_dummy;
  td.onmouseout_d  = f_dummy;
  td.onmousedown_d = f_dummy;
  td.onmouseup_d   = f_dummy;
  
  this.imageTag=td.childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0];
  
  this.enable();
}

jImageTextButtonX.prototype.getBounds = function jImageTextButtonX_getBounds() {
  var rect = new Object();
  rect.x = this.topNod.offsetLeft;
  rect.y = this.topNod.offsetTop;
  rect.width = this.topNod.width;
  rect.height = this.topNod.height;
  return rect;
}

/**
  *     @desc: set button text
  *     @param: newText - new text [ HTML allowed ]
  *     @type: public
  *     @topic: 0
  */
jImageTextButtonX.prototype.setText = function jImageTextButtonX_setText(newText) {
  this.topNod.childNodes[0].childNodes[0].childNodes[0].childNodes[1].innerHTML=newText;
}

/*------------------------------------------------------------------------------
                End of Image button with text object
--------------------------------------------------------------------------------*/

/**
  *     @desc: image button prototype
  *     @type: public
  *     @topic: 0
  */
function ButtonPrototype() {
  return this;
}

/**
  *     @desc: set default action
  *     @type: private
  *     @param: action - js action
  *     @topic: 0
  */
ButtonPrototype.prototype.setAction = function ButtonPrototype_setAction(action) {
  this.action=action;
}

ButtonPrototype.prototype.setState = function ButtonPrototype_setState(state) {
  this.state=state;
  this.updateClass('normal');
}

ButtonPrototype.prototype.setEnabled = function ButtonPrototype_setEnabled(flag) {
  this.isEnabled = flag;
  
  if(flag) this.enable();
  else this.disable();
}

/**
  *     @desc: set innerHTML of button
  *     @param: htmlTag - new HTML [danger]
  *     @type: public
  *     @topic: 0
  */
ButtonPrototype.prototype.setImageTag = function ButtonPrototype_setImageTag(htmlTag) {
  this.topNod.innerHTML = htmlTag;
}

/**
  *     @desc: set alt text of button image
  *     @type: public
  *     @param: imageText - new alt image text
  *     @topic: 0
  */
ButtonPrototype.prototype.setAltText = function ButtonPrototype_setAltText(imageText) {
  this.imageTag.alt = imageText;
}

/**
  *     @desc: set image href
  *     @type: public
  *     @param: imageSrc - new image href     
  *     @topic: 0
  */
ButtonPrototype.prototype.setImage = function ButtonPrototype_setImage(imageSrc) {
  this.src=imageSrc;
  this.topNod.childNodes[0].src=imageSrc;
}

ButtonPrototype.prototype.getId = function ButtonPrototype_getId() {
  return this.id;
}

ButtonPrototype.prototype.getState = function ButtonPrototype_getState() {
  return this.state;
}

ButtonPrototype.prototype.updateClass = function ButtonPrototype_updateClass(m) {
  var c='';
  if (m=='normal') {
    c='defaultButton';
    if (this.state==true) c='defaultButtonPushed';
  }
  else if (m=='over') {
    c='defaultButtonOver';
    if (this.state==true) c='defaultButtonPushedOver';
  }
  else if (m=='down') {
    c='defaultButtonDown';
    if (this.state==true) c='defaultButtonPushedOver';
  }
  
  this.topNod.className=c;
}

/**
  *     @desc: set personal onClick action (action must return false for preventing calling default action after personal), action function take one parametr - selected string value
  *     @type: public
  *     @topic: 0
  */
ButtonPrototype.prototype.setSecondAction = function ButtonPrototype_setSecondAction(action){
  this.persAction=action;
}

/**
  *     @desc: return HTML top node
  *     @type: private
  *     @topic: 0
  */
ButtonPrototype.prototype.getTopNode = function ButtonPrototype_getTopNode() {
  return this.topNod;
}

/**
  *     @desc: enable object
  *     @type: public
  *     @topic: 0  
  */
ButtonPrototype.prototype.enable = function ButtonPrototype_enable() {
  if (this.disableImage) this.imageTag.src=this.src;
  else {
    if (!this.className) this.topNod.className="toolbarNormalButton";
    else this.topNod.className=this.className;
  }
  
  var t = this.topNod;
  
  t.onmouseover = t.onmouseover_e;
  t.onmouseout  = t.onmouseout_e;
  t.onmousedown = t.onmousedown_e;
  t.onmouseup   = t.onmouseup_e;
  
  t = null;
  
  this.updateClass('normal');
}

/**
  *     @desc: disable object
  *     @type: public
  *     @topic: 0
  */
ButtonPrototype.prototype.disable = function ButtonPrototype_disable() {
  if (this.disableImage) this.imageTag.src=this.disableImage;
  else this.topNod.className="iconGray";
  
  var t = this.topNod;
  
  t.onmouseover = t.onmouseover_d;
  t.onmouseout  = t.onmouseout_d;
  t.onmousedown = t.onmousedown_d;
  t.onmouseup   = t.onmouseup_d;
  
  t = null;
}

/**
  *     @desc: onmouseover handler
  *     @type: private
  *     @topic: 0
  */
ButtonPrototype.prototype.onmouseoverX = function ButtonPrototype_onmouseoverX() {
  if (this.timerId) clearTimeout( this.timerId );
  this.updateClass("over");
  this.timerId = null;
  return true;
}

/**
  *     @desc: onmouseout handler
  *     @type: private
  *     @topic: 0
  */
ButtonPrototype.prototype.onmouseoutX = function ButtonPrototype_onmouseoutX() {
  this.timerId = setTimeout( this.getFullMethodName("buttonLost();"), 10);
  this.md=false;
  return true;
}

/**
  *     @desc: onmouseout handler with time delay
  *     @param: that - object
  *     @type: private
  *     @topic: 0
  */
ButtonPrototype.prototype.buttonLost = function ButtonPrototype_buttonLost(that) {
  this.updateClassIfAllowed('normal');
}

/**
  *     @desc: onmousedown handler
  *     @type: private
  *     @topic: 0
  */
ButtonPrototype.prototype.onmousedownX = function ButtonPrototype_onmousedownX() {
  this.parentNod.topNod.parentNode.parentNode.all("inpf").focus();
  this.updateClass('down');
  this.md=true;
  return true;
}

/**
  *     @desc: onmouseup handler
  *     @type: private
  *     @topic: 0
  */
ButtonPrototype.prototype.onmouseupX = function ButtonPrototype_onmouseupX() {
  this.updateClass('over');
  if (this.md) this.onclickX();
  this.md=false;
  return true;
}

/**
  *     @desc: inner onclick handler
  *     @type: private
  *     @topic: 0
  */
ButtonPrototype.prototype.onclickX = function ButtonPrototype_onclickX(e) {
  if (this.topNod.dstatus) return;
  
  if (this.state===false) this.setState(true);
  else if (this.state===true) this.setState(false);
  
  if ( (!this.persAction) || (this.persAction()) )
    if (this.action) {
      this.action(this.id);
    }
}

ButtonPrototype.prototype.updateClassIfAllowed = function ButtonPrototype_updateClassIfAllowed(clsNm) {
  if ( this.isEnabled === false ) return;
  this.updateClass(clsNm);
}

////////////////////////////////////common/////////////////////////////////////////
/**
  *     @desc: xmlLoader object
  *     @type: private
  *     @param: onloadAction - xml parser function
  *     @param: object - jsControl object
  *     @topic: 0
  */
function xmlLoader(onloadAction, object) {
  this.xmlDoc = null;
  return this;
}

/**
  *     @desc: return XML top node
  *     @type: private
  *     @topic: 0
  */
xmlLoader.prototype.getTopNode = function xmlLoader_getTopNode() {
  if (!this.xmlDoc) return null;
  
  return this.xmlDoc.documentElement;
}

/**
  *     @desc: load XML
  *     @type: private
  *     @param: file - xml file url
  *     @topic: 0
  */
xmlLoader.prototype.load = function xmlLoader_load(file, fn, on) {
  var a = new ActiveXObject("Microsoft.XMLDOM");
  this.xmlDoc = a;
  
  a.async = true;
  var self = this;
  
  a.onreadystatechange = function () {
    if (a.readyState != 4) return false;
    on[fn]( null );//call xml parser
    
    //null references
    a.onreadystatechange = new Function("return false;")
    on = null;
    a = null;
  }
  
  a.load(file);
}