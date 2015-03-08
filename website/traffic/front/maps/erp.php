<?php
function distance($lat1, $lon1, $lat2, $lon2) { 
 $theta = $lon1 - $lon2; 
 $dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * cos(deg2rad($theta)); 
 $dist = acos($dist); 
 $dist = rad2deg($dist); 
 $miles = substr($dist * 60 * 1.1515 * 1.60934,0,5) * 1000;
 $unit = strtoupper($unit);
 return $miles;
}
echo distance(-6.231747, 106.832566, -6.230928, 106.832869);
?>