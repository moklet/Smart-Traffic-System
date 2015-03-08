<?php 
	include('includes/header.php'); 
	$sql = "select * from pengguna order by nama_lengkap ASC";
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
<?php include('includes/footer.php');?>