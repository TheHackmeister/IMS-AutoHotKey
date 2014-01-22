TestingHDJS = 
(
////////////////////////////////////////////////
var Asset = function (id) {
	this.id = id;
	this.asset = $('#' + id + 'ID');
	this.editAssetDiv = $('#' + id + 'EditDiv');
	this.productDiv = $('#' + id + 'Product');
}
Asset.prototype = Object.create(InputForm.prototype);

Asset.prototype.setAssetID = function (id) {
	this.asset.val(id);
//	this.asset.trigger('changed');
}

Asset.prototype.getAssetID = function() {
	return this.asset.val();
}

Asset.prototype.load = function (id) {
	if(typeof(id) == 'undefined') {
		var id = this.getAssetID(id); 
	} else {
		this.setAssetID(id);
	}
	if(id == "") {
		return;
	}
	var changedElements = this.changeDivs(this.editAssetDiv, "editAssetForm"); 
	ajaxCallback.call(this,function(){this.loadCallback(changedElements);});
	selectAsset(id);
}

Asset.prototype.loadCallback = function (changedElements) {
	this.restoreDivs(changedElements);
	this.productDiv.html($('#editOrderlineProductSearchText' + this.getAssetID()).val());
//Look for deleted asset here.
	this.asset.trigger('loaded');
}

//0 = pass, 1 = fail for condition. 
Asset.prototype.setCondition = function (condition) {
	if(typeof(condition) != 'undefined') {
		$('.' + this.id + ' [name="test2"]').eq(condition).prop('checked', true);
		$('.' + this.id + ' [name="test15"]').eq(condition).prop('checked', true);
	}
	this.asset.trigger('conditionSet');
}

Asset.prototype.save = function (condition) {
	ajaxCallback.call(this,function(){this.saveCallback()},3);
	console.log("Saving asset: " + this.getAssetID());
	saveAsset(this.getAssetID());
}

Asset.prototype.saveCallback = function () {
	this.asset.trigger('saved');
}

Asset.prototype.printTag = function () {
	newWindow("id=" + this.getAssetID(), 'printassettag.php', 'assets', true);
}




//////////////////////////////////////

CheckHd = function (id) {
	this.id = id;
	this.asset = new Asset(id);
	this.poDiv = $('#' + id + 'PO');
	this.poNotes = $('#' + id + 'PONotes');

	this.printOption = $('#' + id + 'PrintOption');
	this.formFactor = $('#' + id + 'FormFactor');
	
	//Event handlers 

	this.asset.asset.on('change', $.proxy(function() {this.load();},this.asset));
	this.asset.asset.on('loaded', $.proxy(function () {
		this.printTag();
		this.loadPONotes();
		this.checkHd();
		this.asset.asset.focus().select();
	},this));
}
CheckHd.prototype = Object.create(InputForm.prototype);

CheckHd.prototype.loadPONotes = function () {
	var changedElements = this.changeDivs(this.poDiv, "editOrderForm"); 
	ajaxCallback.call(this,function(){this.loadPONotesCallback(changedElements)});
	selectOrder($('.' + this.id + ' #editOrderlinePO').val().replace(/\/\d+/, ""));
}

CheckHd.prototype.loadPONotesCallback = function (changedElements) {
	this.restoreDivs(changedElements);
	this.poNotes.html($('.' + this.id + ' #notes').val());
	this.poDiv.html("");
}

CheckHd.prototype.printTag = function () {
	if(this.printOption.is(":checked") == true) {
		this.asset.printTag();
	}
}

CheckHd.prototype.checkHd = function () {
	if($('#editOrderlineProductSearchText' + this.asset.getAssetID()).val().indexOf(this.formFactor.val()) == -1) {
		alert("The product is not of type " + this.formFactor.val());
	}
	
	if($('.' + this.id + ' [name="test2"]').eq(1).prop('checked') == true) {
		alert("Asset condition is bad.");
	}
}




////////////////////////////////////////////////
var Loc = function (id) {
	this.id = id;
	this.location = $('#' + id + 'Location');
	this.results = $('#' + id + 'Results');
	this.assets  = $("#" + id + 'Assets');	
}
Loc.prototype = Object.create(InputForm.prototype);


Loc.prototype.transfer = function() {
	var changedElements = this.changeDivs(this.location, "editAssetTransferLocation", this.assets, "editAssetTransferAssets", this.results, "editAssetTransferResults"); 
	ajaxCallback.call(this,function(){this.transferCallback(changedElements)});
	transferAssets();
}

Loc.prototype.transferCallback = function(changedElements) {
	this.restoreDivs(changedElements);
	this.assets.trigger('transfered');
}



/////////////////////////////////////////////////////
var SetAssetCondition = function (id) {
	this.id = id;
	this.count = $("#" + id + 'Count');
	this.submit = $("#" + id + 'Button');
	this.condition = $('#' + id + 'Condition');
	this.location = new Loc(id);
	this.asset = new Asset(id);
		
	
//Event Handlers
	this.submit.on('click',$.proxy(function() {$('#asset1EditDiv').html("");this.startSettingCondition();},this));
	this.asset.asset.on('loaded', $.proxy(function () {this.asset.setCondition(this.getCondition());},this));
	this.asset.asset.on('conditionSet', $.proxy(function() {this.save();},this.asset));
	this.asset.asset.on('saved', $.proxy(function() {this.continueSettingCondition();}, this));
	
	
	this.location.assets.on('keyup', $.proxy(function(event){
		this.countAssets();
	},this));
}
SetAssetCondition.prototype = Object.create(InputForm.prototype);


//Calls the transferAssetCount function.
SetAssetCondition.prototype.countAssets = function () {
	var changedElements = this.changeDivs(this.location.assets, "editAssetTransferAssets", this.count, "count"); 
	transferAssetsCount();
	this.restoreDivs(changedElements);
}

SetAssetCondition.prototype.startSettingCondition = function () {
	if(this.location.location.val() == "") {
		alert("Please enter a transfer to location");
		return;
	}
	this.assetList = this.location.assets.val().replace(/^\s*[\r\n]/gm, "");
	this.assetList = this.assetList.split(/\n/);
	if(this.assetList[this.assetList.length - 1] == "") {
		this.assetList.pop();
	}
	this.asset.load(this.assetList[0]);
}

SetAssetCondition.prototype.getCondition = function () {
	return this.condition.val();
}

SetAssetCondition.prototype.continueSettingCondition = function () {
	hideLoading();
	this.assetList.remove(0);
	if (this.assetList.length > 0) {
		this.asset.load(this.assetList[0]);
	} else {
		this.location.transfer();
	}
}



////////////////////////////////////
//HTML for HD testing page.
document.getElementById("dashboardBody").innerHTML = 'Current Asset: <input id="asset1ID" value="" placeholder="Current Asset"> </br> \
	Form Factor: <select id="asset1FormFactor"> \
			<option value="LPTP">Laptop Drive</option> \
			<option value="">None</option> \
			<option value="3.5 IN">Desktop Drive</option> \
		</select> </br> \
	Print Tag:<input type="checkbox" id="asset1PrintOption" checked="true"> </br> \
<div class="divCell asset1"> \
	Current Product: <span id="asset1Product">None </span> </br>\
	PO Notes: <span id="asset1PONotes">PO Notes</span>  </br> \
	<div id="asset1EditDiv"></div> \
	<div id="asset1PO" style="visibility:hidden; width:1px; height:1px;"> </div>\
</div> \
</br></br> \
<div class="sac"> \
	<div>Set condition and transfer</div>\
	<div>Transfer Location: <input id="sacLocation" placeholder="Location"> </br> \
	Condition: <select id="sacCondition"> \
		<option value="0">Pass</option> \
		<option value="1">Fail</option> \
	</select> </br> \
	<textarea rows="20" cols="30" id="sacAssets"></textarea>	\
	<button id="sacButton">Set condition</button> \
	<span id="sacCount"></span> \
	<div id="sacResults"></div> \
	<input type="hidden" id="sacID" value=""> \
	<div id="sacEditDiv" style="visibility:hidden; width:1px; height:1px;"> </div> \
</div>';
var check = new CheckHd('asset1');
var sac = new SetAssetCondition('sac');
)
