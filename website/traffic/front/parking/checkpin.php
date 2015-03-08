<?php 
	$key = mysql_real_escape_string($_POST['pin']);
	$sql = "select * from pengguna where kata_sandi = '".$key."' limit 0,1";
	$data 	= $DB->getData($sql);
	if($data != null){
		echo "<script>alert('Open');</script>";
	}else{
		echo "<script>alert('Invalid');</script>";
	}
	echo "<script>window.location.href='/parking';</script>";
?>