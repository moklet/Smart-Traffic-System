<?php
	$varelement = explode('/', $alias);		
	if( $uri== URI.'index.php' || $uri== URI ){
		include "home.php";
	}else{
		switch($varelement[1]){
			case "home" :
            case "parking" :
            case "detailparking" :
                include $varelement[1].".php";
                break;
            case "login" :
                include $varelement[1].".php";
                break;
			default :
				include "home.php";
			break;
		}
	}
?>