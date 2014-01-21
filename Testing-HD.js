TestingHDJS = 
(
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
	if(this.getAssetID() == "") {
		return;
	}
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
	if($('#PrintOption').is(":checked") == true)
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
	this.checkAsset = new TestHd(test1,location);

	loc.attr('id', 'Location')
	
	this.checkAsset.asset.asset.on('loaded', $.proxy(function() {this.check();},this));
	this.checkAsset.asset.asset.on('loaded', $.proxy(function() {this.checkAsset.asset.asset.focus().select();},this));
	
	
//	loc.attr('id', test2 + 'Location')
//	this.test2 = new TestHd(test2,location);	
	
//	this.test1.asset.asset.on('loaded',$.proxy(function () {this.test2.passButton.focus();},this));
//	this.test2.asset.asset.on('loaded',$.proxy(function () {this.test1.passButton.focus();},this));
//	this.test2.passButton.on('saved', $.proxy(function() {this.test2.asset.asset.focus().select();},this));
}

TestInterface.prototype.check = function () {
	if($('#editOrderlineProductSearchText' + this.checkAsset.asset.getAssetID()).val().indexOf($('#hdFormFactor').val()) == -1) {
		alert("The product is not of type " + $('#hdFormFactor').val());
	}
	
	if($('.' + this.checkAsset.id + ' [name="test2"]').eq(0).prop('checked') == false) {
		alert("Asset condition is bad or not set.");
	}
	
	// Check size
	// Check Condition
}

var SetAssetCondition = function (id) {
	this.id = id;
	this.location = $("#" + id + 'Location');
	this.assets  = $("#" + id + 'Assets');	
	this.results = $("#" + id + 'Results');
	this.count = $("#" + id + 'Count');
	this.submit = $("#" + id + 'Button');
	this.assetTempLocation = $("#" + id + 'Temp');
	
	
	
	
//Event Handlers
	this.assets.on('loaded', $.proxy(function() {this.setConditionAndSave(0);},this));
	this.assets.on('saved', $.proxy(function() {this.nextOnList();},this));
	this.submit.on('click',$.proxy(function() {this.setupSetCondition();},this));
	
	
	
	this.assets.on('keyup', $.proxy(function(event){
		this.countAssets();
	},this));
}
//Could I simplify this to simple add and remove the ID?
SetAssetCondition.prototype.changeDivs = function() {
	 var elements = [];
	 for (var i = 0; i < arguments.length; i += 2) {
		var arg = arguments[i];
		arg.originalID = arg.attr('id');
		arg.attr('id', arguments[i+1]);
		elements.push(arg);
	 }
	 return elements;
}

SetAssetCondition.prototype.restoreDivs = function(elements) {
	elements.forEach(function(el) {
		el.attr('id', el.originalID);
	});
}


//Calls the transferAssetCount function.
SetAssetCondition.prototype.countAssets = function () {
	var changedElements = this.changeDivs(this.assets, "editAssetTransferAssets", this.count, "count"); 
	transferAssetsCount();
	this.restoreDivs(changedElements);
}

SetAssetCondition.prototype.setupSetCondition = function () {
	this.assetList = this.assets.val().replace(/^\s*[\r\n]/gm, "");
	this.assetList = this.assetList.split(/\n/);
	if(this.assetList[this.assetList.length - 1] == "") {
		this.assetList.pop();
	}
	this.loadAsset(this.assetList[0]);
//	var transferList = list;  If I transfer last, I wont need to keep the list.  
}



SetAssetCondition.prototype.loadAsset = function (asset) {
	alert('1');
	if(typeof(asset) == 'undefined') {
		var asset = this.getAssetID()
	}
	if(asset == "") {
		return;
	}
	var changedElements = this.changeDivs(this.assetTempLocation, "editAssetForm"); 
	ajaxCallback.call(this,function(){this.loadAssetCallback(changedElements)});
	alert('2');
	selectAsset(asset);
}

SetAssetCondition.prototype.loadAssetCallback = function (changedElements) {
	alert('3');
	this.restoreDivs(changedElements);
//	this.productDiv.html($('#editOrderlineProductSearchText' + this.getAssetID()).val());
	this.assets.trigger('loaded');
//Need to check here. 
	alert('4');

	alert('7');
}

SetAssetCondition.prototype.setConditionAndSave = function (condition) {
	alert('5');
	if(typeof(condition) != 'undefined') {
		$('.' + this.id + ' [name="test2"]').eq(condition).prop('checked', true);
		$('.' + this.id + ' [name="test15"]').eq(condition).prop('checked', true);
	}
	ajaxCallback.call(this,function(){this.setConditionAndSaveCallback()});
	saveAsset(this.assetList[0]);
	alert('6');
}

SetAssetCondition.prototype.setConditionAndSaveCallback = function () {
	alert('8');
	this.assets.trigger('saved');
}

SetAssetCondition.prototype.nextOnList = function () {
	alert('9');
	this.assetList.remove(0);
	if (this.assetList.length > 0) {
		this.loadAsset(this.assetList[0]);
	}
	alert('10');
}

////////////////////////////////////
//HTML for HD testing page.
document.getElementById("dashboardBody").innerHTML = 'Print Tag:<input type="checkbox" id="PrintOption" checked="true"> </br> \
	Form Factor: <select id="hdFormFactor"> \
			<option value="Nothing">None</option> \
			<option value="LPTP">Laptop Drive</option> \
			<option value="3.5 IN">Desktop Drive</option> \
		</select> \
	</div> \
<div class="divCell asset1"> \
	Current Asset: <input id="asset1ID" value="" placeholder="Current Asset"> </br> \
	<div id="asset1Results"> </div> \
	Current Product: <span id="asset1Product">None </span> </br>\
	PO Notes: <span id="asset1PONotes">PO Notes</span>  </br> \
	<div id="asset1EditDiv"></div> \
	<div id="asset1PO" style="visibility:hidden; width:1px; height:1px;"> </div>\
</div> \
<div class="sac"> \
	<div>Transfer Location: <input id="sacLocation" placeholder="Location"> </br> \
	<textarea rows="20" cols="30" id="sacAssets"></textarea>	\
	<button id="sacButton">Set condition</button> \
	<span id="sacCount"></span> \
	<div id="sacResults"></div> \
	<div id="sacTemp" style="visibility:hidden; width:1px; height:1px;"> </div> \
</div>';
test = new TestInterface('asset1','asset2');
sac = new SetAssetCondition('sac');
)

thing = 
(
	<button id="asset1PS">Pass and Save</button> \
	<button id="asset1FS">Fail and Save</button> \
<div class="divCell asset2"> \
	Current Asset: <input id="asset2ID" value="" placeholder="Current Asset">  </br> \
	<div id="asset2Results"> </div> \
	Current Product: <span id="asset2Product">None </span> </br>\
	PO Notes: <span id="asset2PONotes">PO Notes</span>  </br> \
	<div id="asset2EditDiv"></div> \
	<button id="asset2PS">Pass and Save</button> \
	<button id="asset2FS">Fail and Save</button> \
	<div id="asset2PO" style="visibility:hidden; width:1px; height:1px;"> </div>\
</div>'
)