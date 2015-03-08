<?php
class DB 
{
	function DB($hostname,$username,$dbname,$dbpass)
    {
        $this->hostname = $hostname;
		$this->username = $username;
		$this->dbname = $dbname;
		$this->dbpass = $dbpass;
		$this->date = date("M")."_".date("d")."_".date("Y");
    }

	function connectDB()
	{
		$con = mysql_connect ($this->hostname, $this->username, $this->dbpass)
			or die($this->errorHandling());
		$db = mysql_select_db ($this->dbname);
		return $con;
	}
	
	function getData($query)
	{
		$query = $query;
		$hasil = mysql_query($query)
			or die(mysql_error());
		$columns = mysql_num_fields($hasil);
		$count = mysql_num_rows($hasil);
		$x=0;
		if($count > 0)
		{
			while($rs=mysql_fetch_array($hasil))
			{
				for($i = 0; $i < $columns; $i++) 
				{
					$data[$x][mysql_field_name($hasil,$i)] = $rs[mysql_field_name($hasil,$i)];				
				}  
				$x++;
			}
			return $data;
		}
		else
			return 0;
	}
	
	function Query($query)
	{
		if(mysql_query($query))
		{
			return 1;
		}
		else
			return 0;
	}
}
?>