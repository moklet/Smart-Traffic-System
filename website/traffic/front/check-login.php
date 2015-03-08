<?php 
	if(!empty($_POST)){
		$user = mysql_real_escape_string($_POST['username']);
		$pass = md5(mysql_real_escape_string($_POST['password']));
		$sql = "select * from login where username = '".$user."' and password = '".$pass."' and active = 0 limit 0,1";
		$data 	= $DB->getData($sql);
		if(!empty($data)){			
			$DB->Log("login");
			$_SESSION['sts']['userid'] = $data[0]['login_id'];
			$_SESSION['sts']['username'] = $data[0]['username'];
			echo "<script>window.location.href='/dashboard';</script>";
		}
		else echo "<script>window.location.href='/';</script>";
	}else echo "<script>window.location.href='/';</script>";
?>