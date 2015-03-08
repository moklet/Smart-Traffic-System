<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Smart Traffic System</title>
	<link href="<?php echo SITE_CSS; ?>/bootstrap.min.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/styles.css" rel="stylesheet">
</head>
<body>
	<div class="col col-xs-12" style="text-align:center">
		<h1>SMART TRAFFIC SYSTEM</h1>
		<div class="pin">
			<form method="post" autocomplete="off" action="/parking/checkpin/" id="pin">
				<input type="text" class="pin" size="4" maxlength="4" name="pin">
			</form>
		</div>
		<div class="number">
			<button value="A">A</button><button value="B">B</button><button value="C">C</button><br/>
			<button value="1">1</button><button value="2">2</button><button value="3">3</button><br/>
			<button value="4">4</button><button value="5">5</button><button value="6">6</button><br/>
			<button value="7">7</button><button value="8">8</button><button value="9">9</button><br/>
			<button value="D">DEL</button><button value="0">0</button><button value="G">GO</button><br/>
		</div>
	</div>
	<script src="<?php echo SITE_JS; ?>/jquery.min.js"></script>
	<script>
		$("button").click(function(){
			if($(this).val() == "D"){
				$(".pin").val($(".pin").val().slice(0,-1));
			}else if($(this).val() == "G"){
				if($(".pin").val().length == 4 ){
					$("#pin").submit();
				}
			}else{
				if($(".pin").val().length < 4 ){
					$(".pin").val($(".pin").val()+$(this).val());
				}
			}
		});
	</script>
</body>
</html>