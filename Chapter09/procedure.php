<?
$mysqli = mysqli_connect("localhost","mkruck01","kramer2000","shop");

if (mysqli_connect_errno()) {
	printf("Failed to connect: %s\n", mysqli_connect_error());
   	exit();
}

if ($result = $mysqli->query("call get_customers()")) {
	printf("%d records found\n",$result->num_rows);
	while ($row = $result->fetch_row()) {
	     printf("%d - %s\n",$row[0],$row[1]);
	}
}
else {
	echo $mysqli->error,"\n";
}
$mysqli->close();
?>

<?
$mysqli = mysqli_connect("localhost","mkruck01","kramer2000","shop");

if (mysqli_connect_errno()) {
   printf("Failed to connect: %s\n", mysqli_connect_error());
   exit();
}
$old_customer = 1;
$new_customer = 4;

$mysqli->query("call merge_customers($old_customer,$new_customer,@error)");

$result = $mysqli->query("select @error");
if ($result->num_rows) {
	while ($row = $result->fetch_row()) {
	     printf("%s\n",$row[0]);
	}
}
else {
	print "Customer merge successful";
}

$mysqli->close();
?>

