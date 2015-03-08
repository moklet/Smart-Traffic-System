<?php
	switch($varelement[2]){
		case "home" :
		case "checkpin" :
			include 'parking/'.$varelement[2].".php";
		break;
		default :
			include 'parking/home.php';
		break;
	}
?>