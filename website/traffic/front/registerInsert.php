<?php 
	$id 		= mysql_real_escape_string(strip_tags($_POST['id']));
	$name 		= mysql_real_escape_string(strip_tags($_POST['name']));
	$datebirth 	= mysql_real_escape_string(strip_tags($_POST['datebirth']));
	$sex 		= mysql_real_escape_string(strip_tags($_POST['sex']));
	$vtype		= mysql_real_escape_string(strip_tags($_POST['vtype']));
	$merk 		= mysql_real_escape_string(strip_tags($_POST['merk']));
	$merktype 	= mysql_real_escape_string(strip_tags($_POST['merktype']));
	$color 		= mysql_real_escape_string(strip_tags($_POST['color']));
	$platnomor 	= strtoupper(mysql_real_escape_string(strip_tags(str_replace(" ","",$_POST['platnomor']))));
	$expbirth   = explode("-",$datebirth);
	$katasandi  = $DB->generateKey();
	$namapengguna = substr(str_replace(" ","",$name),0,4).$expbirth[2].$expbirth[1];
	$sql = "insert into pengguna (idcardno, nama_lengkap, tgl_lahir, jenis_kelamin, id_jenis_kendaraan, id_merek, id_tipe_merek, warna_kendaraan, no_plat, nama_pengguna,kata_sandi) values 
	('".$id."','".$name."','".$datebirth."','".$sex."','".$vtype."','".$merk."','".$merktype."','".$color."','".$platnomor."','".$namapengguna."','".$katasandi."')";
	$data 	= $DB->Query($sql);
	$sql = "select * from pengguna where kata_sandi = '".$katasandi."' limit 0,1";
	$data 	= $DB->getData($sql);
	$sql = "insert into posisi (id_pengguna) values ('".$data[0]['id_pengguna']."')";
	$data 	= $DB->Query($sql);
	if($data){
		$_SESSION['error'] = "registration success";
	}else{
		$_SESSION['error'] = "registration failed";
	}
	echo "<script>window.location.href='/registerForm';</script>";
?>