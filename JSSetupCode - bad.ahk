SetupIMSPage() 
{
BlockOff()
	If (!WinActive("ahk_group NOIMS")){
		Alert("Can't set-up IMS; this is not an IMS page. (I'm pretty sure) ")
		BlockOff()
		Exit
	}
	
	;;Not needed?
	If(WinActive("ahk_group NOIMSChrome"))
		StyleText =
		(
	CDiv.style.height = "0px";
	CDiv.style.position = "fixed";
	CDiv.style.top = "1em";
		)
	Else
		StyleText =
		(
	CDiv.style.height = "0px";
	CDiv.style.overflow = "hidden";
	CDiv.style.position = "fixed";
	CDiv.style.top = "1em";
		)
	
	JSText = 
	(
	window.addEventListener('keydown',function(e){if(e.keyIdentifier=='U+0008'||e.keyIdentifier=='Backspace'){if(e.target==document.body||e.target.type=="radio"){ e.preventDefault();}}},true);
	var CDiv = document.createElement('div');
	var txtarea = document.createElement('textarea');
	txtarea.id = 'ScriptSearchTextArea';
	var txt = document.createTextNode('ScriptSearch');
	var butt = document.createElement('button');

	txtarea.id = "ScriptSearchTextArea";
	butt.innerHTML = "Enter";
	butt.setAttribute("onClick", "eval(document.getElementById('ScriptSearchTextArea').value);");

	CDiv.appendChild(txt);
	CDiv.appendChild(txtarea);
	CDiv.appendChild(butt);
	//StyleText In Percentage signs.
	CDiv.style.zIndex = "-1";
	CDiv.style.position = "fixed";
	CDiv.style.top = "1em";
	document.getElementsByTagName("body")[0].insertBefore(CDiv,document.getElementsByTagName("body")[0].getElementsByTagName('div')[0]);

$(window).keydown(function(event) {
  if(event.shiftKey && event.ctrlKey && event.keyCode == 89) {
		eval(document.getElementById('ScriptSearchTextArea').value);
		event.preventDefault(); 
		return;
  }
  if(event.ctrlKey && event.keyCode == 89) { 
    document.getElementById("ScriptSearchTextArea").focus();
    event.preventDefault(); 
  }
 });
document.title = 'IMS';
	)
	
	TempClip := clipboard
	Sleep, 300
	clipboard = %JSText%
	Sleep, 300
	If(WinActive("ahk_group NOIMSChrome"))
	{
		If (!WinActive(,"Developer Tools - http://63.253.103.78/ims/dashboard.php"))
			Send ^+j
		BlockOff()
		WinWait,,Developer Tools - http://63.253.103.78/ims/dashboard.php
		Sleep, 1000
		BlockOn()
		Send ^v
		Send {Enter}
		Send ^+j
		WinWaitNotActive,,Developer Tools - http://63.253.103.78/ims/dashboard.php
	} Else {
		Send +{F4}
		BlockOff()
		WinWaitActive, Scratchpad
		BlockOn()
		Sleep, 1000
		Send ^v
		Send ^r
		
		WinWaitActive, *Scratchpad
		Send !{F4}
		WinWaitActive, Unsaved Changes
		Send !n
		WinWaitNotActive, Unsaved Changes
		WinWaitActive, IMS - Mozilla Firefox
		Sleep, 1000
	}
	clipboard := TempClip
	Sleep, 300
	
	ImproveIMSText =
	(
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
			wnd.document.getElementsByClassName("printButton")[0].remove();
			wnd.print();
		}
    }}
function addOrderLine(){
    var product = document.getElementById('addAssetProductID').value;        
    var order = document.getElementById('orderID').value;
    var qty = document.getElementById('addOrderlineQTY').value;
    var sn = document.getElementById('addOrderlineSN').value;
    var location = document.getElementById('addOrderlineLocation').value;
    var desc = document.getElementById('addAssetProductSearchText').value;
    var string = "product="+product+"&order="+order+"&qty="+qty+"&sn="+sn+"&location="+location+"&desc="+desc;
    var file = 'addorderline.php';
    var code = '';
    code += 'if(response != "Re-enter location key" && response != "SN exists. No duplicate SN allowed."){';           
    code +=     "document.getElementById('addAssetProductID').value = '';";
    code +=     "document.getElementById('addOrderlineQTY').value = '';";
    code +=     "document.getElementById('addOrderlineSN').value = '';";
    code +=     "document.getElementById('addOrderlineLocation').value = '';";
    code +=     "document.getElementById('addAssetProductSearchText').value = '';";
    code +=     "document.getElementById('addOrderLineResult').value = '';";       
    code +=     "table = document.getElementById('orderlineTable');";
    code +=     "var rowCount = table.rows.length;";
    code +=     "var row = table.insertRow(1);";
    code +=     'row.className = "line";';
    code +=     "row.innerHTML = response;"; 
    code +=     "var item = $(row).find('.detailLink');";    
    code +=     "$(item)[0].click();"; 
    code +=     "var item = $(row).find('.printLink');";    
    code +=     "$(item)[0].click();";       
	code +=		'document.getElementById("addOrderLineResult").innerHTML = "";';
	code +=		'window.skipHide = true;';
    code += '}';     
    code += 'else{';
    code +=     'document.getElementById("addOrderLineResult").innerHTML = response;';  
    code += '}'; 
    ajax(string, file, code, 'po');}
function editOrderline(id, e){
    //alert($(this).closest("tr")[0].rowIndex);
    var row = $(e).closest("tr")[0];
    var index = $(e).closest("tr")[0].rowIndex;
    var table = $(e).closest("table")[0];
    var string = "ID="+id;
    $("tr").removeClass('selected');
    $(row).addClass('selected');
    function addRow(){
        var file = 'selectasset.php';
        var code = "$('.orderlineAssetDetail').html(response);";
        $(row).after("<tr class='edit'><td class='container orderlineAssetDetail' colspan='8'></td></tr>");
        var response = ajax(string, file, code, 'assets');
    }
    if(!$('.edit')[0]){
        addRow();
    }
    else{

        if($('.edit')[0].rowIndex - 1 == parseInt(index)){
            $('.edit')[0].remove();
            $("tr").removeClass('selected');
        }
        else{   
            $('.edit').remove();         
            addRow();            
        }
    }
}

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
function editOrderline(id, e){
    //alert($(this).closest("tr")[0].rowIndex);
    var row = $(e).closest("tr")[0];
    var index = $(e).closest("tr")[0].rowIndex;
    var table = $(e).closest("table")[0];

    var string = "ID="+id;

    $("tr").removeClass('selected');
    $(row).addClass('selected');

    function addRow(){
        var file = 'selectasset.php';
        //var code = "$('.orderlineAssetDetail').html(response);";
        //$(row).after("<tr class='edit'><td class='container orderlineAssetDetail' colspan='8'></td></tr>");

        var response = ajax(string, file, function(response){            
            $(row).after("<tr class='edit'><td class='container orderlineAssetDetail' colspan='8'></td></tr>");
            $('.orderlineAssetDetail').html(response);
			$('#editOrderlineExternalAsset').focus().val($('#editOrderlineExternalAsset').val());				
        }, 'assets');
    }

    if(!$('.edit')[0]){
        addRow();
    }
    else{

        if($('.edit')[0].rowIndex - 1 == parseInt(index)){
            $('.edit')[0].remove();
            $("tr").removeClass('selected');
        }
        else{   
            $('.edit').remove();         
            addRow();            
        }
    }
}
	)

	StringReplace, ImproveIMSText, ImproveIMSText, `t, ,A
	RunJavaScriptLong(ImproveIMSText)

ImproveIMSText =
(
function saveAsset(asset){
    var testsRadio = $('#tests'+asset+' input:radio'); 
    var partsInput = $('#parts'+asset+' input:text');
    var customFields = $('#customFieldsTable'+asset+' input:text');    
    var sn = document.getElementById('editOrderlineSN'+asset).value;  
    var productid = document.getElementById('editOrderlineProductID'+asset).value; 
    var scrapped = document.getElementById('editOrderlineScrapped'+asset).checked;
    var externalAsset = document.getElementById('editOrderlineExternalAsset').value; 
    var tests = '';
    var parts = '';
    var specs = '';
    var fields = '';

    if(scrapped === true){
        scrapped = 1;
    }else{
        scrapped = 0;
    }

    for(var i=0; i<testsRadio.length; i++) {
        var value = testsRadio[i].value;
        var name = testsRadio[i].name.replace('test', '');
        var checked = testsRadio[i].checked;
        if(checked == true){
            if (tests.length > 0){
                tests = tests +";"
            }
            tests = tests + name +":"+value;
        }
    }
    
    for(var i=0; i < partsInput.length; i++) {        
        var name = partsInput[i].name;
        var value = partsInput[i].value;
        if (parts.length > 0){
            parts = parts +";"
        }
        parts += name +":"+ value;
    }

    for(var i=0; i < customFields.length; i++) {        
        var value = customFields[i].value;
        var id = customFields[i].id;
        if (fields.length > 0){
            fields = fields +";";
        }
        fields += value +":"+ id;
    }    
    
//-----------specs start ---------------------------
    var specsRadio = $('#specs'+asset+'  input:radio');
    var specsSelect = $('#specs'+asset+'  select');
    var specsShort = $('#specs'+asset+'  input:text.short');
    var specsLong = $('#specs'+asset+'  textarea');
    var specsSearch = $('#specs'+asset+'  input:hidden.search');

    for(var i=0; i<specsRadio.length; i++) {
        var value = specsRadio[i].value;
        var name = specsRadio[i].name.replace('spec', '');
        var checked = specsRadio[i].checked;
        if(checked == true){
            if (specs.length > 0){
                specs = specs +";"
            }
            specs = specs + name +":"+value;
        }
    }
    
    for(var i=0; i<specsSelect.length; i++) {
        var value = specsSelect[i].value;
        var name = specsSelect[i].name.replace('spec', '');
        
        if (specs.length > 0){
            specs = specs +";"
        }
        specs = specs + name +":"+value;
        
    }

    for(var i=0; i<specsShort.length; i++) {
        var value = specsShort[i].value;
        var name = specsShort[i].name.replace('spec', '');
        
        if (specs.length > 0){
            specs = specs +";"
        }
        specs = specs + name +":"+value;
        
    }

    for(var i=0; i<specsLong.length; i++) {
        var value = specsLong[i].value;
        var name = specsLong[i].name.replace('spec', '');
        
        if (specs.length > 0){
            specs = specs +";"
        }
        specs = specs + name +":"+value;
        
    }

    for(var i=0; i<specsSearch.length; i++) {
        var value = specsSearch[i].value;
        var name = specsSearch[i].name.replace('spec', '');
        
        if (specs.length > 0){
            specs = specs +";"
        }
        specs = specs + name +":"+value;
        
    }
    
//-----------specs end -----------------------------
    
    var string = "id="+asset + "&specs="+specs+"&tests=" + tests + "&sn=" + sn + "&externalAsset=" + externalAsset + "&parts=" + parts + "&fields=" + fields + "&scrapped=" + scrapped + "&productid=" + productid;
    

    var file = 'saveasset.php';
    
    var code = "$('.editOrderlineResult"+asset+"').html(response);";
    code +=    "checkCondition(document.getElementById('editOrderlineAssetTag"+asset+"').value);";
    code +=    "var externalAsset = $('#customFieldsTable"+asset+" #2');";      
    code +=    "if(externalAsset.length == 1){";           
    code +=        "checkExternalAsset(externalAsset[0].value, document.getElementById('editOrderlineAssetTag"+asset+"').value);";
    code +=    "}";

    ajax(string, file, function(response){
        $('.editOrderlineResult'+asset).html(response);
        checkCondition(asset);
        checkExternalAsset(externalAsset, asset);
		var string = 'id='+asset;
		var file = 'saveorderlineassetcondition.php';
		var code = '$("#'+asset+'G").html(response);';
		ajax(string, file, code, 'po');
        $('#addAssetProductSearchText').focus();    
    }, 'assets');
}
)
	
	StringReplace, ImproveIMSText, ImproveIMSText, `t, ,A
	RunJavaScriptLong(ImproveIMSText)
BlockOff()
}
