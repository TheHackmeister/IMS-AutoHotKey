//HTML for boxing page.
document.getElementById("dashboardBody").innerHTML = 'Create box<br/> \
	<div style="height:330px;"> \
		<div class="divCell" style="padding-right:75px;"> \
			<div> \
				Box Location: <input type="text" id="currentLocationLocation" value="" > \
				<input type="button" id="currentLocationRunReport" value="Run Report"><br> \
			</div> \
			<div class="divCell"> \
				Create Location<br><br>  \
				<form> \
					Description<br> \
					<input type="text" id="createLocationDescription" placeholder="Description"><br> \
					Type<br> \
					<select id="createLocationlocation_type"> \
						<option value="16">BOX</option> \
						<option value="15">PALLET</option> \
						<option value="4">STORAGE</option> \
						<option value="1">WORK STATION</option> \
					</select><br> \
					Max Asset QTY<br> \
					<input type="text" id="createLocationMaxAssetQty" placeholder="Max Asset QTY" value="40"><br> \
					<input type="hidden" id="createLocationProductTypeid" value=""> \
					<input type="text" id="createLocationProductTypeText" hidden> \
					<input type="hidden" id="createLocationProductConditionid"> \
					<input type="text" id="createLocationProductConditionText" hidden> \
					<input type="button" id="createLocationButton" value="create"> \
				</form> \
				<div id="createLocationResponse"> \
				</div> \
			</div> \
			<div id="createLocationEditLocationSearch" class="divCell"> \
				<select id="createLocationField" hidden="true"> \
					<option selected="" value="location"></option> \
				</select> \
				<input type="checkbox" id="createLocationFilter" hidden="true"> \
				<div id="createLocationSearchResults" style="height:240px; overflow:auto; width:200px;" FIXTHIS> \
					&nbsp; \
				</div> \
			</div> \
		</div> \
		<div id="currentLocationLocationForm" class="divCell"> \
		</div> \
		<div id="currentLocationResponse"></div> \
		<div id="currentLocationTransferResponse"></div> \
	</div> \
	<div> \
		<div class="divCell" style="padding-right:75px;"> \
			Transfer Assets to box<br> \
			<select id="currentBoxSimpleCheck"> \
				<option value="false">Hard Drive and Laptops </option> \
				<option value="true"> Simple </option> \
				<option value="off">No check</option> \
			</select> <br> \
			Asset Tags<br> \
			<textarea rows="20" cols="30" id="currentBoxAssets"></textarea><br> \
			<input type="button" id="currentBoxSubmit" value="Transfer"><span id="currentBoxAssetsCount"></span><br> \
			<div id="currentBoxResults"></div> \
			<div id="currentBoxTemp" style="visibility:hidden; width:1px; height:1px;"></div> \
		</div> \
		<div class="divCell"> \
			Transfer Assets to <input type="text" value="" id="otherTransferLocation"><br> \
			<select id="otherTransferSimpleCheck"> \
				<option value="off">No check</option> \
				<option value="false">Hard Drive and Laptops </option> \
				<option value="true"> Simple </option> \
			</select> <br> \
			Asset Tags<br> \
			<textarea rows="20" cols="30" id="otherTransferAssets"></textarea><br> \
			<input type="button" id="otherTransferSubmit" value="Transfer"><span id="otherTransferAssetsCount"></span><br> \
			<div id="otherTransferResults"></div> \
			<div id="otherTransferTemp" style="visibility:hidden; width:1px; height:1px;"></div> \
		</div> \
		<div class="divCell"> \
			Product Name \
			<div id="ProductName"></div> \
			CPU Brand \
			<div id="CPUBrand"></div> \
			CPU Type \
			<div id="CPUType"></div> \
			Webcam \
			<div id="Webcam"></div> \
			Condition \
			<div id="Condition"></div> \
			<div id="transferPreCheck" style="visibility:hidden; width:1px; height:1px;"></div> \
		</div>	 \
	</div> ';


// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};

//This stuff improves general IMS functionality	
//This allows me to call something after an AJAX call without overloading another function.
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
		return;
	}
    hideLoadingOld();
	document.title = 'IMS';
}


function getEditAssetID() {
	return document.getElementById("editAssetID").value;
}


//Creates an object that makes beep noises. Used for quality control checks later on.
 function soundAlert() {
	this.context = new webkitAudioContext(); 
	this.osc = this.context.createOscillator(),  
	this.osc.type = 2;  
	this.osc.frequency.value = 49;               

	this.play = play;
	function play(time,message) {
		this.osc.connect(this.context.destination);  
		this.osc.noteOn(0); 
		var _this = this;
		window.setTimeout(function(){
			_this.osc.disconnect();
			if(message){
				alert(message);
			}
		},time);
	}
	
	this.playGood = playGood;
	function playGood() {
		this.osc.frequency.value = 520;
		this.play(150);
	}
	
	this.playBad = playBad;
	function playBad(message) {
		this.osc.frequency.value = 98;
		this.play(500,message);
	}	
	this.play40 = function () {
		this.osc.frequency.value = 520;
		this.play(1000);
	}
}
var beepAlert = new soundAlert();


//Creates an asset object. Will be inherited by other objects.
var Asset = function(id,type) {
	Object.defineProperty(this,"assetID", {value: id, writable : true, enumerable : false, configurable : true});
	this.assetType = type;
}	
//Has default text for assetType.
Asset.prototype = Object.create(Object.prototype, {
	assetType: {value: "Asset Type", writable: true,  enumerable: true,  configurable: true}
});
//Compares the specifications of assets. There will be more than just the assetType.
Asset.prototype.compare = function (asset2) {
	if (!asset2) return false;
	if (this.length != asset2.length) return false;

	for ( var p in this ) {
		if(this[p] != asset2[p]) {
			var result = Object.getPrototypeOf(this)[p] + " of the current item is " + this[p] + ". \n" + Object.getPrototypeOf(this)[p] + " of the first item is " + asset2[p] + ".";
			return result;
		}
	}
	return true;
}	

//inherits the Asset object and adds what's needed for comparing simple products, such as hard drives.
var Product = function (id,type,product,condition) {
	this.product = product || $("#editOrderlineProductSearchText" + id).val();

	this.condition = condition || $("[name='test2']").eq(0).val();	

	if(this.condition == 1) {
		this.condition = "Pass";
	} else {
		this.condition = "Fail";
	}

	Asset.apply(this, arguments);
};
//Sets the default text for specifications. 
Product.prototype = Object.create(Asset.prototype, {
	product: {value: "Product Name",  writable: true,  enumerable: true,  configurable: true},
	condition: {value: "Product Condition",  writable: true,  enumerable: true,  configurable: true}
});
//This has the same concept as the Product object. However, I have not implemented it yet.
var Laptop = function (id,type,product,condition,attatchedAssets,webcam,CPUClass,CPUBrand) {

//These need fixing. 
	this.attatchedAssets = attatchedAssets || ""; 
	this.webcam = webcam || $("[name='spec8']").eq(0).val();
	this.CPUClass = CPUClass || $("[name='spec6']").eq(0).val();
	this.CPUBrand = CPUBrand || $("[name='spec6']").eq(0).val();
	Product.apply(this, arguments);
}
Laptop.prototype = Object.create(Product.prototype, {
	CPUClass:{value: "CPU Type",  writable: true,  enumerable: true,  configurable: true},
	attatchedAssets: {value: "Attatched Assets",  writable: true,  enumerable: true,  configurable: true},
	webcam:{value: "Webcam",  writable: true,  enumerable: true,  configurable: true},
	CPUBrand:{value: "CPU Brand",  writable: true,  enumerable: true,  configurable: true}
});






//This is the base for the form objects. Just has an ID and a function to change the ID of $ objects without trouble.
var InputForm = function (id) {
	this.id = id;
}
//Could I simplify this to simple add and remove the ID?
InputForm.prototype.changeDivs = function() {
	 var elements = [];
	 for (var i = 0; i < arguments.length; i += 2) {
		var arg = arguments[i];
		arg.originalID = arg.attr('id');
		arg.attr('id', arguments[i+1]);
		elements.push(arg);
	 }
	 return elements;
}

InputForm.prototype.restoreDivs = function(elements) {
	elements.forEach(function(el) {
		el.attr('id', el.originalID);
	});
}

//Create Location
//This creates an object that manages the creation of new IMS boxes. 
var CreateLocation = function (id) {
	InputForm.call(this,id);

	this.searchResults = $('#' + this.id + 'SearchResults');
	this.searchField = $('#' + this.id + 'Field');
	this.searchFilter = $('#' + this.id + 'Filter');
	this.description = $('#' + this.id + 'Description');
	this.boxType = $('#' + this.id + 'location_type');
	this.maxQty = $('#' + this.id + 'MaxAssetQty');
	this.restrictedProduct = $('#' + this.id + 'ProductTypeid');
	this.restrictedCondition = $('#' + this.id + 'ProductTypeid');
	this.createResponse = $('#' + this.id + 'Response');
	this.createButton = $('#' + this.id + 'Button');
	this.productType = $('#' + this.id + 'ProductType');
	this.productCondition = $('#' + this.id + 'ProductCondition');
	this.location = $('#' + this.id + 'Location');

	
//The event handlers.	
	this.description.on('keyup', $.proxy(function (event) {
		if (event.keyCode == 13 || event.keyCode == 10) {
			this.createLocation();
	} else {this.searchLocation();}},this));
	this.createButton.on('click', $.proxy(function(){this.createLocation();},this));
}
CreateLocation.prototype = Object.create(InputForm.prototype);

//This sets up a callback and calls createLocaiton.
CreateLocation.prototype.createLocation = function () {
	var changedElements = this.changeDivs(this.description,"location",this.boxType, "location_type", this.maxQty, "maxAssetQty", this.createResponse, "createLocationResponse", this.restrictedProduct, "editLocationProductType", this.restrictedCondition, "editLocationProductCondition");
	ajaxCallback.call(this,function(){this.createLocationCallback(changedElements)});
	createLocation();
}
//After createLocation is finished, sets the current box to the new box.
CreateLocation.prototype.createLocationCallback = function (changedElements) {
	this.restoreDivs(changedElements);
	this.setBoxLocation();
//Might not work if no currentBox?
}

//Gets the location ID for the new box, and sets it as the current box.
CreateLocation.prototype.setBoxLocation = function () {
	var cleared = this.createResponse.html().split(/\n/);	
	this.createResponse.html(cleared[cleared.length - 2]);



	var asset = $('#' + this.createResponse.attr('id') + ' input[type=button]');
	asset.click();
	asset = asset.attr('onclick').substring(asset.attr('onclick').indexOf("id=")+3,asset.attr('onclick').indexOf("','"));
	this.location.val(asset);
	this.location.trigger('change');
	currentBox.assets.focus();
}

//Calls the searchLocation function so that the person can see what boxes have already been created.
CreateLocation.prototype.searchLocation = function () {
	var changedElements = this.changeDivs(this.searchResults, "editLocationSearchResults", this.description, "searchLocationText", this.searchField, "field", this.searchFilter, "filter");
	ajaxCallback.call(this,function(){this.searchLocationCallback(changedElements)});
	this.searchResults.hide();
	searchLocation();	
}

//Trims the searchLocation results to show the last 13 items. 
CreateLocation.prototype.searchLocationCallback = function (changedElements) {
	this.restoreDivs(changedElements);
	var responseArray = this.searchResults.html().split(/\n/);
	while(responseArray.length > 13) {
		responseArray.remove(0);
	}
	var response = "";
	responseArray.forEach(function(arrayKey){
//Remove or change the link?
		response += arrayKey + "\n";
	});
	
	this.searchResults.html(response);
	this.searchResults.show();
}




//Current Location
//This is the object responsible for managing the current location fields, these are the current box, run report button, and the edit location field.
var CurrentLocation = function(id) {
	InputForm.call(this,id);
//Perhaps have a mixin for Location?
	this.location = $('#' + this.id + 'Location');
	this.locationForm = $('#' + this.id + 'LocationForm');
	this.locationResponse = $("#" + this.id + "Response");
	this.transferResponse = $("#" + this.id + "TransferReponse");
	this.runReportButton = $('#' + this.id + 'RunReport');
	
//Event Handlers.	
	this.location.on('change', $.proxy(function(){this.selectLocation();},this));
	this.runReportButton.on('click', $.proxy(function(){this.runReport();},this));
	this.locationForm.on('click', '[value="save"]', $.proxy(function(){this.transferAndSaveLocation();},this));
}
CurrentLocation.prototype = Object.create(InputForm.prototype);

//This is called when the current box location changes. It sets the edit location area to be the correct location. 
CurrentLocation.prototype.selectLocation = function () {
	if(this.location.val() == "") {
		this.locationForm.html("");
		return;
	}
	var changedElements = this.changeDivs(this.locationForm, "editLocationForm");
	ajaxCallback.call(this,function(){this.selectLocationCallback(changedElements)});
	selectLocation(this.location.val());
}

//This adds functionality to the save button and adds the new location transfer field. 
CurrentLocation.prototype.selectLocationCallback = function (changedElements) {
	this.restoreDivs(changedElements);
	$('#' + this.locationForm.attr('id') + ' [value="save"]').removeAttr('onclick');
	$('#' + this.locationForm.attr('id') + ' [value="save"]').on('click', $.proxy(function(){this.saveLocation();},this));
	$("#editLocationResponse").remove();
	//Add transfer box.
	$('<br><input type="text" id="' + this.id + 'Transfer' + '" value="" placeholder="New Location">').insertAfter("#maxAssetQty");
	this.transferToLocation = $("#" + this.id + 'Transfer');
	//Strip out editLocationResponse div. 
}

//This transfers the location.
CurrentLocation.prototype.transferAndSaveLocation = function () {
	if(this.transferToLocation.val() == "") {
		this.transferAndSaveLocationCallback;
		return;
	}
	var changedElements = this.changeDivs(this.location, "editLocationTransferLocation", this.transferToLocation, "editLocationTransferParent", this.transferResponse, "editLocationTransferResults");
	ajaxCallback.call(this,function(){this.transferAndSaveLocationCallback(changedElements)});
//	window.skipHide = true;
	transferLocation();
}

//Once the location is transferred, it is saved (generally, this just means that the lock status is saved). 
CurrentLocation.prototype.transferAndSaveLocationCallback = function (changedElements) {
	if(typeof(changedElements) == 'undefined') this.restoreDivs(changedElements);
	this.saveLocation();
}

//Saves the location.
CurrentLocation.prototype.saveLocation = function() {
	var changedElements = this.changeDivs(this.location,"editLocationID", this.locationResponse, "editLocationResponse");
	ajaxCallback.call(this,function(){this.saveLocationCallback(changedElements)});
	this.tempLocation = this.location.val();
//Fairly certain this will break the Callback. Can fix with manual trigger?
//	window.skipHide = true;
	saveLocation()
}

//Once the location is saved, load it again.
CurrentLocation.prototype.saveLocationCallback = function (changedElements) {
	this.restoreDivs(changedElements);
	this.location.val(this.tempLocation);
	this.location.trigger('change');
}

//Just runs the short report.
CurrentLocation.prototype.runReport = function () {
	newWindow('locations=' + this.location.val() + '&shipped=true&so=true' , 'assetcountbylocationshortprocess.php', 'reports');
}


//This form manages the asset transfer boxes. 
var TransferAssetsForm = function(id) {
	this.id = id;
	this.location = $("#" + id + 'Location');
	this.checkType = $("#" + id +  'SimpleCheck');
	this.assets  = $("#" + id + 'Assets');		
	this.results = $("#" + id + 'Results');
	this.count = $("#" + id + 'AssetsCount');
	this.submit = $("#" + id + 'Submit');
	this.assetTempLocation = $("#" + id + 'Temp');
//Create a div to display first product.
	this.firstAsset;
	this.currentAsset;

//Event Handlers
	this.assets.on('keyup', $.proxy(function(event){
	   if (event.keyCode == 13 || event.keyCode == 10) {
			this.countAssets();
			this.preCheck();
		} else {
			this.countAssets();
		}
	},this));
	this.submit.on('click',$.proxy(function() {this.transfer();},this));
}

//Sets up the needed elements and calls transferAssets.
TransferAssetsForm.prototype.transfer = function() {
	this.location.attr('id', 'editAssetTransferLocation');
	this.assets.attr('id', 'editAssetTransferAssets');
	this.results.attr('id', 'editAssetTransferResults');
	ajaxCallback.call(this,this.transferCallback);
	transferAssets();
}
TransferAssetsForm.prototype.transferCallback = function() {
	this.location.attr('id', this.id + 'Location');
	this.assets.attr('id', this.id + 'Assets');
	this.results.attr('id', this.id + 'Results');
}

//This will run a pre check on the asset. It calls edit asset to get the asset specs. 
//Figure out what to do if first is different.
TransferAssetsForm.prototype.preCheck = function() {
	if(this.checkType.val() == "off") return;
	var list = this.assets.val().replace(/^\s*[\r\n]/gm, "");
	list = list.split(/\n/);
	if(list[list.length - 1] == "") {list.pop();}

//	if(list.length >= 40) beepAlert.play40();

	var firstID = list[0];

	var string = "ID="+list[list.length - 1];
	var file = 'selectasset.php';
	var code = 'document.getElementById("transferPreCheck").innerHTML = response;';
	code += 'hideLoading();';
	ajaxCallback.call(this,function(){this.preCheckCallback(firstID)});
	ajax(string, file, code, 'assets');
}

//This takes information from the edit asset form and puts it into a product object and compares that to the first product object. 
TransferAssetsForm.prototype.preCheckCallback = function(first) {
	var assetID = $("#editAssetID").val();
	if (assetID == 'undefined') {
		this.badAsset("That item doesn't exist or has been deleted.");
		this.assetTempLocation.innerHTML = '';
		return;
	}
		
	var type;
	var checkType;
	if (this.checkType.val() == "true")
		checkType = "simple";


	if($("[name='spec10']").length != 0) {
		type = "hard drive";
	} else {
		type = "laptop";
	}
	
			
			
	if(checkType == "simple") {
		this.currentAsset = new Asset(assetID,type);
	} else if (type == "hard drive") {
		this.currentAsset = new Product(assetID,type);
	} else if (type == "laptop") {
		this.currentAsset = new Laptop(assetID,type);
	}
	
	if (this.currentAsset.assetID == first) {
		this.firstAsset = this.currentAsset;
	}
	
	this.assetTempLocation.innerHTML = '';
	var result = this.currentAsset.compare(this.firstAsset);

	if(result == true) {
//If 40
		this.goodAssetAlert();
	} else {
		this.badAssetAlert(result);
	}
}

//Calls the transferAssetCount function.
TransferAssetsForm.prototype.countAssets = function () {
	this.assets.attr('id', 'editAssetTransferAssets');
	this.count.attr('id', 'count');
	transferAssetsCount();
	this.assets.attr('id', this.id + 'Assets');
	this.count.attr('id', this.id + 'Count');
}

//I'd like to pass in a beepAlert reference rather than call it directly.
TransferAssetsForm.prototype.goodAssetAlert = function () {
	beepAlert.playGood();
}

TransferAssetsForm.prototype.badAssetAlert = function (message) {
	var loc = this.assets.attr('id');
	if(location != "") {
		this.assets.val(this.assets.val().replace(this.currentAsset.assetID + '\n',''));
		this.countAssets();
	}
	beepAlert.playBad(message);
}
	

//This loads the objects above. 
var loca = $('#currentLocationLocation');
var currentLocation = new CurrentLocation("currentLocation"); //On change
loca.attr('id', 'createLocationLocation');
var createLoc = new CreateLocation("createLocation");  //Sets the location
loca.attr('id', 'currentBoxLocation');
var currentBox = new TransferAssetsForm("currentBox"); //Gets location
loca.attr('id', 'currentLocationLocation');
var otherTransfer = new TransferAssetsForm("otherTransfer");


