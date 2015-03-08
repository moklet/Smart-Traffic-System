<?php
	$sql = "select * from posisi";
	$data 	= $DB->getData($sql);
$url = "https://api.bigdataindonesia.com/poi/";
$method = "textsearch";
$output = "json";

$url = "https://api.bigdataindonesia.com/poi/nearby/json?lat=-6.235940&lng=106.827736&rad=0.1";
$data = array('key' => '2e5fac8d78789ecd9b12dee27d553e51');
$options = array(
	'http' => array(
		'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
		'method'  => 'POST',
		'content' => http_build_query($data),
	),
);
$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);
$rs = simplexml_load_string($result);
$json = json_decode($result,true);
$data = $json['result'];
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Smart Traffic System</title>
	<link href="<?php echo SITE_CSS; ?>/bootstrap.min.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/styles.css" rel="stylesheet">
</head>
<body>
	<div class="col col-xs-12 no-padding">
		<div class="map-area" id="map-canvas" style="height:680px"></div>
	</div>
	<div style="position:absolute;right:10px;top:10px;background:#fff;padding:5px;width:300px;height:400px;overflow-y:auto">
		<h4>Nearby Your Position</h4>
		<?php foreach($data as $data){ ?>
		<div class="nearby" data-coordinate="<?php echo $data['latitude'].", ".$data['longitude']; ?>" data-name="<?php echo $data['name']; ?>" data-address="<?php echo $data['address']; ?>" style="border-bottom:1px solid #000">
			<?php echo $data['name']; ?><br/>
			<?php echo $data['address']; ?>
		</div>
		<?php } ?>
	</div>
<script src="<?php echo SITE_JS; ?>/jquery.min.js"></script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?libraries=visualization&sensor=true_or_false&v=3.exp&signed_in=true">
</script>
<script>
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var map;

function initialize() {
	directionsDisplay = new google.maps.DirectionsRenderer();
	var chicago = new google.maps.LatLng(-6.206887, 106.829324);
	var mapOptions = {
		zoom:15,
		center: chicago
	}
	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
	var trafficLayer = new google.maps.TrafficLayer();
	trafficLayer.setMap(map);
	directionsDisplay.setMap(map);
	calcRoute();
}

function calcRoute() {
  var start = "-6.235940, 106.827736";
  var end = "-6.226384, 106.832950";
  var request = {
	  origin:start,
	  destination:end,
	  travelMode: google.maps.TravelMode.DRIVING
  };
  directionsService.route(request, function(response, status) {
	if (status == google.maps.DirectionsStatus.OK) {
	  directionsDisplay.setDirections(response);
	}
  });
}

google.maps.event.addDomListener(window, 'load', initialize);

function setmarker(coor,name,address){
	var contentString= name+"<br/>"+address;
	
	var infowindow = new google.maps.InfoWindow({
      content: contentString
	});
	
	var res = coor.split(",");
	var marker = new google.maps.Marker({
		position: new google.maps.LatLng(res[0],res[1]),
		map: map,
		title: name
	});
	google.maps.event.addListener(marker, 'click', function() {
		infowindow.open(map,marker);
	});
}

$(".nearby").click(function(){
	setmarker($(this).attr('data-coordinate'),$(this).attr('data-name'),$(this).attr('data-address'));
});
</script>
</body>
</html>