setupBoxing()
{
	AMIIMS()
	BlockOn()
	JSText = 
	(
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
		<div class="divCell"> \
			<div id="currentLocationLocationForm" class="divCell"> \
			</div> \
			<div id="currentLocationResponse"></div> \
			<div id="currentLocationTransferResponse"></div> \
		</div> \
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
			<div id="currentBoxProductName"></div> \
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
			<div id="otherTransferProductName"></div> \
			<textarea rows="20" cols="30" id="otherTransferAssets"></textarea><br> \
			<input type="button" id="otherTransferSubmit" value="Transfer"><span id="otherTransferAssetsCount"></span><br> \
			<div id="otherTransferResults"></div> \
			<div id="otherTransferTemp" style="visibility:hidden; width:1px; height:1px;"></div> \
		</div> \
	</div> ';
)

StringReplace, JSText, JSText, `t, ,A
RunJavaScriptLong(JSText)

JSText2 = 
(
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
var Laptop = function (id,type,product,condition,attatchedAssets,webcam,cpuID) {
	Product.apply(this, arguments);
	//Sets the CPU info.
	Object.defineProperty(this,"cpuID", {value: cpuID || $('#spec6').val(), writable : true, enumerable : false, configurable : true});
	this.setCPU();
	this.product = this.setProduct();
	
//These need fixing. 
	this.attatchedAssets = attatchedAssets || ""; 
}
Laptop.prototype = Object.create(Product.prototype, {
	cpuGen:{value: "CPU Type",  writable: true,  enumerable: true,  configurable: true},
	attatchedAssets: {value: "Attatched Assets",  writable: true,  enumerable: true,  configurable: true},
//	webcam:{value: "Webcam",  writable: true,  enumerable: true,  configurable: true},
	cpuBrand:{value: "CPU Brand",  writable: true,  enumerable: true,  configurable: true}
});

Laptop.prototype.setProduct = function () {
	if(this.cpuGen == "I Series") {
		return "iSeries";
//This one needs fixed V 
	} else if(this.isHPBusiness()) {
		return "HP Business";
//This one also needs fixed. Lats
	} else if(this.isDellBusiness()) {
		return "Dell Business";
	} else if(this.condition == "Pass") {
		var	webcam = $('input[name="spec8"]:checked').val();
		var notes = $('[name="spec15"]').eq(0).val();
//need some way of verifying this text V 		
		if(notes.toLowerCase().indexOf("cracked")) { 
			return this.cpuGen + " with Cracked Screen";
//May need to double check that BIOS will be in text. Perhaps locked.
		} else if (notes.toLowerCase().indexOf("bios")) {
			return this.cpuGen + " with BIOS locked";
		} 
		if (webcam == "1") {
			return this.cpuGen + "with webcam";
		} else if (webcam == "0") {
			return this.cpuGen + "without webcam";
		}		
	} else if(this.condition == "Fail") {
		return this.cpuGen + " Dismantle";
	} 
	
	return "Unknown type";
}

Laptop.prototype.isHPBusiness = function () {
	hpArray = ["HP COMPAQ 6910P", "HP COMPAQ N_6400 SERIES", "HP ELITEBOOK 6930"]; 
		
	if(hpArray.indexOf(this.product) != -1)
		return true;
	else
		return false;	
}

Laptop.prototype.isDellBusiness = function () {
	var d = "DELL LATITUDE D";
	var m = "DELL PRECISION M";
	var e = "DELL LATITUDE E";
	dellArray = [d + "420", d + "430", d + "520", d + "530", d + "531", d + "620", d + "630", d + "820", d + "830", 
		m + "20", m + "2300", m + "2400", m + "4300", m + "4400", m + "50", m + "60", m + "6300", m + "6400", m + "65", m + "70", m + "90", 
		e + "4200", e + "4300", e + "4310", e + "5400", e + "5410", e + "5420", e + "5420M", e + "5500", e + "5510", e + "5520", e + "5520M",
		e + "6220", e + "6320", e + "6330", e + "6400", e + "6410", e + "6420", e + "6430", e + "6430S", e + "6500", e + "6510", e + "6520", e + "6530", ]; 
		
	if(dellArray.indexOf(this.product) != -1)
		return true;
	else
		return false;	
}

Laptop.prototype.setCPU = function () {
	var i;
	for(i = 0; i < this.cpuArray.length; i++) {
		if(this.cpuArray[i][0] == this.cpuID) 
			break;
	}
	if(i == this.cpuArray.length) {
		console.log("Trouble!");
		return;
	}
//	this.cpuName = this.cpuArray[i][1];
	this.cpuGen = this.cpuArray[i][2];
	this.cpuBrand = this.cpuArray[i][3]; 
}
firstArray = "71,AMD ATHLON 4,Pentium 3,AMD:\
77,AMD ATHLON 64,Pentium 4,AMD:\
220,AMD ATHLON 64 (TF-20),Green Planet,AMD:\
86,AMD ATHLON 64 X2,Dual Core,AMD:\
153,AMD ATHLON II X2,Dual Core,AMD:\
157,AMD ATHLON II X3,Quad Core,AMD:\
154,AMD ATHLON II X4,Quad Core,AMD:\
212,AMD ATHLON NEO,Pentium M,AMD:\
69,AMD ATHLON XP,Pentium 3,AMD:\
70,AMD ATHLON XP-M,Pentium 3,AMD:\
208,AMD C-50,Dual Core,AMD:\
224,AMD C-60,Dual Core,AMD:\
66,AMD DURON,Pre Pentium 3,AMD:\
225,AMD FUSION,Dual Core,AMD:\
68,AMD K6,Pre Pentium 3,AMD:\
91,AMD PHENOM II,Dual Core,AMD:\
155,AMD PHENOM X3,Quad Core,AMD:\
152,AMD PHENOM X4,Quad Core,AMD:\
110,AMD SEMPRON (DUAL CORE ERA),Green Planet,AMD:\
109,AMD SEMPRON (P4 ERA),Pentium 4,AMD:\
214,AMD SEMPRON (PENTIUM M ERA),Pentium M,AMD:\
78,AMD TURION 64,Pentium M,AMD:\
87,AMD TURION 64 X2,Dual Core,AMD:\
89,AMD TURION II,Dual Core,AMD:\
223,AMD TURION NEO,Dual Core,AMD:\
211,AMD V120,Green Planet,AMD:\
213,AMD V140,Green Planet,AMD:\
217,AMD VISION A10,Quad Core,AMD:\
57,AMD VISION A4,Dual Core,AMD:\
58,AMD VISION A6,Dual Core,AMD:\
59,AMD VISION A8,Quad Core,AMD:\
56,AMD VISION E SERIES,Green Planet,AMD:\
139,EXYNOS 5 DUAL,Other,Other:\
82,INTEL ATOM,Pentium M,Intel:\
97,INTEL CELERON (PENTIUM 4 ERA),Pentium 4,Intel:\
96,INTEL CELERON (PENTIUM III ERA),Pentium 3,Intel:\
98,INTEL CELERON (POST PENTIUM M),Green Planet,Intel:\
151,INTEL CELERON D,Pentium M,Intel:\
76,INTEL CELERON M,Pentium M,Intel:\
84,INTEL CORE 2 DUO,Dual Core,Intel:\
85,INTEL CORE 2 EXTREME,Quad Core,Intel:\
93,INTEL CORE 2 QUAD,Quad Core,Intel:\
92,INTEL CORE 2 SOLO,Green Planet,Intel:\
83,INTEL CORE DUO,Dual Core,Intel:\
60,INTEL CORE I3,I Series,Intel:\
61,INTEL CORE I5,I Series,Intel:\
62,INTEL CORE I7,I Series,Intel:\
80,INTEL CORE SOLO,Pentium M,Intel:\
94,INTEL PENTIUM (ORIGINAL),Pre Pentium 3,Intel:\
99,INTEL PENTIUM (POST PENTIUM M),Dual Core,Intel:\
74,INTEL PENTIUM 4,Pentium 4,Intel:\
150,INTEL PENTIUM D,Pentium M,Intel:\
90,INTEL PENTIUM DUAL-CORE,Dual Core,Intel:\
64,INTEL PENTIUM II,Pre Pentium 3,Intel:\
63,INTEL PENTIUM III,Pentium 3,Intel:\
75,INTEL PENTIUM M,Pentium M,Intel:\
65,INTEL PENTIUM MMX,Pre Pentium 3,Intel:\
226,INTEL PRE-PENTIUM,Pre Pentium 3,Intel:\
158,INTEL XEON,Green Planet,Intel:\
140,POWERPC G3,Other,Other:\
141,POWERPC G4,Other,Other:\
142,POWERPC G5,Other,Other:\
72,TRANSMETA CRUSOE,Other,Other:\
73,VIA C3,Pre Pentium 3,Other:\
67,VIA C7,Pre Pentium 3,Other".split(':');
	cpuArray = new Array();
	firstArray.forEach(function(el){
		cpuArray.push(el.split(','));
	});
Laptop.prototype.cpuArray = cpuArray;


)

StringReplace, JSText2, JSText2, `t, ,A
RunJavaScriptLong(JSText2)

JSText2 = 
(
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
	this.searchResults.on('click', "a", $.proxy(this.setLocation,this));
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
	this.maxQty.val("40");
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

CreateLocation.prototype.setLocation = function (event) {
	var location = $(event.target).attr('href').replace("javascript: selectLocation('", "").replace("');", "");
	this.location.val(location);
	this.location.trigger('change')
	return false;
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
	this.transferResponse = $("#" + this.id + "TransferResponse");
	this.runReportButton = $('#' + this.id + 'RunReport');
	
//Event Handlers.	
	$(window).keydown($.proxy(function(event) {
		if(event.shiftKey && event.ctrlKey && event.keyCode == 82) {
			this.runReport();
			event.preventDefault(); 
			return;
		}
	},this));

	this.location.on('change', $.proxy(function(){this.selectLocation();},this));
	this.runReportButton.on('click', $.proxy(function(){this.runReport();},this));
	this.locationForm.on('click', '[value="save"]', $.proxy(function(){this.saveOrDeleteLocation("Save");},this));
	this.locationForm.on('click', '[value="delete"]', $.proxy(function(){this.saveOrDeleteLocation("Delete");},this));
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
	$("#editLocationResponse").remove(); //Needed because the response div is part what is loaded.
	//Add transfer box.
	$('<br><input type="text" id="' + this.id + 'Transfer' + '" value="" placeholder="New Location">').insertAfter("#maxAssetQty");
	this.transferToLocation = $("#" + this.id + 'Transfer');

}


//Saves the location.
CurrentLocation.prototype.saveOrDeleteLocation = function(action) {
	var changedElements = this.changeDivs(this.locationResponse, "editLocationResponse"); //this.location,"editLocationID", 
	var shouldTransfer = false;
	if(action == "Save" && this.transferToLocation.val() != "") shouldTransfer = true;
	
	ajaxCallback.call(this,function(){this.saveOrDeleteLocationCallback(changedElements,shouldTransfer)});
	window.skipHide = true;
//	Either save or delete gets called after this.
}

//Once the location is saved, load it again.
CurrentLocation.prototype.saveOrDeleteLocationCallback = function (changedElements,shouldTransfer) {
	this.restoreDivs(changedElements);
	
	if(shouldTransfer) {
		this.transferLocation();
	} else {
		this.location.trigger('change');
	}
}

//This transfers the location.
CurrentLocation.prototype.transferLocation = function () {
	this.tempLocation = this.location.val();
	var changedElements = this.changeDivs(this.location, "editLocationTransferLocation", this.transferToLocation, "editLocationTransferParent", this.transferResponse, "editLocationTransferResults");
	ajaxCallback.call(this,
	function(){this.transferLocationCallback(changedElements)});
	window.skipHide = true;	
	transferLocation();
}

//Once the location is transferred, it is saved (generally, this just means that the lock status is saved). 
CurrentLocation.prototype.transferLocationCallback = function (changedElements) {
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
	InputForm.call(this,id);
	this.location = $("#" + id + 'Location');
	this.checkType = $("#" + id +  'SimpleCheck');
	this.assets  = $("#" + id + 'Assets');		
	this.results = $("#" + id + 'Results');
	this.count = $("#" + id + 'AssetsCount');
	this.submit = $("#" + id + 'Submit');
	this.productDiv = $("#" + id + 'ProductName');
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
TransferAssetsForm.prototype = Object.create(InputForm.prototype)

//Sets up the needed elements and calls transferAssets.
TransferAssetsForm.prototype.transfer = function() {
	var changedElements = this.changeDivs(this.location, "editAssetTransferLocation", this.assets, "editAssetTransferAssets", this.results, "editAssetTransferResults"); 
	ajaxCallback.call(this,function(){this.transferCallback(changedElements)});
	transferAssets();
}
TransferAssetsForm.prototype.transferCallback = function(changedElements) {
	this.restoreDivs(changedElements);
	this.productDiv.html("");
}

//This will run a pre check on the asset. It calls edit asset to get the asset specs. 
//Figure out what to do if first is different.
TransferAssetsForm.prototype.preCheck = function() {
	if(this.checkType.val() == "off") return;
	var list = this.assets.val().replace(/^\s*[\r\n]/gm, "");
	list = list.split(/\n/);
	if(list[list.length - 1] == "") {list.pop();}


	var firstID = list[0];
	var currentID = list[list.length - 1];

	var string = "ID="+currentID;
	var file = 'selectasset.php';
//Need to fix this. Should go to this.assetTempLocation.
	var code = 'document.getElementById("' + this.assetTempLocation.attr('id') +  '").innerHTML = response;';
	code += 'hideLoading();';
	ajaxCallback.call(this,function(){this.preCheckCallback(firstID,currentID)});
	ajax(string, file, code, 'assets');
}

//This takes information from the edit asset form and puts it into a product object and compares that to the first product object. 
TransferAssetsForm.prototype.preCheckCallback = function(first,currentID) {

	var assetID = $("#editAssetID").val();
	
	if(typeof(assetID) == 'undefined' || assetID != currentID) {
		this.currentAsset = {};
		this.currentAsset.assetID = currentID;
		this.badAssetAlert("The item with the ID of " + currentID + " doesn't exist or has been deleted.");
		this.assetTempLocation.html("");
		return false;
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
		this.productDiv.html(this.firstAsset.product || "");
	}
	
	this.assetTempLocation.html("");
	var result = this.currentAsset.compare(this.firstAsset);

	if(result == true) {
		this.goodAssetAlert();
	} else {
		this.badAssetAlert(result);
	}
}
//Calls the transferAssetCount function.
TransferAssetsForm.prototype.countAssets = function () {
	var changedElements = this.changeDivs(this.assets, "editAssetTransferAssets", this.count, "count"); 
	transferAssetsCount();
	this.restoreDivs(changedElements);
}
//I'd like to pass in a beepAlert reference rather than call it directly.
TransferAssetsForm.prototype.goodAssetAlert = function () {
	if(this.count.html() == "(40 assets)") 
		beepAlert.play40();
	else
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
 )
StringReplace, JSText2, JSText2, `t, ,A
RunJavaScriptLong(JSText2)
BlockOff()
}

countInLocation()
{

runJS = 
(

	

// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};


function findAndRemove(array,string)  {
	for(var i = 0; i < array.length; i++) {
		if(array[i][0] == string ) {
			array.remove(i);
			break;

		}
	}
	return array;
}
	var product;
	var productArray = new Array();//[index][text|number]

	$('.line').each(function(i, obj) {
	product = $(this).find(".item:eq(1)").html();
	
	if(i == 1) {
		var newProduct = new Array();
		newProduct[0] = product;
		newProduct[1] = 1;
		productArray.push(newProduct);
	}
	
	var found = false;
	
	productArray.forEach(function(i2) {
		if(product == i2[0]) {
			i2[1] += 1;
			found = true;
		} 
	});
	if(found != true) {
		var newProduct = new Array();
		newProduct[0] = product;
		newProduct[1] = 1;
		productArray.push(newProduct);
	}
});
	
productArray = findAndRemove(productArray,"DESC");
productArray = findAndRemove(productArray,null);
productArray.sort();

var arrayS = "";

productArray.forEach(function(i2) {
	arrayS += i2[0] + ":" + i2[1] + "<br>\n";
});
$("<div>" + arrayS + "</div>").insertAfter('#assetCountWrapper')
)

RunJavascriptSafe(runJS)
WinWaitActive, Developer Tools
Send !{F4}
WinWaitActive, Developer Tools
Send !{F4}
}


