<?php
	switch($varelement[2]){
		case "home" :
			include 'grid/'.$varelement[2].".php";
		break;
		case "posisi" :
			include 'grid/'.$varelement[2].".php";
		break;
		default :
			include 'grid/home.php';
		break;
	}
?>