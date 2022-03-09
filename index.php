<?php

// Initialize a new session
session_start();

// Include functions and connect to the database using PDO MySQL
include 'includes/functions.php';

// Connect to MySQL database
$pdo = pdo_connect_mysql();

// Page is (home.php) not (index.php) this can be used as a function page
$page = isset($_GET['page']) && file_exists($_GET['page'] . '.php') ? $_GET['page'] : 'home';

// Include and show the requested page
include $page . '.php';

?>

