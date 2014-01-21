TestingHDJS = 
(
/*
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
*/
////////////////////////////////////////////////
var Asset = function (id) {
	this.id = id;
	this.assetID;
	this.asset = $('#' + id + 'ID');
	this.transferLocation = $('#' + id + 'Location');
	this.transferResults = $('#' + id + 'Results');
	this.editAssetDiv = $('#' + id + 'EditDiv');
	this.productDiv = $('#' + id + 'Product');
}

Asset.prototype.getAssetID = function() {
	return this.asset.val();
}

//Could I simplify this to simple add and remove the ID?
Asset.prototype.changeDivs = function() {
	 var elements = [];
	 for (var i = 0; i < arguments.length; i += 2) {
		var arg = arguments[i];
		arg.originalID = arg.attr('id');
		arg.attr('id', arguments[i+1]);
		elements.push(arg);
	 }
	 return elements;
}

Asset.prototype.restoreDivs = function(elements) {
	elements.forEach(function(el) {
		el.attr('id', el.originalID);
	});
}

Asset.prototype.transfer = function() {
	var changedElements = this.changeDivs(this.transferLocation, "editAssetTransferLocation", this.asset, "editAssetTransferAssets", this.transferResults, "editAssetTransferResults"); 
	ajaxCallback.call(this,function(){this.transferCallback(changedElements)});
	this.assetID = this.asset.val();
	transferAssets();
}
Asset.prototype.transferCallback = function(changedElements) {
	this.restoreDivs(changedElements);
	this.asset.val(this.assetID);
	this.asset.trigger('transfered');
}

Asset.prototype.loadAsset = function () {
	var changedElements = this.changeDivs(this.editAssetDiv, "editAssetForm"); 
	ajaxCallback.call(this,function(){this.loadAssetCallback(changedElements)});
	selectAsset(this.getAssetID());
}

Asset.prototype.loadAssetCallback = function (changedElements) {
	this.restoreDivs(changedElements);
	this.productDiv.html($('#editOrderlineProductSearchText' + this.getAssetID()).val());
	this.asset.trigger('loaded');
}

Asset.prototype.printTag = function () {
	newWindow("id=" + this.getAssetID(), 'printassettag.php', 'assets', true);
}


////////////////////////////////////////////////

var TestHd = function (id) {
	
	this.id = id;
	this.asset = new Asset(id);
	this.passButton = $('#' + id + 'PS');
	this.failButton = $('#' + id + 'FS');
	this.poDiv = $('#' + id + 'PO');
	this.poNotes = $('#' + id + 'PONotes');
//	this.printTagOption = $('#' + id + '');
	
//Event handlers 
	this.asset.asset.on('change', $.proxy(function() {this.loadAsset();},this.asset));
	this.asset.asset.on('loaded', $.proxy(function () {this.printTag();},this.asset));
	this.asset.asset.on('loaded', $.proxy(function () {this.loadPONotes();},this));
	this.asset.editAssetDiv.on('click', '[value="save"]' , $.proxy(function() {this.setConditionAndSave();},this));
	this.passButton.on('click',$.proxy(function (){this.setConditionAndSave(0); },this));
	this.failButton.on('click',$.proxy(function (){this.setConditionAndSave(1); },this));

//	this.transferOption = $('#' + id + '');
//	this.transfer.assets.on('transfered', $.proxy(function() {this.load();},this.loadAsset));//{this.transfer();},this.transfer)
}

//0 = pass, 1 = fail for condition. 
TestHd.prototype.setConditionAndSave = function (condition) {
	if(typeof(condition) != 'undefined') {
		$('.' + this.id + ' [name="test2"]').eq(condition).prop('checked', true);
		$('.' + this.id + ' [name="test15"]').eq(condition).prop('checked', true);
	}
	
	ajaxCallback.call(this,function(){this.setConditionAndSaveCallback()});
	saveAsset(this.asset.getAssetID());
}

TestHd.prototype.setConditionAndSaveCallback = function () {
	this.passButton.trigger('saved');
}


//Could I simplify this to simple add and remove the ID?
TestHd.prototype.changeDivs = function() {
	 var elements = [];
	 for (var i = 0; i < arguments.length; i += 2) {
		var arg = arguments[i];
		arg.originalID = arg.attr('id');
		arg.attr('id', arguments[i+1]);
		elements.push(arg);
	 }
	 return elements;
}

TestHd.prototype.restoreDivs = function(elements) {
	elements.forEach(function(el) {
		el.attr('id', el.originalID);
	});
}

TestHd.prototype.loadPONotes = function () {
	var changedElements = this.changeDivs(this.poDiv, "editOrderForm"); 
	ajaxCallback.call(this,function(){this.loadPONotesCallback(changedElements)});
	selectOrder($('.' + this.id + ' #editOrderlinePO').val().replace(/\/\d+/, ""));
}

TestHd.prototype.loadPONotesCallback = function (changedElements) {
	this.restoreDivs(changedElements);
	this.poNotes.html($('.' + this.id + ' #notes').val());
	this.poDiv.html("");
}



var TestInterface = function (test1,test2) {
	loc = $('#Location');
	loc.attr('id', test1 + 'Location');
	this.test1 = new TestHd(test1,location);
	loc.attr('id', test2 + 'Location')
	this.test2 = new TestHd(test2,location);
	loc.attr('id', 'Location')
	
	this.test1.asset.asset.on('loaded',$.proxy(function () {this.test2.passButton.focus();},this));
	this.test2.asset.asset.on('loaded',$.proxy(function () {this.test1.passButton.focus();},this));
	this.test1.passButton.on('saved', $.proxy(function() {this.test1.asset.asset.focus().select();},this));
	this.test2.passButton.on('saved', $.proxy(function() {this.test2.asset.asset.focus().select();},this));
}



////////////////////////////////////
//HTML for HD testing page.
document.getElementById("dashboardBody").innerHTML = '<div>Desk Location: <input id="Location" placeholder="Desk Location"></div> \
<div class="divCell asset1"> \
	Current Asset: <input id="asset1ID" value="" placeholder="Current Asset"> </br> \
	<div id="asset1Results"> </div> \
	Current Product: <span id="asset1Product">None </span> </br>\
	PO Notes: <span id="asset1PONotes">PO Notes</span>  </br> \
	<div id="asset1EditDiv"></div> \
	<button id="asset1PS">Pass and Save</button> \
	<button id="asset1FS">Fail and Save</button> \
	<div id="asset1PO" style="visibility:hidden; width:1px; height:1px;"> </div>\
</div> \
<div class="divCell asset2"> \
	Current Asset: <input id="asset2ID" value="" placeholder="Current Asset">  </br> \
	<div id="asset2Results"> </div> \
	Current Product: <span id="asset2Product">None </span> </br>\
	PO Notes: <span id="asset2PONotes">PO Notes</span>  </br> \
	<div id="asset2EditDiv"></div> \
	<button id="asset2PS">Pass and Save</button> \
	<button id="asset2FS">Fail and Save</button> \
	<div id="asset2PO" style="visibility:hidden; width:1px; height:1px;"> </div>\
</div>';
test = new TestInterface('asset1','asset2');
)