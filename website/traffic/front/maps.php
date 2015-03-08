<?php
	switch($varelement[2]){
		case "home" :
			include 'maps/'.$varelement[2].".php";
		break;
		case "erp" :
			include 'maps/'.$varelement[2].".php";
		break;
		default :
			include 'maps/home.php';
		break;
	}
?>