<?php
$id 	 = mysql_real_escape_string($_POST['idposisi']);
$lat 	 = mysql_real_escape_string($_POST['lat']);
$long 	 = mysql_real_escape_string($_POST['long']);
$speed   = mysql_real_escape_string($_POST['speed']);
$rumah_long  = mysql_real_escape_string($_POST['rumah_long']);
$rumah_lat   = mysql_real_escape_string($_POST['rumah_lat']);
$kantor_long  = mysql_real_escape_string($_POST['kantor_long']);
$kantor_lat   = mysql_real_escape_string($_POST['kantor_lat']);
//$id  	= "5";$lat 	= "-6.235940";$long   = "106.827736";$speed  = "40";
//rumah_lat  = "12.3123";rumah_long = "121.3123";
//kantor_lat  = "12.3123";kantor_long = "121.3123";
if($varelement[3] == "home"){
	if($rumah_lat!="" || $rumah_long!=""){
		$sql = "update posisi set posisi_rumah_lat = '".$rumah_lat."',posisi_rumah_long = '".$rumah_long."' where id_posisi = '".$id."' ";
		$data 	= $DB->Query($sql);
		echo json_encode($data);
	}
	else{
		echo json_encode(array("message"=>"error"));
	}
}
else if($varelement[3] == "office"){
	if($kantor_lat!="" || $kantor_long!=""){
		$sql = "update posisi set posisi_kantor_lat = '".$kantor_lat."',posisi_kantor_long = '".$kantor_long."' where id_posisi = '".$id."' ";
		$data 	= $DB->Query($sql);
		echo $sql;
		echo json_encode($data);
	}
	else{
		echo json_encode(array("message"=>"error"));
	}
}else{
	if($id!="" || $lat!="" || $long!="" || $speed!=""){
		$sql = "update posisi set posisi_terkini_lat = '".$lat."',posisi_terkini_long = '".$long."',kecepatan_terkini = '".$speed."', waktu_posisi_terkini = '".date("Y-m-d H:i:s")."' where id_posisi = '".$id."' ";
		$show 	= $DB->Query($sql);
		echo json_encode($show);
		
		$lat1 = $lat;
		$lon1 = $long;
		$lat2 = "-6.235940";
		$lon2 = "106.827736";
		$theta = $lon1 - $lon2; 
		$dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * cos(deg2rad($theta)); 
		$dist = acos($dist); 
		$dist = rad2deg($dist); 
		$miles = substr($dist * 60 * 1.1515 * 1.60934,0,5) * 1000;
		
		$sql_data = "select * from pengguna where id_pengguna = ".$id;
		
		$data_saldo = $DB->getData($sql_data);
		$saldo = $data_saldo[0]['saldo_delima'];
		if((int)$miles < 50){
			$newsaldo = $saldo - 20000;
			$sqlupdate = "update pengguna set saldo_delima = '".$newsaldo."' where id_pengguna = ".$id;
			$DB->Query($sqlupdate);
		}
	}else{
		echo json_encode(array("message"=>"error"));
	}
}
?>