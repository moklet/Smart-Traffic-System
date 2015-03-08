<?php
	$varelement = explode('/', $alias);		
	switch($varelement[1]){
		case "home" :
		case "check-login" :
		case "dashboard" :
		case "logout" :
		case "registerForm" :
		case "registerInsert" :
		case "getTypeMerk" :
		case "testMediaTrac" :
		case "api" :
		case "parking" :
		case "maps" :
		case "grid" :
			include $varelement[1].".php";
		break;
		default :
			include "login.php";
		break;
	}
?>