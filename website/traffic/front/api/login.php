<?php
$user 	 = mysql_real_escape_string($_POST['username']);
$birth 	 = mysql_real_escape_string($_POST['birthdate']);
$license = mysql_real_escape_string($_POST['licensenumber']);
//$user = "edof0703";$birth = "1997-03-07";$license = "B1234BAS";
if($user!="" || $birth!="" || $license!=""){
	$sql = "select p.*, pos.id_posisi as id_posisi from pengguna p, posisi pos where nama_pengguna = '".$user."' and tgl_lahir = '".$birth."' and no_plat = '".$license."' and p.id_pengguna = pos.id_pengguna and active = 0 limit 0,1";
	$data 	= $DB->getData($sql);
	echo json_encode($data);
}else{
	echo json_encode(array("message"=>"error"));
}
?>