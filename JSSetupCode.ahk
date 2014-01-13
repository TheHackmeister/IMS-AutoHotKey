SetupIMSPage() 
{
BlockOff()
	If (!WinActive("ahk_group NOIMS")){
		Alert("Can't set-up IMS; this is not an IMS page. (I'm pretty sure) ")
		BlockOff()
		Exit
	}
	
	JSText = 
	(
window.addEventListener('keydown',function(e){if(e.keyIdentifier=='U+0008'||e.keyIdentifier=='Backspace'){if(e.target==document.body||e.target.type=="radio"){ e.preventDefault();}}},true);
	var CDiv = document.createElement('div');
	var txtarea = document.createElement('textarea');
	txtarea.id = 'ScriptSearchTextArea'
	var txt = document.createTextNode('ScriptSearch');
	var butt = document.createElement('button');

	txtarea.id = "ScriptSearchTextArea"
	butt.innerHTML = "Enter";
	butt.setAttribute("onClick", "ScriptSearchRunJS()");

	CDiv.appendChild(txt);
	CDiv.appendChild(txtarea);
	CDiv.appendChild(butt);
	//StyleText In Percentage signs.
	CDiv.style.zIndex = "-1";
	CDiv.style.position = "fixed";
	CDiv.style.top = "1em";
	document.getElementsByTagName("body")[0].insertBefore(CDiv,document.getElementsByTagName("body")[0].getElementsByTagName('div')[0]);


	var runjs=document.createElement('script');
	runjs.setAttribute('type','text/javascript');
	runjs.innerHTML = "document.title = 'IMS'; \
function ScriptSearchRunJS() { \
    var runjs=document.createElement('script'); \
    runjs.setAttribute('type','text/javascript'); \
    runjs.innerHTML = document.getElementById('ScriptSearchTextArea').value; \
    document.getElementsByTagName('body')[0].appendChild(runjs);}"
	document.getElementsByTagName('body')[0].appendChild(runjs);

$(window).keydown(function(event) {
  if(event.shiftKey && event.ctrlKey && event.keyCode == 89) {
		ScriptSearchRunJS()
		event.preventDefault(); 
		return;
  }
  if(event.ctrlKey && event.keyCode == 89) { 
    document.getElementById("ScriptSearchTextArea").focus()
    event.preventDefault(); 
  }
 });
document.title = 'IMS';
	)
	
RunJavascriptSafe(JSText)
	ImproveIMSText =
	(
	
//This stuff improves general IMS functionality	
//This allows me to call something after an AJAX call without overloading another function.
var ajaxCallback = function (func) {
	var wrapper = function() {
//		$('#loadingWrapper').off('hasFinished')
		func.call(this);
	};
//	$('#loadingWrapper').on('hasFinished',$.proxy(wrapper,this));
	$('#loadingWrapper').one('hasFinished',$.proxy(wrapper,this)); 
}


//This overloads the loading functions to allow skipping hiding of a loading page. This helps AHK follow what's going on the page better.
var showLoadingOld = showLoading;
showLoading = function(){
	document.title = 'IMS (Loading)';
	showLoadingOld.apply(this,arguments);
}
var hideLoadingOld = hideLoading;
hideLoading = function (){
	if(window.skipHide)
	{	
		window.skipHide = false;
		$('#loadingWrapper').trigger('hasFinished');
		return;
	}
    hideLoadingOld();
	$('#loadingWrapper').trigger('hasFinished');
	document.title = 'IMS';
}

	

// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};

//If there is only one PO result found, it is selected.
function clickTopOption() {
	ajaxCallback(function(){
		if($('.search').length == 1) {
			$('.search a').eq(0)[0].click();
		}	
	});
}

// Triggers for selecting PO
$('#dashboardBody').on('keyup', '#searchOrderText', function(e) {
if(e.keyCode == 10 || e.keyCode == 13) {
	searchOrder();
	clickTopOption();
}
});
$('#dashboardBody').on('click', '#editOrderSearch [value="search"]', function(e) {
	clickTopOption();
});


//Overloads the newWindow function. Adds clicking the print button on page load and adds support for Firefox. 
function newWindow(string, file, plugin){ 
	var code = '';
	if(plugin){
		string = string + '&file=' + file + '&plugin='+plugin;
	}else{
		string = string + '&file=' + file;
	}
	var response;
	$.ajax({
		url: 'pagehandler.php',
		data: string,
		async: false,
		dataType: 'html',
		type: 'POST',
		success: function(data) {
			response = data;
			eval(code);
		},
		error: function(xhr, status, error) {
			var err = eval('(' + xhr.responseText + ')');
			response = err.Message;
		}
	}); 
	var wnd = window.open('about:blank', '', '_blank');
	wnd.document.write(response);
	if (plugin == 'assets'){
		wnd.document.close();
		wnd.onload = function( ) {
			wnd.document.title = 'Print Ready';
			wnd.printWindow();
		}
	}
}
	
//Calls the addOrderline function, and sets up callback for clicking print and setting focus to the External Asset field upon load.
var addOrderLineOld = addOrderLine;
var addOrderLine = function() {
	window.skipHide = true;
	$('#addOrderLineResult').html("");
	ajaxCallback(addOrderLineListener);
	addOrderLineOld.apply(this,arguments);
}
var addOrderLineListener = function() {
	if($('#addOrderLineResult').html() != "") {
		hideLoading();
		return;
	}
	ajaxCallback(function(){addOrderLineListener2();});
	$('.printLink')[0].click();
};
var addOrderLineListener2 = function () {
	$('#editOrderlineExternalAsset').focus().val($('#editOrderlineExternalAsset').val());
};

function getEditAssetID() {
	return document.getElementById("editAssetID").value;
}
	)

	StringReplace, ImproveIMSText, ImproveIMSText, `t, ,A
	RunJavaScriptLong(ImproveIMSText)

ImproveIMSText =
(

//Automatically locks a PO when saved. Also sets focus to the product description box after save.
var saveAssetOld = saveAsset;
var saveAsset = function(asset) {
	var id = "editOrderlineResult" + arguments[0];
	$("." + id).eq(0).on("DOMSubtreeModified",saveAssetListener(asset,id));
	saveAssetOld.apply(this, arguments);
};
var saveAssetListener = function (asset,id) {

	var handler = function (asset,id) {
		//If we're not adding to a PO, don't lock condition. 
		if(!document.getElementById("addAssetDiv")) return;
		
		saveAssetCondition(asset);		
        $('#addAssetProductSearchText').focus();    
		
		$("." + id).eq(0).off("DOMSubtreeModified");
		$("." + id).eq(0).html($("." + id).eq(0).html() + " ");
	}.bind(this, asset, id);
	return handler;
}


//Would like to implement an arrayed version. 
function switchSize(id) {
	ajaxCallback(replaceSize);
	selectAsset(id);
}


function swapHDDConnector() {
	swapProductName("IDE", "SATA");
}

function swapHDDFormFactor() {
	swapProductName("3.5 IN", "LPTP");
}

function swapProductName(swap1, swap2) {
	var item = $('#editOrderlineProductSearchText' + getEditAssetID()).val()
	item = item.replace("GENERIC ","");
	if(item.indexOf(swap1) > 0) {
		item = item.replace(swap1, swap2);
	} else if (item.indexOf(swap2) > 0 ) {
		item = item.replace(swap2, swap1);
	} else {
		return;
	}
	
	$('#editOrderlineProductSearchText' + getEditAssetID()).val(item);
	ajaxCallback(clickNewAssetName);
	$('#editOrderlineProductSearchText' + getEditAssetID()).trigger('keyup');
}


function clickNewAssetName() {
	$('#editOrderlineProductSearchResults' + getEditAssetID() + " a").eq(0).click();
	saveAsset(getEditAssetID());
	//ajaxCallback();
}

	
)
	
	StringReplace, ImproveIMSText, ImproveIMSText, `t, ,A
	RunJavaScriptLong(ImproveIMSText)
BlockOff()
}
