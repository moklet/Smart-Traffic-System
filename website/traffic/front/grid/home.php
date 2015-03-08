<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Smart Traffic System</title>
	<link href="<?php echo SITE_CSS; ?>/bootstrap.min.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/styles.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/jquery.dataTables.min.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/datatables.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/datatables-adv.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/jquery-ui.css" rel="stylesheet">
</head>
<body id="home">
<?php 
	$sql = "select * from posisi pos, pengguna p where pos.id_pengguna = p.id_pengguna order by p.id_pengguna ASC";
	$data 	= $DB->getData($sql);
?>
<section id="content">
<div class="dashboard col col-xs-12">
	<div class="container">
		<div class="header">Data User</div>
		<div class="for-table">
			<table id="table" class="table table-striped table-bordered">
			<thead>
				<tr>
					<td>User ID</td>
					<td>Full Name</td>				
					<td>Birth Date</td>			
				</tr>
			</thead>
			<tbody>
			<?php foreach($data as $data) {?>
				<tr>
					<td><?php echo $data['idcardno']; ?></td>
					<td><?php echo $data['nama_lengkap']; ?></td>
					<td><?php echo $data['tgl_lahir']; ?></td>
				</tr>
			<?php } ?>
			</tbody>
			</table>
		</div>
	</div>
</div>
</section>
<section id="footer">
<div class="container col-xs-12">
	copyright &copy <?php echo date('Y'); ?>
</div>
<div class="clear"></div>
</section>
	<script src="<?php echo SITE_JS; ?>/jquery.min.js"></script>
	<script src="<?php echo SITE_JS; ?>/bootstrap.min.js"></script>
	<script src="<?php echo SITE_CSS; ?>/jquery-ui.js"></script>
	<script src="<?php echo SITE_JS; ?>/datatables.js"></script>
	<script src="<?php echo SITE_JS; ?>/datatables-adv.js"></script>
	<script src="<?php echo SITE_JS; ?>/general.js"></script>
</body>
</html>