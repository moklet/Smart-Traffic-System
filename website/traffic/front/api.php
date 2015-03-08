<?php
	switch($varelement[2]){
		case "login" :
		case "insert-coordinate" :
		case "place-coordinate" :
			include 'api/'.$varelement[2].".php";
		break;
		default :
			echo json_encode(array("message"=>"invalid request url"));die;
		break;
	}
?>