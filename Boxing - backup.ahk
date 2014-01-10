setupBoxing()
{
	AMIIMS()
	JSText = 
	(
document.getElementById("dashboardBody").innerHTML = 'Create box<br/> \
	<div> \
		<div class="divCell" style="padding-right:75px;"> \
			<div> \
				Box Location: <input type="text" id="currentBoxLocation" value="" onchange="boxSelectLocation(this);"> \
				<input type="button" value="Run Report" onclick="newWindow(\'locations=\' + document.getElementById(\'currentBoxLocation\').value + \'&shipped=true&so=true\' , \'assetcountbylocationshortprocess.php\', \'reports\');"><br> \
			</div> \
			<div class="divCell"> \
				Create Location<br><br>  \
				<form> \
					Description<br> \
					<input type="text" id="startLocation" placeholder="Description" onkeyup="searchLocation(this)"><br> \
					Type<br> \
					<select id="location_type"> \
						<option value="16">BOX</option> \
						<option value="15">PALLET</option> \
						<option value="4">STORAGE</option> \
						<option value="1">WORK STATION</option> \
					</select><br> \
					Max Asset QTY<br> \
					<input type="text" id="boxMaxAssetQty" placeholder="Max Asset QTY" value="40"><br> \
					<input type="button" value="create" onclick="boxCreateLocation()"> \
				</form> \
				<div id="createLocationResponse"> \
				</div> \
			</div> \
			<div id="editLocationSearch" class="divCell"> \
				<select id="startLocationfield" hidden="true"> \
					<option selected="" value="location"></option> \
				</select> \
				<input type="checkbox" id="startLocationfilter" hidden="true"> \
				<div id="startLocationeditLocationSearchResults" style="height:240px; overflow:auto; width:200px;" FIXTHIS> \
					&nbsp; \
				</div> \
			</div> \
		</div> \
		<div id="editLocationForm" class="divCell"> \
		</div> \
	</div> \
	<div> \
		<div class="divCell" style="padding-right:75px;"> \
				Transfer Assets to box<br> \
				Asset Tags<br> \
				<textarea rows="20" cols="30" id="currentBoxAssets" onkeyup="transferAssetsCount(this)"></textarea><br> \
				<input type="button" id="currentBox" value="Transfer" onclick="transferAssets(this)"><span id="currentBoxAssetscount"></span><br> \
				<div id="currentBoxResults"></div> \
		</div> \
		<div class="divCell"> \
			Transfer Assets to <input type="text" value="" id="otherTransferLocation"><br> \
			Asset Tags<br> \
			<textarea rows="20" cols="30" id="otherTransferAssets" onkeyup="transferAssetsCount(this)"></textarea><br> \
			<input type="button" id="otherTransfer" value="Transfer" onclick="transferAssets(this)"><span id="otherTransferAssetscount"></span><br> \
			<div id="otherTransferResults"></div> \
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
)

StringReplace, JSText, JSText, `t, ,A
RunJavaScriptLong(JSText)

JSText2 = 
(
// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};

function searchLocation(element){
	if(typeof element != 'undefined') {
		var value = element.value;
		var id = element.id;
	} else {
		var value = document.getElementById("searchLocationText").value;
		var id = "";
	}
	var field = document.getElementById(id + "field").value;
	var filter = document.getElementById(id + 'filter').checked;
    var string = "string="+value+"&filter="+filter+"&field="+field;

    if(value != ''){
        var file = 'searchlocation.php';
        var code = 'var responseArray = response.split(/\\n/);';
		code += 'while(responseArray.length > 15)';
		code += '{';
		code += '	responseArray.remove(0);';
		code += '}';
		code += 'response = "";';
		code += 'responseArray.forEach(function(arrayKey){';
		code += '	response += arrayKey + "\\n";';
		code += '});';
		code += 'document.getElementById("' + id + 'editLocationSearchResults").innerHTML = response;';
        ajax(string, file, code, 'locations');
    }else{
        document.getElementById(id + "editLocationSearchResults").innerHTML = '';
    }    
}
hideLoading();


function transferAssetsCount(element){
	if(element != 'undefined') {
		var assets = element.value;
		var id = element.id;
	} else {
		var assets = document.getElementById('editAssetTransferAssets').value;
		var id = "";
	}
    
    var assets = assets.split(/\n/);

    for (var i=0; i < assets.length; i++){
        if(assets[i] == ''){
            assets.splice(i,1);
        }
    }

    var uniqueAssets = [];
    $.each(assets, function(i, el){
        if($.inArray(el, uniqueAssets) === -1) uniqueAssets.push(el);
    });

    document.getElementById(id + 'count').innerHTML = "("+(uniqueAssets.length)+" assets)";
}

function transferAssets(element){
	if(element != 'undefined') {
		var id = element.id;
	} else {
		var id = "editAssetTransfer";
	}
	var assets = document.getElementById(id + 'Assets').value;
	var location = document.getElementById(id + 'Location').value;
    

	
    var assets = assets.split(/\n/);
    var string = '';
    var counter = 0;

    var uniqueAssets = [];
    $.each(assets, function(i, el){
        if($.inArray(el, uniqueAssets) === -1) uniqueAssets.push(el);
    });
    
    for (i = 0; i < uniqueAssets.length; i++){
        string += uniqueAssets[i];

        counter ++;

        if (counter < uniqueAssets.length){
            string +=  ";";
        }
        
    }
    var string = "location="+location + "&assets=" + string;
    var file = 'editassettransferprocess.php';
    var code = "";
    code += 'if (response.indexOf("Transfer Successful") != -1){';
    code +=        "document.getElementById('" + id + "Results').innerHTML = response;";
    code +=        "document.getElementById('" + id + "Assets').value = '';";
    code +=    "}else{";
    code +=        "document.getElementById('" + id + "Results').innerHTML = response;";
    code +=    "}"; 

    ajax(string, file, code, 'assets');
}

function boxCreateLocation(){        
    var location = document.getElementById('startLocation').value;
    var type = document.getElementById('location_type').value;
    var maxAssetQTY = document.getElementById('boxMaxAssetQty').value;
    var string = "location="+location+"&type="+type+"&maxAsset="+maxAssetQTY;    
    var file = 'createlocationprocess.php';
    var code = 'document.getElementById("createLocationResponse").innerHTML = response;';       
    code += 'if (response.indexOf("Location created") != -1){';
    code +=     "document.getElementById('startLocation').value = '';";               
	code +=		"searchLocation(document.getElementById('startLocation'));";
//    code +=     "document.getElementById('location_type').selectedIndex=0;";
//    code +=     "document.getElementById('maxAssetQty').value = '';";
	code +=		"$('#createLocationResponse input[type=button]').click();";
	code +=		"setCurrentBox();";
	code +=		"boxSelectLocation(document.getElementById('currentBoxLocation').value);";
	code += 	"document.getElementById('currentBoxAssets').focus();";
    code += '}';

    ajax(string, file, code, 'locations');
}

function boxSelectLocation(id){
	if(typeof id.value == 'undefined' || id.value == '') {document.getElementById("editLocationForm").innerHTML = ''; return;}
	id = id.value;
	
	var string = "ID="+id;
    var file = 'selectlocation.php';
    var code = 'document.getElementById("editLocationForm").innerHTML = response;';
	code += 'document.getElementById("parentlocation").disabled = false;';

    ajax(string, file, code, 'locations');
}

function setCurrentBox() {
	var asset = $('#createLocationResponse input[type=button]').attr('onclick');
	asset = asset.substring(asset.indexOf("id=")+3,asset.indexOf("','"));
	document.getElementById('currentBoxLocation').value = asset;
}

function assetInfo() {
	this.assetID;
	this.assetType;
	this.product;
	this.condition;
	this.attatchedAssets;
	this.webcam;
	this.CPUName;
	this.CPUBrand;
	this.CPUType;
	
	this.assetTempLocation = document.getElementById("transferPreCheck");
	this.assetInputLocation = document.getElementById("currentBoxAssets");
	
	if(typeof assetInfo.compareWhat ==  "undefined") {
		assetInfo.compareWhat = "HD";
	}
	

	this.set = function set(id) {

		try {
			this.assetID = document.getElementById("editAssetID").value;
		} catch (err) {
			if(typeof id != 'undefined') {
				this.assetID = id;
			}
			this.badAsset("That item doesn't exist or has been deleted.", "currentBoxAssets");
			this.assetID = "bad";
			this.assetTempLocation.innerHTML = '';
			return;
		}
		
		try {
			if(document.getElementsByName("spec10")[0].value != 'undefined') {
				this.assetType = "hard drive";
			}
		} catch (err) {
			this.assetType = "laptop";
		}

		this.product = document.getElementById("editOrderlineProductSearchText" + this.assetID).value;
		this.condition = document.getElementsByName("test2")[0].value;

		if(this.assetType == "laptop") {
			this.attatchedAssets = "";
			this.webcam = "";
			this.CPUName = "";
			this.CPUBrand = "";
			this.CPUType = "";
		} else {
			this.attatchedAssets = "";
			this.webcam = "";
			this.CPUName = "";
			this.CPUBrand = "";
			this.CPUType = "";
		}
	}
	
	this.setFirst = function setFirst() {
		this.set();
		var cond;
		
		if(this.condition == 1) {
			cond = "Pass";
		} else {
			cond = "Fail";
		}
		
		document.getElementById("ProductName").innerHTML = this.product;
		document.getElementById("Condition").innerHTML = cond;
		if(this.assetType == "laptop") {
			document.getElementById("Webcam").innerHTML = "";
			document.getElementById("CPUBrand").innerHTML = "";
			document.getElementById("CPUType").innerHTML = "";
		}	
	}
	
	this.compareAssets = function compareAssets(asset2) {
		if(assetInfo.compareWhat == "HD") {
			this.compareHD(asset2);
		} else {
			this.compareType(asset2);
		}
	}

	this.compareHD = function compareHD(asset2) {
		var type;
		if(this.assetID == "bad") {
			return;
		}
	
		if(this.assetType != asset2.assetType) {
			this.badAsset("Different kind of items.", "currentBoxAssets");
			return;
		} else {
			type = this.assetType;
		}
	
		//Above this is in compareType
		if(this.product != asset2.product) {
			this.badAsset("The product name doesn't match.", "currentBoxAssets");
			return;
		}
		if(this.condition != asset2.condition) {
			this.badAsset("The condition does not match.", "currentBoxAssets");
			return;
		}
		
		
		if(type == "laptop") {
			if(this.condition != asset2.condition) {
				this.badAsset("The condition does not match.","currentBoxAssets");
				return;
			}
		}

		beepAlert.playGood();
	}	
	
	this.compareType = function compareType(asset2) {
		var type;
		if(this.assetID == "bad") {
			return;
		}
		
		if(this.assetType != asset2.assetType) {
			this.badAsset("Different kind of items.", "currentBoxAssets");
			return;
		} else {
			type = this.assetType;
		}

		beepAlert.playGood();
	}
	
	this.badAsset = function badAsset(message, location) {
		location || "";
		
		if(location != "") {
			document.getElementById(location).value = document.getElementById(location).value.replace(this.assetID + '\n','');
		}
		beepAlert.playBad(message);
	}
	
	this.changeCompare = function changeCompare(NewType) {
		assetInfo.compareWhat = NewType;
	}
}


var currentAsset = new assetInfo();
var firstAsset = new assetInfo();


function preCheckAssets(list) {
	list = list.value.replace(/^\s*[\r\n]/gm, "");
	var list = list.split(/\n/);
	if(list[list.length - 1] == "") {list.pop();}
	
	if(list.lenght <= 1) {
		alert('Lessthan1');
		return;
	}
	
	if(list.length > 1)
	{
		var string = "ID="+list[list.length - 1];
		var file = 'selectasset.php';
		var code = 'document.getElementById("transferPreCheck").innerHTML = response;';
		code += 'hideLoading();';
		code +=	'currentAsset.set('+ list[list.length - 1] +'); currentAsset.compareAssets(firstAsset);';
		//code += 'setTransferInformation(asset)';
		//Return what?
		ajax(string, file, code, 'assets');
	} else {
		var string = "ID="+list[0];
		var file = 'selectasset.php';
		var code = 'document.getElementById("transferPreCheck").innerHTML = response;';
		code += 'hideLoading();';
		code +=	'firstAsset.setFirst();';
		//code += 'setTransferInformation(asset)';
		//Return what?
		ajax(string, file, code, 'assets');
		//$("#ProductName").innerHTML = thing;
	}
	
	var first = list[0];
	var last = list[list.length-1];
	//getAssetInfo(first);
}


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
}

var beepAlert = new soundAlert();


function setTransferInformation(element) {
	document.getElementById("ProductName").innerHTML =getElementById("editOrderlineProductSearchText").value;
}

function getAssetInfo(id) {
	var string = "ID="+id
    var file = 'selectasset.php';
    var code = 'var asset = document.createElement("div");';
	code += 'asset.id = "getAssetInfomation";';
	code += 'asset.innerHTML = response;';
	code += 'hideLoading();';
//Return what?
	ajax(string, file, code, 'assets');
}


function clearPage()
{
	document.getElementById("currentBoxResults").innerHTML = "";
	document.getElementById("createLocationResponse").innerHTML = "";
		
	document.getElementById("startLocation").focus();
}

$('#startLocation').keyup(function (event) {
   if (event.keyCode == 13 || event.keyCode == 10) {
		boxCreateLocation();
		document.getElementById("currentBoxAssets").focus();
	}
 });
 
$('#currentBoxAssets').keyup(function (event) {
   if (event.keyCode == 13 || event.keyCode == 10) {
		preCheckAssets(document.getElementById('currentBoxAssets'));
	}
 });
 
  $('#otherTransferLocation').keyup(function (event) {
   if (event.keyCode == 13 || event.keyCode == 10) {
		document.getElementById("otherTransferAssets").focus();
	}
 });
 )
StringReplace, JSText2, JSText2, `t, ,A
RunJavaScriptLong(JSText2)
}

var ajaxCallback = function (func) {
	var wrapper = function() {
		if($("#loadingWrapper").attr('class') == 'hide') {
			observer.disconnect();
			func();
		}
	};
	var observer = new MutationObserver(wrapper);
	observer.observe(document.getElementById("loadingWrapper"), {attributes: true});
}

var Setting = function (id, func, on) {
	var element = $("#" + id);
	if(typeof(func)!='undefined') element.on(on,function{func()});
	return element;
}

Setting.prototype.getValue = function () {
	return element.attr('value');
}
\
//Set these above. Also set functions.
var TransferAssetsForm = function(id) {
	this.id = id;
	this.location = new Setting(id + 'Location');
	this.checkType = new Setting('');
	this.assets  = new Setting(id + 'Assets','keyup',function(){});
	this.results = new Setting(id + 'Results');
	this.count = new Setting(id + 'AssetsCount');
	this.submit = new Setting(id + 'Submit', 'click', function(){});
	this.assetTempLocation = new Setting('');
//Maybe create a div to display first product.
	this.firstAsset;
	this.currentAsset;
}

TransferAssetsForm.prototype.transfer = function() {
	this.location.attr('id') = 'editAssetTransferLocation';
	this.assets.attr('id') = 'editAssetTransferAssets';
	this.results.attr('id') = 'editAssetTransferResults';
	ajaxCallback(this.transferCallback);
	transferAssets();
}
TransferAssetsForm.prototype.transferCallback() {
	this.location.attr('id') = this.id + 'Location';
	this.assets.attr('id') = this.id + 'Assets';
	this.results.attr('id') = this.id + 'Results';
}

//Figure out what to do if first is different.
TransferAssetsForm.prototype.preCheck = function() {
	var list = this.assets.value.replace(/^\s*[\r\n]/gm, "");
	list = list.split(/\n/);
	if(list[list.length - 1] == "") {list.pop();}


	var firstID = list[0];
	if(firstID != this.firstAsset.assetID) {
		//firstAsset.set();
	}

	var string = "ID="+list[list.length - 1];
	var file = 'selectasset.php';
	var code = 'document.getElementById("transferPreCheck").innerHTML = response;';
	code += 'hideLoading();';
	ajaxCallback(function(){this.preCheckCallback()});
	ajax.call(this,string, file, code, 'assets');
}

//Should this be moved?
TransferAssetsForm.prototype.preCheckCallback() {
	var assetID = $("#editAssetID").val();
	if (assetID == 'undefined') {
		this.badAsset("That item doesn't exist or has been deleted.");
		this.assetTempLocation.innerHTML = '';
		return;
	}
		
	var type;
	if (this.checkSimple == true)
		type = "simple";
	else {
		if($("[name='spec10']" != [])) {
			type = "hard drive";
		} else {
			type = "laptop";
		}
	}
			
	if(type == "simple") {
		this.currentAsset = new Asset(assetID,type);
	} else if (type == "hard drive") {
		this.currentAsset = new Product(assetID,type,product,condition);
	} else if (type == "laptop") {
		this.currentAsset = new Laptop(assetID,type,product,condition,attatchedAssets,webcam,CPUType,CPUName,CPUBrand);
	}
	
	if (this.currentAsset.assetID == first) {
		this.firstAsset = this.currentAsset;
	}

	this.assetTempLocation.innerHTML = '';

	var result = this.currentAsset.compare(this.firstAsset);
	if(result == true) {
		this.goodAssetAlert();
	} else {
		this.badAssetAlert(result);
	}
}

TransferAssetsForm.prototype.count function () {
	this.assets.attr('id') = 'editAssetTransferAssets';
	this.count.attr('id')= 'count';
	transferAssetCount();
	this.assets.attr('id') = this.id + 'Assets';
	this.count.attr('id')= this.id + 'Count';
}

TransferAssetForm.prototype.goodAssetAlert = function () {
	beepAlert.playGood();
}

// Make jquery?
TransferAssetForm.protoptype.badAssetAlert = function (message) {
	location = this.assets.attr('id');
	if(location != "") {
		document.getElementById(location).value = document.getElementById(location).value.replace(this.assetID + '\n','');
	}
	beepAlert.playBad(message);
}
	
	
	
	
	
var Asset = function(id,type) {
	this.assetID = id;
	this.assetType = type;
}	
Asset.prototype = {
	assetID: {value: "Asset ID",  writable: true,  enumerable: false,  configurable: true},
	assetType: {value: "Asset Type", writable: true,  enumerable: true,  configurable: true},
	compare: function (asset2) {
		if (!asset2) return false;
		if (this.length != asset2.length) return false;
	
		for ( var p in this ) {
			if(this[p] != asset2[p]) {
				alert(Object.getPrototypeOf(this)[p] + " of the first item is " + this[p] + ". \n" + Object.getPrototypeOf(this)[p] + " of the second item is " + asset2[p] + ".");
				return false;
			}
		}
	}	
}
	
var Product = function (id,type,product,condition) {
	this.product = product || $("#editOrderlineProductSearchText" + assetID).val();
	this.condition = condition || $("[name='test2']").eq(0).val();	
	Asset.apply(this, arguments);
};
Product.prototype = Object.create(Asset.prototype, {
	product: {value: "Product Name",  writable: true,  enumerable: true,  configurable: true},
	condition: {value: "Product Condition",  writable: true,  enumerable: true,  configurable: true}
});

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
	


