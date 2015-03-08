<?php
    $harga_parkir = 5000;
	$key = mysql_real_escape_string($_POST['pin']);
	$sql = "select * from pengguna where kata_sandi = '".$key."' limit 0,1";
	$data 	= $DB->getData($sql);
//print_r($data);
    $datenow = date("Y-m-d H:i:s");
	if($data != null){
        if($data[0]['log_parkir_status'] == 0){
            $sql_status = "update pengguna set log_parkir_status = 1, waktu_parkir = '".$datenow."' where id_pengguna = ".$data[0]['id_pengguna'];
            //echo $sql_status;
            $run_log = mysql_query($sql_status) or die(mysql_error());
            echo "<script>alert('Mobil telah terdaftar');</script>";
        }else{
            $sqllast = "select * from pengguna where id_pengguna = ".$data[0]['id_pengguna'];
            $datalast 	= $DB->getData($sqllast);

            $datelast = $datalast[0]['waktu_parkir'];
            $saldolast = $datalast[0]['saldo_delima'];
            //echo $datelast." ".$datenow;

            $dteStart = new DateTime($datelast);
            $dteEnd   = new DateTime($datenow);
            $dteDiff  = $dteStart->diff($dteEnd);

            $howlong = $dteDiff->format("%H");
            if($howlong == 0)
                $howlong = 1;

            $totalparkir = $howlong * $harga_parkir;
            $saldonew = $saldolast - $totalparkir;
            //echo $totalparkir."".$saldonew;
            $sql_status = "update pengguna set log_parkir_status = 0, waktu_parkir = '', saldo_delima = '".$saldonew."' where id_pengguna = ".$data[0]['id_pengguna'];
            $run_log = mysql_query($sql_status) or die(mysql_error());
            echo "<script>alert('Lama parkir = ".$howlong." jam');</script>";
        }
        //echo "<script>alert('Open');</script>";
	}else{
		echo "<script>alert('Invalid');</script>";
	}
	echo "<script>window.location.href='/parking';</script>";
?>