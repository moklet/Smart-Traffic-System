<?php 
	if(empty($varelement[2])) echo '<option value="">Choose One</option>';
	$sql = "select * from tipe_merek where id_merek = '".$varelement[2]."' ";
	$data 	= $DB->getData($sql);
	if(!empty($data)){ 
		foreach($data as $data){
?>
			<option value="<?php echo $data['id_tipe_merek']; ?>"><?php echo $data['nama_tipe_merek']; ?></option>
<?php 
		}
	}else{
		echo '<option value="">Choose One</option>';
	} 
?>