
/*****************************************
* rss
* Author: Edward Crichton
*****************************************/

function RSSChannel(rssURL)
{
	this.rssURL=rssURL;
	var ahah=new Ahah();

	var response=ahah.get(rssURL,[["Cache-Control","no-cache"],["Pragma", "no-cache"]]);
	
	var rssxml=null;
	
	if(!window.DOMParser)
	{
		rssxml=new ActiveXObject("Microsoft.XMLDOM");
		rssxml.async="false";
		rssxml.loadXML(response.responseText);
		rssxml=rssxml.documentElement;
	}
	else
	{
		rssxml=response.responseXML;
	}

	this.items=[];

	this.title="";
	
	if(rssxml)
	{
		var channelElement=rssxml.getElementsByTagName("channel");
		if(channelElement)
		{
			if((typeof channelElement[0])!="undefined")
			{
				var channelTitleElements=channelElement[0].getElementsByTagName("title");
				
				for(var i=0;i<channelTitleElements.length;i++)
				{
					var titleElement=channelTitleElements[i];
					
					if(titleElement.parentNode==channelElement[0])
					{
						if(titleElement.textContent){this.title=titleElement.textContent;}
						else if(titleElement.text){this.title=titleElement.text;}
						
						break;
					}
				}
			}
		}
		
		var itemElements = rssxml.getElementsByTagName("item");

		var itemFields=["title","description","pubDate","link","guid","dcterms:valid"];
		
		for (var i=0; i<itemElements.length; i++)
		{
			var item=itemElements[i];

			var itemObj={};
			
			for(var j=0;j<itemFields.length;j++)
			{
				itemObj[itemFields[j]]="";
				if(item.getElementsByTagName(itemFields[j]) && item.getElementsByTagName(itemFields[j])[0] && item.getElementsByTagName(itemFields[j])[0].textContent){itemObj[itemFields[j]]=item.getElementsByTagName(itemFields[j])[0].textContent;}
				else if(item.getElementsByTagName(itemFields[j]) && item.getElementsByTagName(itemFields[j])[0] && item.getElementsByTagName(itemFields[j])[0].text){itemObj[itemFields[j]]=item.getElementsByTagName(itemFields[j])[0].text;}
			}
			
			// yahoo weather
			if(item.getElementsByTagName("yweather:condition") && item.getElementsByTagName("yweather:condition").length)
			{
				var conditionElement=item.getElementsByTagName("yweather:condition")[0];
				if(conditionElement)
				{
					var conditionText=conditionElement.getAttribute("text");
					var conditionCode=conditionElement.getAttribute("code");
					var conditionTemp=conditionElement.getAttribute("temp");
					itemObj.condition=conditionText;
					itemObj.code=conditionCode;
					itemObj.temp=conditionTemp;
				}
			}
			
			/*
			itemObj.title="";
			if(item.getElementsByTagName("title")[0].textContent){itemObj.title=item.getElementsByTagName("title")[0].textContent;}
			else if(item.getElementsByTagName("title")[0].text){itemObj.title=item.getElementsByTagName("title")[0].text;}

			itemObj.link="";
			if(item.getElementsByTagName("link")[0].textContent){itemObj.link=item.getElementsByTagName("link")[0].textContent;}
			else if(item.getElementsByTagName("link")[0].text){itemObj.link=item.getElementsByTagName("link")[0].text;}

			itemObj.description="";
			if(item.getElementsByTagName("description")[0].textContent){itemObj.description=item.getElementsByTagName("description")[0].textContent;}
			else if(item.getElementsByTagName("description")[0].text){itemObj.description=item.getElementsByTagName("description")[0].text;}
			
			itemObj.pubDate="";
			if(item.getElementsByTagName("pubDate")[0].textContent){itemObj.description=item.getElementsByTagName("pubDate")[0].textContent;}
			else if(item.getElementsByTagName("pubDate")[0].text){itemObj.description=item.getElementsByTagName("pubDate")[0].text;}
			*/
			
			this.items.push(itemObj);
		}
	}
}

/*****************************************
* ahah
* Author: Edward Crichton
*****************************************/

// define the ahah class

function HTTPResponse()
{
	this.responseText=null;
	this.responseXML=null;

	this.statusText="Internal error: ahah nothing has happened.";
	this.status=501;
}

function Ahah()
{
	this.httpRequest=null;
	this.responseText=null;
	this.responseXML=null;
	this.statusText="Internal error: ahah nothing has happened.";
	this.status=501;
	this.gotXHR=false;

	if(!window.XMLHttpRequest) // || window.XDomainRequest
	{
		this.httpRequest=
		function()
		{
			//try{ return new XDomainRequest() }catch(e){}
	        try{ return new ActiveXObject("MSXML3.XMLHTTP") }catch(e){}
			try{ return new ActiveXObject("MSXML2.XMLHTTP.6.0") }catch(e){}
			try{ return new ActiveXObject("MSXML2.XMLHTTP.4.0") }catch(e){}
	        try{ return new ActiveXObject("MSXML2.XMLHTTP.3.0") }catch(e){}
	        try{ return new ActiveXObject("Msxml2.XMLHTTP") }catch(e){}
	        try{ return new ActiveXObject("Microsoft.XMLHTTP") }catch(e){}
			try{ return createRequest(); }catch(e){}
	        return null;
		}();
	}
	else
	{
		this.httpRequest=function()
		{
			try{ return new XMLHttpRequest(); }catch(e){}
			return null;
		}();
	}

	if(this.httpRequest==null)
	{
		this.status=501;
		this.statusText="Internal error: there is no XMLHttpRequest.";
	}
	else
	{
		this.gotXHR=true;
	}

	// for using the browser cache to store computed values
	this.fetchFromCache=[ ["Cache-Control","only-if-cached, max-age=86400, max-stale=86400"] ];
	this.fetchFromServer=[ ["Cache-Control","max-age=0"] ];
}

Ahah.prototype.toString=
function(){return "Ahah";};

Ahah.prototype.internalError=
function()
{
	this.status=501;
	this.statusText="Internal error: ahah not set up correctly.";
	this.responseText=null;
};

Ahah.prototype.getResponseHeader=
function(header)
{
	if(this.httpRequest)
	{
		return this.httpRequest.getResponseHeader(header);
	}
	return null;
};


Ahah.prototype.get=
function(url,headers,callback)
{
	return this.http("GET",url,"",headers,callback);
};

Ahah.prototype.post=
function(url,parameters,headers,callback)
{
	return this.http("POST",url,parameters,headers,callback);
};

function bind(obj,func,args)
{
	return function()
	{
		if(!args)
		{
			args=arguments;
		}
		return func.apply(obj, args);
	};
}

Ahah.prototype.http=
function(method,url,parameters,headers,callback)
{
	if(!this.httpRequest){this.internalError();return null;}

	var async=false;
	if(callback){async=true;}
	var response=new HTTPResponse();
	
	this.httpRequest.open(method,url,async);
	if(method=="POST")
	{
		this.httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	}
	
	if(headers)
	{
		var i;
		for(i=0;i<headers.length;i++)
		{
			this.httpRequest.setRequestHeader(headers[i][0],headers[i][1]);
		}
	}
	
	var ready=bind(this,
		function(response,callback)
		{
			this.status=this.httpRequest.status;
			this.statusText=this.httpRequest.statusText;
			this.responseText=this.httpRequest.responseText;
			try
			{
				this.responseXML=this.httpRequest.responseXML;
			}
			catch(e)
			{
			}

			response.status=this.status;
			response.statusText=this.statusText;
			response.responseText=this.responseText;
			response.responseXML=this.responseXML;

			if(callback){callback(response);}
		},
		[response,callback]);
	
	
	if(async)
	{
		this.httpRequest.onreadystatechange=bind(this.httpRequest,
		function(){if(this.readyState==4){ready();}},
		null);
	}
	
	this.httpRequest.send(parameters);
	
	if(!async){ready();}

	return response;
};

/*****************************************
* HtmlUpdater
* Author: Edward Crichton
*****************************************/

var HtmlUpdater={};

HtmlUpdater.toString=
function(){return "HtmlUpdater";}

HtmlUpdater.getElementById=
function(id,_document)
{
	if(!_document){_document=document;}

	if(_document.getElementById)
	{
		var el=_document.getElementById(id);
		if(el){return el;}
	}
	
	if(_document.layers)
	{
		var el=_document[id];
		if(el){return el;}
	}

	if(_document.all)
	{
		var el=_document.all[id];
		if(el){return el;}
	}
	
	return null;
}

HtmlUpdater.$=
function(element,_document)
{
	if(!element){return null;}
	
	if(element instanceof String || element.constructor == String)
	{
		element=HtmlUpdater.getElementById(element,_document);
		if(!element){return null;}
	}
	return element;
}

HtmlUpdater.set=
function(element,contents,_document)
{
	if(contents==null || typeof(contents)=="undefined")
	{
		contents="";
	}
	if(!element){return false;}
	
	element=HtmlUpdater.$(element,_document);
	if(!element){return false;}
	
	if(!_document){_document=document;}

	if(element.innerHTML)
	{
		element.innerHTML=contents;
	}
	else
	if(element.textContent)
	{
		element.textContent=contents;
	}
	else
	if(_document.createRange && element.appendChild)
	{
		try
		{
			var range=_document.createRange();
			range.selectNodeContents(element);
			range.deleteContents();
			var frag=range.createContextualFragment(contents);
			element.appendChild(frag);
		}
		catch(e)
		{
			element.innerHTML=contents;
		}
	}
	else
	{
		element.innerHTML=contents;
	}
	return true;
}

HtmlUpdater.setWithScript=
function(element,contents,_document)
{
	var scriptA=[];
	
	var appending=false;
	var at=0;
	for(;;)
	{
		if(at>=contents.length){break;}
		var scr=contents.indexOf("<script",at);
		if(scr==-1){break;}
		if(appending)
		{
			this.append(element,contents.substring(at,scr),_document);
		}
		else
		{
			this.set(element,contents.substring(at,scr),_document);
			appending=true;
		}
		var scre=contents.indexOf(">",scr+7);
		if(scre==-1){break;}
		var scriptTag=contents.substring(scr+7,scre);
		var defer=false;
		if(scriptTag.indexOf("defer")!=-1)
		{
			defer=true;
		}
		var ecr=contents.indexOf("</script",scre+1);
		if(ecr==-1){break;}
		if(defer)
		{
			scriptA.push("\n");
			scriptA.push(contents.substring(scre+1,ecr));
		}
		else
		{
			try
			{
				eval(contents.substring(scre+1,ecr));
			}
			catch(e)
			{
			}
		}
		at=ecr+9;
	}
	if(at<contents.length)
	{
		if(appending)
		{
			this.append(element,contents.substring(at),_document);
		}
		else
		{
			this.set(element,contents.substring(at),_document);
			appending=true;
		}
	}
	
	if(scriptA.length>0)
	{
		try
		{
			eval(scriptA.join(""));
		}
		catch(e)
		{
		}
	}
	delete scriptA;
}

HtmlUpdater.prepend=
function(element,contents,_document)
{
	if(!contents){return false;}
	if(!element){return false;}
	
	element=HtmlUpdater.$(element,_document);
	if(!element){return false;}

	if(!_document){_document=document;}

	if(_document.body && _document.body.innerHTML)
	{
		element.innerHTML=contents+element.innerHTML;
	}
	else
	if(element.innerHTML)
	{
		element.innerHTML=contents+element.innerHTML;
	}
	else
	if(_document.body && _document.body.textContent)
	{
		element.textContent=contents+element.textContent;
	}
	else
	if(element.textContent)
	{
		element.textContent=contents+element.textContent;
	}
	else
	if(_document.createRange)
	{
		var range=_document.createRange();
		range.selectNodeContents(element);
		var existingContents=range.toString();
		range.deleteContents();
		element.appendChild(range.createContextualFragment(contents+existingContents));
	}
	else
	{
		// not yet defined:
		element.innerHTML=contents;
	}
	return true;
}

HtmlUpdater.append=
function(element,contents,_document)
{
	if(!contents){return false;}
	if(!element){return false;}
	
	element=HtmlUpdater.$(element,_document);
	if(!element){return false;}

	if(!_document){_document=document;}

	if(_document.body.innerHTML)
	{
		element.innerHTML=element.innerHTML+contents;
	}
	else
	if(_document.body.textContent)
	{
		element.textContent=element.textContent+contents;
	}
	else
	if(_document.createRange)
	{
		var range=_document.createRange();
		range.selectNodeContents(element);
		var existingContents=range.toString();
		range.deleteContents();
		element.appendChild(range.createContextualFragment(existingContents+contents));
	}
	else
	{
		// not yet defined:
		element.innerHTML=contents;
	}
	return true;
}


/*****************************************
* news highlights from rss
*****************************************/

/*
* Take many channels and create a shuffled array of news items
*/
function unionNewsChannels(boxid,objArray)
{
	var newsBoxArray=[];

	for(var i=0;i<objArray.length;i++)
	{
		try
		{
			var newsBoxes=popNewsBox(objArray[i],boxid);
			newsBoxArray=newsBoxArray.concat(newsBoxes);
		}
		catch(e)
		{
		}
	}

	shuffle(newsBoxArray);

	return newsBoxArray;
}

function shuffle(objectArray)
{
	for(var i=objectArray.length-1;i>=0;i--)
	{
		var pick=Math.floor(Math.random()*(i+1));
		var t1=objectArray[i];
		var t2=objectArray[pick];
		if(typeof(t1.layout)!="undefined" && t1.layout=="grouped"){continue;}
		if(typeof(t2.layout)!="undefined" && t2.layout=="grouped"){continue;}
		objectArray[i]=t2;
		objectArray[pick]=t1;
	}
}

function popNewsBox(obj,boxid)
{
	if(typeof(obj.channel)=="undefined" || obj.channel==null)
	{
		return [];
	}

	if(obj.channel.items.length==0)
	{
		return [];
	}

	var layout=null;

	if(typeof(obj.layout)=="undefined" || obj.channel.items.length==1)
	{
		layout="indiviual";
	}
	else
	{
		layout=obj.layout;
	}

	var newsBoxes=[];

	for(i=0;i<obj.channel.items.length;i++)
	{
		var item=obj.channel.items[i];
		var max=230;
		var desc=item.description;

		var condense=new CondenseDescription();
		
		desc=condense.condense(desc);

		if(desc.length+item.title.length>max)
		{		
			var chop=max-item.title.length;
			if(chop<0){chop=max/2;}
		
			var stop=desc.indexOf('.',chop);
			if(stop<=0)
			{
				stop=desc.indexOf(' ',chop);
			}
			if(stop<=0)
			{
				stop=chop;
			}
			desc=desc.substring(0,stop)+" &hellip;";
		}
		
		var newsBoxObj=
		{
			categoryName: obj.categoryName,
			categoryId: obj.categoryId,
			title: item.title,
			link: item.link,
			description: desc,
			layout: layout,
			boxid: boxid,
			channel: obj.channel,
			linkToAll: obj.linkToAll
		};
		newsBoxes.push(newsBoxObj);
	}

	if(layout=="grouped")
	{
		var minus=[];
		var range=4;
		
		if((newsBoxes.length % 4)>1 || (newsBoxes.length % 4)==0)
		{
			range=4;
		}
		else
		if((newsBoxes.length % 3)>1 || (newsBoxes.length % 3)==0)
		{
			range=3;
		}
		else
		if((newsBoxes.length % 2)>1 || (newsBoxes.length % 2)==0)
		{
			range=2;
		}
		
		
		for(var i=0;i<newsBoxes.length;i++)
		{
			newsBoxes[i].grouping=[];
			minus.push(newsBoxes[i]);
			
			if(range>newsBoxes.length){range=newsBoxes.length;}
			
			for(var j=i;j<(i+range) && j<newsBoxes.length;j++)
			{
				newsBoxes[i].grouping.push(newsBoxes[j]);
				
			}
			i=i+range-1;
			
		}
		newsBoxes=minus;
	}
	
	return newsBoxes;
}

function transition(boxid)
{
	var one=HtmlUpdater.$(boxid+"-one");
	var two=HtmlUpdater.$(boxid+"-two");
	if(!one && !two){return;}
	
	//var previous=(one.style.zIndex==1?one:two);
	//var next=(one.style.zIndex==0?one:two);
	
	window.setTimeout(function(){fadeBetween(one,two,1);},90);
}

function fadeBetween(previous,next,opacity)
{
	if(opacity==0){return;}
	
	var acc=0.01+((1.0-opacity)/3);
	acc=Math.ceil(acc*100)/100;
	
	opacity=opacity-acc;
	
	if(opacity<=0)
	{
		opacity=0;
	}
	
	var inverse=1.0-opacity;
	
	opacity=Math.floor(opacity*100)/100;
	inverse=Math.floor(inverse*100)/100;
	
	try
	{
		previous.style.MozOpacity=opacity;
		next.style.MozOpacity=inverse;
	}
	catch(e)
	{
	}
	
	if(navigator.appName.indexOf("Microsoft")!=-1 && parseInt(navigator.appVersion)>=4)
	{
		try
		{
		previous.style.filter="alpha(opacity="+Math.ceil(opacity*100)+")";
		next.style.filter="alpha(opacity="+Math.ceil(inverse*100)+")";
		}
		catch(e)
		{
		}
	}
    
    	try
	{
	previous.style.opacity=opacity;
	next.style.opacity=inverse;
	}
	catch(e)
	{
	}
	
	if(opacity==0)
	{
		previous.style.zIndex=0;
		next.style.zIndex=1;
		return;
	}
	
	window.setTimeout(function(){fadeBetween(previous,next,opacity);},50);
}


function nextNewsBox(newsBoxArray)
{
	if(newsBoxArray.length==0){return;}
	
	var firstTime=false;
	if(typeof(newsBoxArray.itemAt)=="undefined")
	{
		newsBoxArray.itemAt=Math.floor(Math.random()*newsBoxArray.length+1);
		firstTime=true;
	}
	
	if(newsBoxArray.itemAt>=newsBoxArray.length){newsBoxArray.itemAt=0;}
	
	var newsBoxObjOne=newsBoxArray[newsBoxArray.itemAt];
	var newsBoxObjTwo=newsBoxArray[(newsBoxArray.itemAt+1) % newsBoxArray.length];
	
	newsBoxArray.itemAt=newsBoxArray.itemAt+1;
	
	var box1=getNewsBoxContents(
		newsBoxObjOne.categoryName,
		newsBoxObjOne.categoryId,
		newsBoxObjOne.title,
		newsBoxObjOne.link,
		newsBoxObjOne.description,
		newsBoxObjOne.boxid+"-one",
		newsBoxObjOne.layout,
		newsBoxObjOne.grouping,
		newsBoxObjOne.linkToAll,
		"1",
		"1",
		"284px"
		);
		
	var box2=getNewsBoxContents(
		newsBoxObjTwo.categoryName,
		newsBoxObjTwo.categoryId,
		newsBoxObjTwo.title,
		newsBoxObjTwo.link,
		newsBoxObjTwo.description,
		newsBoxObjTwo.boxid+"-two",
		newsBoxObjTwo.layout,
		newsBoxObjTwo.grouping,
		newsBoxObjTwo.linkToAll,
		"0",
		"0",
		"284px"
		);
		
	if(firstTime)
	{
		box1=getNewsBoxContents(
		newsBoxObjTwo.categoryName,
		newsBoxObjTwo.categoryId,
		newsBoxObjTwo.title,
		newsBoxObjTwo.link,
		newsBoxObjTwo.description,
		newsBoxObjTwo.boxid+"-one",
		newsBoxObjTwo.layout,
		newsBoxObjTwo.grouping,
		newsBoxObjTwo.linkToAll,
		"1",
		"1",
		"284px"
		);
	}
		
	var box=HtmlUpdater.$(newsBoxObjOne.boxid);
	box.style.position="relative";
	box.style.height="184px";
	HtmlUpdater.set(box,box1+box2);
	
	if(!firstTime){transition(newsBoxObjOne.boxid);}
}

function getNewsBoxContents(categoryName,categoryId,title,link,description, id, layout, grouping, linkToAll,zindex,opacity,height)
{
	var boxContents="<div id=\""+id+"\" style=\"width: 100%; height: "+height+";z-index: "+zindex+";  position: absolute;  opacity: "+opacity+"; filter: alpha(opacity="+Math.ceil(opacity*100)+")\"><h2 id=\""+categoryId+"\">";
	if(linkToAll)
	{
		boxContents+="<a href=\""+linkToAll+"\">";
	}
	boxContents+=categoryName;
	if(linkToAll)
	{
		boxContents+="</a>";
	}
	boxContents+="</h2>";
    
	if(layout=="grouped" && grouping!=null && grouping.length>1)
	{
		for(var g=0;g<grouping.length;g++)
		{
			var groupedNews=grouping[g];
			boxContents+="<a href=\""+groupedNews.link+"\">";
			boxContents+="<span class=\"headline\">"+groupedNews.title+"</span>";
		    boxContents+="</a>";
		}
	}
	else
	{
		boxContents+="<a href=\""+link+"\">";
		boxContents+="<span class=\"headline\">"+title+"</span>";
	    boxContents+="</a>";
	    boxContents+="<div class=\"summary\" style=\"max-height: 120px; height: 120px; overflow: hidden\">"+description+"</div>";
	    boxContents+="<a href=\""+link+"\">";
	    boxContents+="<span class=\"readmore\" style=\"position: absolute; bottom: 0px; background-color: #F2F9FF; width: 97%\">more details&hellip;</span>";
		boxContents+="</a>";
	}
	boxContents+="</div>";
	return boxContents;
}

var numberNames=["none","one","two","three","four","five","six","seven","eight","nine","ten","eleven","twelve","thirteen","fourteen","fifteen","sixteen","seventeen","eighteen","nineteen","twenty"];

function newsSummary(newsChannelArray,column,id,categoryName,rssArray)
{
	if(newsChannelArray.length==0){return;}
	
	var rssLinks="";
	
	if(rssArray)
	{
		for(var i=0;i<rssArray.length;i++)
		{
			var rssLink=rssArray[i];
			rssLinks+="<a title=\""+rssLink.title+"\" style=\"text-decoration: none\" href=\""+rssLink.rssURL+"\"><img src=\"/images/rss.gif\"/>&#160;<span style=\"text-decoration: underline\">"+rssLink.title+"</span></a>";
			if(i+1<rssArray.length){rssLinks+="&#160;";}
		}
	}
	
	var description="";
	
	for(var i=0;i<newsChannelArray.length;i++)
	{
		if(i==0)
		{
			description+="There ";
			if(number==1)
			{
				description+="is ";
			}
			else
			{
				description+="are ";
			}
		}
		else
		{
			description+=" and ";
		}
		
		var channel=newsChannelArray[i];
		
		var number=channel.channel.items.length;
		var link=channel.linkToAll;
		
		if(number==1)
		{
			description+="<a href=\""+link+"\">"+numberNames[1]+" "+channel.channelType.single+"</a>";
		}
		else
		{
			description+="<a href=\""+link+"\">"+numberNames[number]+" "+channel.channelType.plural+"</a>";
		}
	}
	
	var boxContents="";
	boxContents+="<div class=\"newsBoxHeading\">";
	boxContents+="<span class=\"newsBoxHeadingText\">"+categoryName+"</span>";
	boxContents+="</div>";
	boxContents+="<div class=\"newsBoxHeadline\">";
	boxContents+=" </div>";
	boxContents+="<div class=\"newsBoxSummary\">"+description+".</div>";
	
	if(rssLinks)
	{
		boxContents+="<div class=\"newsBoxRSS\">"+rssLinks+"</div>";
	}
	
	HtmlUpdater.set(id,boxContents);
}


function nextNewsBox2(newsBoxArray,column,rssArray)
{
	if(newsBoxArray.length==0){return;}
	
	var firstTime=false;
	if(typeof(newsBoxArray.itemAt)=="undefined")
	{
		newsBoxArray.itemAt=Math.floor(Math.random()*newsBoxArray.length+1);
		firstTime=true;
	}
	
	if(newsBoxArray.itemAt>=newsBoxArray.length){newsBoxArray.itemAt=0;}
	
	var newsBoxObjOne=newsBoxArray[newsBoxArray.itemAt];
	var newsBoxObjTwo=newsBoxArray[(newsBoxArray.itemAt+1) % newsBoxArray.length];
	
	newsBoxArray.itemAt=newsBoxArray.itemAt+1;
	
	var rssLinks="";
	
	if(rssArray)
	{
		for(var i=0;i<rssArray.length;i++)
		{
			var rssLink=rssArray[i];
			rssLinks+="<a title=\""+rssLink.title+"\" style=\"text-decoration: none\" href=\""+rssLink.rssURL+"\"><img src=\"/images/rss.gif\"/>&#160;<span style=\"text-decoration: underline\">"+rssLink.title+"</span></a>";
			if(i+1<rssArray.length){rssLinks+="&#160;";}
		}
	}
	
	var box1=getNewsBoxContents2(
		newsBoxObjOne.categoryName,
		newsBoxObjOne.categoryId,
		newsBoxObjOne.title,
		newsBoxObjOne.link,
		newsBoxObjOne.description,
		newsBoxObjOne.boxid+"-one",
		newsBoxObjOne.layout,
		newsBoxObjOne.grouping,
		newsBoxObjOne.linkToAll,
		"1",
		"1",
		rssLinks,
		column
		);
		
	var box2=getNewsBoxContents2(
		newsBoxObjTwo.categoryName,
		newsBoxObjTwo.categoryId,
		newsBoxObjTwo.title,
		newsBoxObjTwo.link,
		newsBoxObjTwo.description,
		newsBoxObjTwo.boxid+"-two",
		newsBoxObjTwo.layout,
		newsBoxObjTwo.grouping,
		newsBoxObjTwo.linkToAll,
		"0",
		"0",
		rssLinks,
		column
		);
		
	if(firstTime)
	{
		box1=getNewsBoxContents2(
		newsBoxObjTwo.categoryName,
		newsBoxObjTwo.categoryId,
		newsBoxObjTwo.title,
		newsBoxObjTwo.link,
		newsBoxObjTwo.description,
		newsBoxObjTwo.boxid+"-one",
		newsBoxObjTwo.layout,
		newsBoxObjTwo.grouping,
		newsBoxObjTwo.linkToAll,
		"1",
		"1",
		rssLinks,
		column
		);
	}
		
	var box=HtmlUpdater.$(newsBoxObjOne.boxid);
	
	HtmlUpdater.set(box,box1+box2);
	
	if(!firstTime){transition(newsBoxObjOne.boxid);}
}

function getNewsBoxContents2(categoryName,categoryId,title,link,description, id, layout, grouping, linkToAll,zindex,opacity,rssLinks,column)
{
	var boxContents="<div class=\"newsBox\" id=\""+id+"\" style=\"z-index: "+zindex+"; position: absolute; opacity: "+opacity+"; filter: alpha(opacity="+Math.ceil(opacity*100)+")\">";
	boxContents+="<div class=\"newsBoxHeading\">";
	if(linkToAll)
	{
		boxContents+="<a href=\""+linkToAll+"\" class=\"newsBoxHeadingText\">"+categoryName+"</a>";
	}
	else
	{
		boxContents+="<span class=\"newsBoxHeadingText\">"+categoryName+"</span>";
	}
	boxContents+="</div>"
	
	if(layout=="grouped" && grouping!=null && grouping.length>1)
	{
	
		for(var g=0;g<grouping.length;g++)
		{
			var groupedNews=grouping[g];
			boxContents+="<a href=\""+groupedNews.link+"\">";
			boxContents+="<span class=\"headline\">"+groupedNews.title+"</span>";
		    boxContents+="</a>";
		}
	}
	else
	{
		boxContents+="<div class=\"newsBoxHeadline\">";
		boxContents+="<a href=\""+link+"\">";
		boxContents+="<span>"+title+"</span>";
	    boxContents+="</a>";
		boxContents+="</div>";
		
		
		
	    boxContents+="<div class=\"newsBoxSummary\">"+description+"</div>";
		
		boxContents+="<div class=\"newsBoxMoreDetails\">";
		
		boxContents+="<a href=\""+link+"\">";
		boxContents+="more details&hellip;";
	    boxContents+="</a>";
		
		boxContents+="</div>";
		
	}
	if(rssLinks)
	{
		boxContents+="<div class=\"newsBoxRSS\">"+rssLinks+"</div>";
	}
	boxContents+="</div>";
	return boxContents;
}

/* previous news functions */
function newsBox(categoryName,categoryId,title,link,description, boxid, layout, grouping, linkToAll)
{
	var box=HtmlUpdater.$(boxid);
	var boxContents="<div><h2 id=\""+categoryId+"\">";
	if(linkToAll)
	{
		boxContents+="<a href=\""+linkToAll+"\">";
	}
	boxContents+=categoryName;
	if(linkToAll)
	{
		boxContents+="</a>";
	}
	boxContents+="</h2>";
    
	if(layout=="grouped" && grouping!=null && grouping.length>1)
	{
		for(var g=0;g<grouping.length;g++)
		{
			var groupedNews=grouping[g];
			boxContents+="<a href=\""+groupedNews.link+"\">";
			boxContents+="<span class=\"headline\">"+groupedNews.title+"</span>";
		    boxContents+="</a>";
		}
	}
	else
	{
		boxContents+="<a href=\""+link+"\">";
		boxContents+="<span class=\"headline\">"+title+"</span>";
	    boxContents+="</a>";
	    boxContents+="<div class=\"summary\" style=\"max-height: 120px; height: 120px; overflow: hidden\">"+description+"</div>";
	    boxContents+="<a href=\""+link+"\">";
	    boxContents+="<span class=\"readmore\">more details&hellip;</span>";
		boxContents+="</a>";
	}
	boxContents+="</div>";
	HtmlUpdater.set(box,boxContents);
} 


function nextNews(objArray)
{
	for(var i=0;i<objArray.length;i++)
	{
		try
		{
			nextNewsItem(objArray[i]);
		}
		catch(e)
		{
		}
	}
}

function nextNewsItem(obj)
{
	if(obj.length)
	{
		var arr=obj;
		if(typeof(arr.itemAt)=="undefined")
		{
			arr.itemAt=0;
		}
		for(;;)
		{
			if(arr.itemAt>=arr.length)
			{
				arr.itemAt=0;
			}

			var actualObj=arr[arr.itemAt];
			arr.itemAt++;
			
			if(nextNewsItem(actualObj)){return true;}
			
			if(arr.itemAt>=arr.length)
			{
				arr.itemAt=0;
				return false;
			}
		}
	}

	if(typeof(obj.channel)=="undefined" || obj.channel==null)
	{
		return false;
	}

	if(obj.channel.items.length==0)
	{
		return false;
	}

	
	if(obj.itemAt<0)
	{
		obj.itemAt=Math.floor(Math.random()*obj.channel.items.length+1);
	}
	if(obj.itemAt>=obj.channel.items.length){obj.itemAt=0;}
	var item=obj.channel.items[obj.itemAt];
	obj.itemAt=obj.itemAt+1;

	var max=230;
	var desc=item.description;

	var condense=new CondenseDescription();
	
	desc=condense.condense(desc);

	if(desc.length+item.title.length>max)
	{		
		var chop=max-item.title.length;
		if(chop<0){chop=max/2;}
	
		var stop=desc.indexOf('.',chop);
		if(stop<=0)
		{
			stop=desc.indexOf(' ',chop);
		}
		if(stop<=0)
		{
			stop=chop;
		}
		desc=desc.substring(0,stop)+" &hellip;";
	}
	
	newsBox(obj.categoryName,obj.categoryId,item.title,item.link,desc,obj.boxid);

	return true;
}

/*****************************************
* CondenseDescription
*****************************************/

function CondenseDescription(){}

CondenseDescription.prototype.createHoldingDiv=
function()
{
	if(typeof(tempHoldingDiv)=="undefined")
	{
		tempHoldingDiv=document.createElement('div');
		tempHoldingDiv.style.position='absolute';
		tempHoldingDiv.style.zindex='1000';
		tempHoldingDiv.style.top='-1000';
	}
	
	return tempHoldingDiv;
}

CondenseDescription.prototype.chopMedia=
function(html)
{
	// even though the contents div is not being attached
	// to the document dom tree, images and other media
	// are being loaded by the browsers.
	
	try
	{
	
	var toChop1=["<img","<link","<meta"];
	
	chopping1:
	for(var i=0;i<toChop1.length;i++)
	{
		var at=0;
		for(;;)
		{
			var tag=html.indexOf(toChop1[i],at);
			if(tag==-1){tag=html.indexOf(toChop1[i].toUpperCase());}
			if(tag==-1){continue chopping1;}
			var gt=html.indexOf(">",tag);
			if(gt==-1){at=tag+toChop1[i].length;continue;}
			html=html.substring(0,tag)+html.substring(gt+1);
			at=tag;
			continue;
		}
	}
	var toChop2=["<object","<embed","<iframe","<script","<noscript","<head"];
	
	chopping2:
	for(var i=0;i<toChop2.length;i++)
	{
		var at=0;
		for(;;)
		{
			var tag=html.indexOf(toChop2[i],at);
			if(tag==-1){tag=html.indexOf(toChop2[i].toUpperCase());}
			if(tag==-1){continue chopping2;}
			
			var gt=html.indexOf(">",tag);
			if(gt==-1){at=tag+toChop2[i].length;continue;}
			var slashQ=html.charAt(gt-1);
			if(slashQ=='/')
			{
				html=html.substring(0,tag)+html.substring(gt+1);
				at=tag;
				continue;
			}
			
			var endToChop="</"+toChop2[i].substring(1);
			var endtag=html.indexOf(endToChop,gt+1);
			if(endtag==-1){endtag=html.indexOf(endToChop.toUpperCase(),gt+1);}
			if(endtag==-1){at=gt+1;continue;}
			var endgt=html.indexOf(">",endtag);
			if(endgt==-1){at=gt+1;continue;}
			html=html.substring(0,tag)+html.substring(endgt+1);
			at=tag;
			continue;
		}
	}
	}
	catch(e)
	{
	}
	finally
	{
	}
	return html;
}

CondenseDescription.prototype.condense=
function(html)
{
	if(html==null){return "";}
	
	// put the contents into a div
	var node=this.createHoldingDiv();
	
	// remove media before setting the div contents
	var choppedHtml=this.chopMedia(html);
	
	HtmlUpdater.set(node,choppedHtml);
	
	// use the dom tree to pull out a formatted
	// version of the text.
	var string="";
	var children=node.childNodes;
	var n=children.length;
	for(var i=0;i<n;i++)
	{
		string=string+this.docondense(children[i]);
	}

	return string;
}

var ELEMENT_NODE=1, ATTRIBUTE_NODE=2, TEXT_NODE=3, DOCUMENT_NODE=9;

CondenseDescription.prototype.docondense=
function(node)
{
	var string="";
	if(!node){return string;}

	if(node.nodeType==ELEMENT_NODE)
	{
		var tagName=node.tagName;
		if(this.shouldOutputTag(node))
		{
			string=string+"<"+tagName;
			// do attributes here
			var attributes=node.attributes;
			if(attributes)
			{
				var n=attributes.length;
				for(var k=0;k<n;k++)
				{
					if(attributes[k].specified)
					{
						string=string+" "+attributes[k].nodeName+"=\""+attributes[k].nodeValue+"\"";
					}
				}
			}
			string=string+">";
		}
		if(this.shouldRecurseTag(node))
		{
			var children=node.childNodes;
			var n=children.length;
			for(var i=0;i<n;i++)
			{
				string=string+this.docondense(children[i]);
			}
		}
		if(this.shouldOutputTag(node))
		{
			string=string+"</"+tagName+">";
		}
	}
	else
	if(node.nodeValue)
	{
		string=string+node.nodeValue;
	}

	return string;
}
	
CondenseDescription.prototype.shouldOutputTag=
function(node)
{
	if(!node){return 0;}
	if(node.nodeType!=1){return 0;}
	if(
	node.tagName=="H1" ||
	node.tagName=="H2" ||
	node.tagName=="H3" ||
	node.tagName=="UL" ||
	node.tagName=="OL" ||
	node.tagName=="LI" ||
	node.tagName=="I" ||
	node.tagName=="B" ||
	node.tagName=="U" ||
	node.tagName=="SPAN" ||
	node.tagName=="EM" ||
	node.tagName=="STRONG" ||
	node.tagName=="DFN" ||
	node.tagName=="CODE" ||
	node.tagName=="SAMP" ||
	node.tagName=="KBD" ||
	node.tagName=="VAR" ||
	node.tagName=="CITE" ||
	node.tagName=="PRE" ||
	node.tagName=="ADDRESS" ||
	node.tagName=="BLOCKQUOTE"
	)
	{
		return 1;
	}
	return 0;
}

CondenseDescription.prototype.shouldRecurseTag=
function(node)
{
	if(!node){return 0;}
	if(node.nodeType!=1){return 0;}
	if(
	node.tagName=="OBJECT" ||
	node.tagName=="EMBED" ||
	node.tagName=="SCRIPT" ||
	node.tagName=="NOSCRIPT" ||
	node.tagName=="LINK" ||
	node.tagName=="META" ||
	node.tagName=="TITLE" ||
	node.tagName=="HEAD" ||
	node.tagName=="IFRAME" ||
	node.tagName=="IMG"
	)
	{
		return 0;
	}
	return 1;
}

var CalendarBox=null;

function destroyCalendarBox()
{
	if(CalendarBox)
	{
		document.body.removeChild(CalendarBox);
		delete CalendarBox;
		CalendarBox=null;
	}
}

function icalLink(icalURL, calendarName)
{
	if(!icalURL){return;}
	
	var webcal=icalURL;
	if(webcal.indexOf("https")==0)
	{
		webcal="webcal"+webcal.substring(5);
	}
	else
	if(webcal.indexOf("http")==0)
	{
		webcal="webcal"+webcal.substring(4);
	}
	else
	{
		webcal="webcal://"+webcal;
	}
	
	destroyCalendarBox();
	
	
	var div=document.createElement('div');
	div.style.position='fixed';
	div.style.zIndex='1000';
	div.style.top='32%';
	div.style.left='1%';
	//div.style.height='34%';
	div.style.width='98%';
	div.style.backgroundColor='#002147';
	div.style.border='1px solid black';
	div.style.padding="5px";
	div.id="Calendarbox";
	
	var inner=document.createElement('div');
	inner.style.backgroundColor='#ffffff';
	
	var titleDiv=document.createElement('div');
	titleDiv.style.backgroundColor='#f2f9ff';
	titleDiv.style.fontSize='16px';
	titleDiv.style.fontWeight='bold';
	titleDiv.style.color='#000000';
	titleDiv.style.verticalAlign='middle';
	titleDiv.style.position='relative';
	titleDiv.style.padding='10px 15px';
	titleDiv.style.fontFamily='Verdana,Arial,sans-serif';
	titleDiv.innerHTML="Subscribe to Calendar &mdash; "+calendarName+"<span onclick='destroyCalendarBox();' style='Cursor: pointer; height: 16px; width: 16px; font-size: 16px; line-height: 16px; overflow: hidden; position: absolute; right: 15px; top: 10px'>X</span>";
	
	var contentsDiv=document.createElement('div');
	contentsDiv.style.backgroundColor='#ffffff';
	contentsDiv.style.padding='15px';
	contentsDiv.innerHTML='To subscribe to this calendar, copy and paste the following address into your calendar application:<br/><br/>'+
	'<a href="'+icalURL+'">'+icalURL+'</a><br/><br/>'+
	'<dl>'+
	'<dt>iCal</dt> <dd>Calendar -> Subscribe. Alternatively, <a href="'+webcal+'">click here</a></dd>'+
	'<dt><a target="_blank" href="http://www.google.com/calendar/">Google</a></dt> <dd>Add -> Add by URL</dd>'+
	'<dt><a target="_blank" href="http://calendar.yahoo.com/">Yahoo</a></dt> <dd>Click on the <strong>+</strong> next to Calendars -> Subscribe to calendar</dd>'+
	'<dt>Outlook</dt> <dd>Tools -> Account settings -> Internet Calendars</dd>'+
	'<dt>Thunderbird</dt> <dd>Subscribe. Choose <strong>On the Network</strong>, file type is <strong>iCalendar</strong></dd>'+
	'</dl>';
	
	inner.appendChild(titleDiv);
	inner.appendChild(contentsDiv);
	
	div.appendChild(inner);
	document.body.appendChild(div);
	CalendarBox=div;
}

function loadRSSAsNews(feed,elementId,startDate,endDate,features)
{
if(!features)
{
	features={showDescription: true, chopDescription: true,maxTotalDescriptionSize: 0,randomOne: false, showDate: true, heading: null, headingURL: null, headingSize: "3", more:null, moreURL:null, weather: false, qr: false};
}

if(features.showDescription!=true && features.showDescription!=false){features.showDescription=true;}
if(features.chopDescription!=true && features.chopDescription!=false){features.chopDescription=true;}
if(features.randomOne!=true && features.randomOne!=false){features.randomOne=false;}
if(features.showDate!=true && features.showDate!=false){features.showDate=true;}
if(!features.headingSize){features.headingSize="3";}
if(!features.maxTotalDescriptionSize){features.maxTotalDescriptionSize=0;}
if(features.weather!=true && features.weather!=false){features.weather=false;}
if(features.qr!=true && features.qr!=false){features.qr=false;}

var newsChannel=new RSSChannel(feed);

var itemsIn=newsChannel.items;

var items=[];
var now=new Date();
sorting:
for(var i=itemsIn.length-1;i>=0;i--)
{
	var item=itemsIn[i];
	var pubDate=item.pubDate;
	
	var itemDate=new Date(Date.parse(pubDate));
	var itemEndDate=null;
	if(item['dcterms:valid'])
	{
		itemEndDate=getDCTERMSDate(item['dcterms:valid']);
	}
	
	if(startDate || endDate)
	{
		if(startDate && itemDate.getTime()<startDate.getTime()){continue;}
		
		if(endDate && itemDate.getTime()>endDate.getTime()){;continue;}
	}
	
	if(itemEndDate)
	{
		if(now.getTime()>=itemEndDate.getTime()){continue;}
	}
	
	if(features.filterOut)
	{
		for(var j=0;j<features.filterOut.length;j++)
		{
			if(item.guid.indexOf(features.filterOut[j])!=-1)
			{
				continue sorting;
			}
		}
	}
	
	if(items.length==0)
	{
		items.push(item);continue;
	}
	
	for(var j=0;j<items.length;j++)
	{
		var pubDate2=items[j].pubDate;
		var itemDate2=new Date(Date.parse(pubDate2));
		
		if(itemDate.getTime()>=itemDate2.getTime())
		{
			continue;
		}
		
		items.splice(j,0,item);
		continue sorting;
	}
	
	
	items.push(item);
}

//items=itemsIn;


var condense=new CondenseDescription();

var HTML="";
if(features.randomOne)
{
		var pick=Math.floor(Math.random()*(items.length+1));
		if(pick>=items.length){pick=items.length-1;}
		if(pick<0){pick=0;}
		items=[items[pick]];
}

if(!features.max){features.max=items.length;}

var downto=items.length-features.max;

var total=0;

for(var i=items.length-1;i>=downto;i--)
{
	var item=items[i];
	if(!item){continue;}
	
	
	if(startDate || endDate)
	{
		var itemDate=new Date(Date.parse(item.pubDate));
		
		if(startDate && itemDate.getTime()<startDate.getTime()){continue;}
		if(endDate && itemDate.getTime()>endDate.getTime()){continue;}
	}
	total++;
}

var max=270;
if(features.maxTotalDescriptionSize>0 && features.chopDescription)
{
	if(total>0)
	{
		max=features.maxTotalDescriptionSize/total;
	}
}

if(features.weather)
{
	for(var i=items.length-1;i>=downto;i--)
	{
		var item=items[i];
		if(!item){continue;}
		
		HTML+="<img src='http://l.yimg.com/a/i/us/we/52/"+item.code+".gif'/><br/>";
		HTML+=item.condition+"<br/>"+item.temp+"<sup>o</sup>C";
	}
}
else
{

	for(var i=items.length-1;i>=downto;i--)
	{
		var item=items[i];
		if(!item){continue;}


		if(startDate || endDate)
		{
			var itemDate=new Date(Date.parse(item.pubDate));

			if(startDate && itemDate.getTime()<startDate.getTime()){continue;}
			if(endDate && itemDate.getTime()>endDate.getTime()){continue;}
		}

		var desc=null;
		if(features.showDescription)
		{

			desc=item.description;
			if(!desc){desc="";}
			desc=condense.condense(desc);

			if(desc.length>max && features.chopDescription)
			{	
				if(features.maxTotalDescriptionSize>0)
				{
					var to=0;
					var ellipsis=false;
					for(;;)
					{
						var stop=desc.indexOf('.',to+1);
						if(stop<=0)
						{
							stop=desc.indexOf(' ',to+1);
							ellipsis=true;
						}
						if(stop<=0)
						{
							stop=max;
						}

						if(stop>=max)
						{
							to=stop;
							break;
						}

						to=stop;
					}

					desc=desc.substring(0,to+1);
					if(ellipsis)
					{
						desc=desc+" &hellip;";
					}
				}
				else
				{
					var stop=desc.indexOf('. ',20);
					if(stop<=0)
					{
						stop=desc.indexOf(' ',125);
					}
					if(stop<=0)
					{
						stop=max;
					}
					desc=desc.substring(0,stop+1);
				}
			}
		}
		
		if(features.qr && item.link)
		{
			if(!desc){desc="";}
			var encoded=null;
			if(encodeURIComponent){encoded=encodeURIComponent(item.link);}
			else
			if(encodeURLComponent){encoded=encodeURLComponent(item.link);}
			else
			if(escape){encoded=escape(item.link);}
			
			desc="<img src=\"https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl="+encoded+"\" align=\"right\" style=\"padding: 1em 0 0 1em\"/>"+desc;
		}

		HTML+="<div class=\"newsItem\"><div class=\"newsItemTitle\"><a href=\""+item.link+"\">"+item.title+"</a></div>";
		if(features.showDate)
		{
			var posted=(item.pubDate.split(' ',4)).join(" ");
			HTML+="<div class=\"newsItemPosted\">"+posted+"</div>";
		}
		if(desc)
		{
			HTML+="<div class=\"newsItemDescription\">"+desc+"</div>";
		}
		HTML+="</div>";

	}
}

if(HTML!="")
{
	if(features.heading)
	{
		var heading="<h"+features.headingSize+">";
		if(features.headingURL)
		{
			heading+="<a href=\""+features.headingURL+"\">";
		}
		heading+=features.heading;
		if(features.headingURL)
		{
			heading+="</a>";
		}
		heading+="</h"+features.headingSize+">";
		HTML=heading+HTML;
	}
	
	if(features.more && features.moreURL)
	{
		var more="<p>";
		more+="<a href=\""+features.moreURL+"\">";
		more+=features.more;
		more+="</a>";
		more+="</p>";
		HTML+=more;
	}
}

HtmlUpdater.$(elementId).innerHTML=HTML;

return total;
}

function getDCTERMSDate(valid)
{
	if(!valid){return null;}
	
	if(valid.indexOf('end=')>=0)
	{
		var parts=valid.split(';');
		
		for(var i=0;i<parts.length;i++)
		{
			var endequals=parts[i].indexOf('end=');
			if(endequals>=0)
			{
				var date=parts[i].substring(4);
				return new Date(date);
			}
		}
	}
	else
	{
		try
		{
			var date=new Date(valid);
			return date;
		}
		catch(e)
		{
		}
	}
	
	return null;
}

