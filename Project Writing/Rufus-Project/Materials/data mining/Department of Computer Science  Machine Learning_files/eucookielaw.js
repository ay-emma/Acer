var policyCookie="cl_policy";

function areCookiesEnabled()
{
	var cookieEnabled = (navigator.cookieEnabled) ? true : false;
	if (typeof navigator.cookieEnabled == "undefined" && !cookieEnabled)
	{
		var testcookiename="cl_test"+Math.floor(Math.random()*100000);
		document.cookie=testcookiename="yes";
		if(document.cookie.indexOf(testcookiename)>=0)
		{
			document.cookie=testcookiename+"=;expires=Thu, 01 Jan 1970 00:00:00 GMT;"
			return true;
		}
		
		return false;
	}
	return cookieEnabled;
}

function setShownPolicy()
{
	var domain=window.location.hostname || window.location.host;
	
	if(domain)
	{
		domain=domain.substring(domain.indexOf('.'));
	}
	
	var date=new Date();
	date.setYear(date.getFullYear()+1);
	
	var expires=date.toUTCString();
	
	document.cookie=policyCookie+"=yes; domain="+domain+"; path=/; expires="+expires+";";
}

function shouldShowPolicy()
{
	if(areCookiesEnabled())
	{
		var domain=window.location.hostname || window.location.host;

		if(document.cookie.indexOf(policyCookie)<0)
		{
			return true;
		}
	}
	return false;
}

function continueUsingSite()
{
	var cookie_policy_div=document.getElementById("cookiepolicy");
	if(cookie_policy_div)
	{
		cookie_policy_div.style.display="none";
	}
}

var toShowPolicy=function()
{
	if(shouldShowPolicy())
	{
		
		var cookie_policy_div=document.getElementById("cookiepolicy");
		
		if(cookie_policy_div)
		{
			cookie_policy_div.style.display="block";
			setShownPolicy();
		}
	}
};

// set up call on document ready

function removeReady()
{
	document.removeEventListener( "DOMContentLoaded", removeReady, false );
	window.removeEventListener( "load", removeReady, false );
	toShowPolicy();
}

if ( document.readyState === "complete" ){setTimeout( toShowPolicy,1 );}
else
{
	document.addEventListener( "DOMContentLoaded", removeReady, false );
	window.addEventListener( "load", removeReady, false );
}
