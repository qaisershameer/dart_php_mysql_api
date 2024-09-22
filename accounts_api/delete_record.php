<?php 

    include ("dbc.php");

    $con = dbcN();

    if (isset($_POST["uid"]))
    {
        $uid = $_POST["uid"];
    }
    else return;

    $sql = "DELETE FROM `users` WHERE `uid`= '$uid'";

    $exec = mysqli_query($con, $sql);

    $array = [];

    if ($exec)
        {
            $array ["success"] = "true";
        }
    else
        {
            $array ["success"] = "false";
        }

    print(json_encode($array));

?>
