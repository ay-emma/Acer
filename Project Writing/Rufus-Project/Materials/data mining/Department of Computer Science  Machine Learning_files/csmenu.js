
/*****************************************
* pop out menus
* Author: Edward Crichton
*****************************************/

function changeCSSClass(parentElement, from, to)
{
	if(!parentElement){return;}
	var children=parentElement.childNodes;
	var n=children.length;
	for(var i=0;i<n;i++)
	{
		var child=children[i];
		if(child.nodeType!=1){continue;}
		
		if(child.className && from==child.className)
		{
			child.className=to;
		}
		else
		{
			changeCSSClass(child,from,to);
		}
	}
}
