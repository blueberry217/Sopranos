<?php

// The from email that will appear on the customer's order details email
define('mail_from','');
// Send mail to the customers, etc?
define('mail_enabled',true);

function pdo_connect_mysql() {
    // Update the details below with your MySQL details
    $DATABASE_HOST = 'localhost';
    $DATABASE_USER = 'root';
    $DATABASE_PASS = '';
    $DATABASE_NAME = 'sopranos';
    try {
    	return new PDO('mysql:host=' . $DATABASE_HOST . ';dbname=' . $DATABASE_NAME . ';charset=utf8', $DATABASE_USER, $DATABASE_PASS);
    } catch (PDOException $exception) {
    	// If there is an error with the connection, stop the script and display the error.
    	die ('Failed to connect to database!');
    }
}

// Function to retrieve a product from cart by the ID and options string
function &get_cart_product($id, $options) {
    $p = null;
    if (isset($_SESSION['cart'])) {
        foreach ($_SESSION['cart'] as &$product) {
            if ($product['id'] == $id && $product['options'] == $options) {
                $p = &$product;
                return $p;
            }
        }
    }
    return $p;
}

// Send order details email function
function send_order_details_email($email, $products, $first_name, $last_name, $address_street, $address_city, $address_zip,  $subtotal, $order_id) {
    if (!mail_enabled) {
        return;
    }
	$subject = 'Order Details';
	$headers = 'From: ' . mail_from . "\r\n" . 'Reply-To: ' . mail_from . "\r\n" . 'Return-Path: ' . mail_from . "\r\n" . 'X-Mailer: PHP/' . phpversion() . "\r\n" . 'MIME-Version: 1.0' . "\r\n" . 'Content-Type: text/html; charset=UTF-8' . "\r\n";
    ob_start();
    include 'order-details-template.php';
    $order_details_template = ob_get_clean();
	mail($email, $subject, $order_details_template, $headers);
}

?>