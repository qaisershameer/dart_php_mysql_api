<?php

    include ("dbc.php");

    $con = dbcN();

    if (isset($_POST["name"]))
    {
        $name = $_POST["name"];
    }
    else return;

    if (isset($_POST["email"]))
    {
        $email = $_POST["email"];
    }
    else return;

    if (isset($_POST["pwd"]))
    {
        $pwd = $_POST["pwd"];
    }
    else return;

    $sql = "INSERT INTO `users`(`uName`, `uEmail`, `uPwd`) VALUES ('$name','$email','$pwd')";

    $exec = mysql_query($con, $sql);

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
