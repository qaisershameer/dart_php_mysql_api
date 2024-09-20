<?php 

    include ("dbc.php");

    $con = dbcN();

    $sql = "SELECT `uid`, `uName`, `uEmail`, `uPwd` FROM `users`";

    $exec = mysqli_query($con, $sql);

    $array = [];

    while ($row = mysqli_fetch_array ($exec))
    {
         $array[] = $row;
    }
    
    print(json_encode($array));

?>
