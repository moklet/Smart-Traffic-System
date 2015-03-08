<?php
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
echo $json['result'];
?> 