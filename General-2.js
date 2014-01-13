
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