<?php
include '../connect.php';
$log_id=$_POST['log_id'];
$event_name=$_POST['event_name'];
$email=$_POST['email'];
$no_of_people=$_POST['no_of_people'];
$amount=$_POST['amount'];
$date=$_POST['date'];
$place=$_POST['place'];
$sql=mysqli_query($con,"INSERT into events(log_id,event_name,email,no_of_people,amount,date,place) values ('$log_id','$event_name','$email','$no_of_people','$amount','$date','$place')");
if ($sql) {
$myarray['result']='success';
}
else
{
    $myarray['result']='failed';
}
echo json_encode($myarray);
?>