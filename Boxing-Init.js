var beepAlert = new SoundAlert();
//This loads the objects above. 
var loca = $('#currentLocationLocation');
var currentLocation = new CurrentLocation("currentLocation"); //On change
loca.attr('id', 'createLocationLocation');
var createLoc = new CreateLocation("createLocation");  //Sets the location
loca.attr('id', 'currentBoxLocation');
var currentBox = new TransferAssetsForm("currentBox", beepAlert); //Gets location
loca.attr('id', 'currentLocationLocation');
var otherTransfer = new TransferAssetsForm("otherTransfer", beepAlert);