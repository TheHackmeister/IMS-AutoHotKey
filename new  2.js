var ajaxCallback = function (func) {
	var wrapper = function() {
		$('#loadingWrapper').off('hasFinished')
		func.call(this);
	};
	//wrapper = wrapper.bind(this);
	$('#loadingWrapper').on('hasFinished',$.proxy(wrapper,this));
}


//This overloads the loading functions to allow skipping hiding of a loading page. This helps AHK follow what's going on the page bettet.
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
	
	
	
	
	
	
	
var focusCounter = 0;

function trackFocus() {
	focusCounter += 1; 
	console.log(focusCounter);
}

window.onfocus = function () {trackFocus();};










function test1() {
	console.log("Test1 Orginal");
}

var test1Org = test1;
var test1 = function () {
	console.log("Test1 overwritten");
	test1Org();
}

var test1 = function () {
	console.log("This should be the only thing written");
}

test1();







var ajaxCallback = function (func) {
	var wrapper = function() {
		if($("#loadingWrapper").attr('class') == 'hide') {
			observer.disconnect();
			func.call(this);
		}
	};
	wrapper = wrapper.bind(this);
	var observer = new MutationObserver(wrapper);
	observer.observe(document.getElementById("loadingWrapper"), {attributes: true});
}

function getEditAssetID() {
	return document.getElementById("editAssetID").value;
}


//Switch from IDE -> SATA
// SATA -> IDE
// 3.5 -> 2.5
// 2.5 -> 3.5
// Individually 
// In array


//Would like to implement an arrayed version. 

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



function switchSize(id) {
	ajaxCallback(replaceSize);
	selectAsset(id);
}

function replaceSize() {
	var item = $('#editOrderlineProductSearchText' + getEditAssetID()).val()
	item = item.replace(/GENERIC /,"");
	if(item.indexOf("3.5 IN") > 0) {
		item = item.replace(/3.5 IN/, "LPTP");
	} else if (item.indexOf("LPTP") > 0 ) {
		item = item.replace(/LPTP/, "3.5 IN");
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
	ajaxCallback();
}

