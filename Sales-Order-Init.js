SalesOrderInitJS = 
(
$('#dashboardBody').html('<div> \
	Sales Order<br> \
	<div id="addAssetDiv">		 \
		<table id="editSalesOrderlineTable"> \
		<div class="divCell"> \
			Asset Tags<br> \
			<textarea rows="10" cols="30" id="addSalesOrderlineAssets"></textarea>:This would like to count<br> \
			<input value="transfer" type="button"><span id="countAssets"></span>:addSalesOrderLine()<br> \
		</div> \
		<div class="divCell"> \
			Locations/Container<br> \
			<textarea rows="10" cols="30" id="addSalesOrderlineLocations"></textarea> /this would like to count<br> \
			<input value="transfer location" type="button"><span id="countLocations"></span> addSalesOrderLineLocation<br>  \
		</div> \
		<div> \
			/Onkeyup shoudl use searchProductSO() <br> \
			Product: <input id="productText" value="" type="text"> <input id="productID" value="" type="hidden"> </br> \
			<div id="searchProductSOResults"></div> \
			Qty: <input id="qty" value="" type="text"> </br> \
			<input value="add" type="button"> /addSalesOrderLineProduct \
		</div> \
<div> Views<br> \
/Will implement later. \
	<input checked="" name="views" type="radio"> Container /viewSODetailList(469, viewsalesorderdetailcontainer.php)<br> \
	<input name="views" type="radio"> List /viewSODetailList(46, viewsalesorderdetaillist.php)<br> \
	<br><br> \
</div> \
/This should go under the transfer button \
	<div id="addSalesOrderlineResults"></div>  \
	<div id="SOContainerList"> \
	</div> \
</div>');
var beepAlert = new SoundAlert();
)
