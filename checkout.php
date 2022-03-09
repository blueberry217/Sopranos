<?php

include 'includes/header.php';

// Default values for the input form elements
$account = [
    'first_name' => '',
    'last_name' => '',
    'address_street' => '',
    'address_city' => '',
    'address_zip' => ''
];

// Make sure when the user submits the form all data was submitted and shopping cart is not empty
if (isset($_POST['first_name'], $_POST['last_name'], $_POST['address_street'], $_POST['address_city'], $_POST['address_zip'], $_SESSION['cart'])) {
   
        // Process the order
        $products_in_cart = isset($_SESSION['cart']) ? $_SESSION['cart'] : [];
        $subtotal = $new_product_price = 0.00;
        $discounttotal = 0.00;
        $roundttotal = 0.00;
        
        // If there are products in cart
        if ($products_in_cart) {
            // There are products in the cart so we need to select those products from the database
            // Products in cart array to question mark string array, we need the SQL statement to include: IN (?,?,?,...etc)
            $array_to_question_marks = implode(',', array_fill(0, count($products_in_cart), '?'));
            $stmt = $pdo->prepare('SELECT p.id, c.id AS category_id, p.* FROM products p LEFT JOIN products_categories pc ON p.id = pc.product_id LEFT JOIN categories c ON c.id = pc.category_id WHERE p.id IN (' . $array_to_question_marks . ') GROUP BY p.id, c.id');
            // We use the array_column to retrieve only the id's of the products
            $stmt->execute(array_column($products_in_cart, 'id'));
            // Fetch the products from the database and return the result as an Array
            $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
            // Get the current date
            $current_date = strtotime((new DateTime())->format('Y-m-d H:i:s'));
            // Iterate the products in cart and add the meta data (product name, desc, etc)
            foreach ($products_in_cart as &$cart_product) {
                foreach ($products as $product) {
                    if ($cart_product['id'] == $product['id']) {
                        $cart_product['meta'] = $product;
                        // Calculate the subtotal
                        $product_price = $cart_product['options_price'] > 0 ? (float)$cart_product['options_price'] : (float)$product['price'];
                        $subtotal += $product_price * (int)$cart_product['quantity'];
                        // Calculate 50% on the next product
                        $quantity = (int)$cart_product['quantity'];
                        $new_product_price = $new_product_price - ($product_price * 0.5 * floor($quantity / 2));
                    }
                }
            }
        }

        if (isset($_POST['checkout']) && $products_in_cart) {
            // Process Normal Checkout
            // Iterate each product in the user's shopping cart
            // Unique transaction ID
            $transaction_id = strtoupper(uniqid('SP') . substr(md5(mt_rand()), 0, 5));
            $stmt = $pdo->prepare('INSERT INTO transactions (txn_id, payment_amount, payment_status, created, payer_email, first_name, last_name, address_street, address_city, address_zip, payment_method) VALUES (?,?,?,?,?,?,?,?,?,?,?)');
            $stmt->execute([
                $transaction_id,
                $subtotal+$discounttotal,
                'Completed',
                date('Y-m-d H:i:s'),
                $_POST['email'],
                $_POST['first_name'],
                $_POST['last_name'],
                $_POST['address_street'],
                $_POST['address_city'],
                $_POST['address_zip'],
                'optional'
            ]);
            
            // insert into database
            $order_id = $pdo->lastInsertId();
            foreach ($products_in_cart as $product) {
                // For every product in the shopping cart insert a new transaction into our database
                $stmt = $pdo->prepare('INSERT INTO transactions_items (txn_id, item_id, item_price, item_quantity, item_options) VALUES (?,?,?,?,?)');
                $stmt->execute([ $transaction_id, $product['id'], $product['options_price'] > 0 ? $product['options_price'] : $product['meta']['price'], $product['quantity'], $product['options'] ]);
                // Update product quantity in the products table
                $stmt = $pdo->prepare('UPDATE products SET quantity = quantity - ? WHERE quantity > 0 AND id = ?');
                $stmt->execute([ $product['quantity'], $product['id'] ]);
            }
            
            $_SESSION['order_details'] = [
                'email' =>  $_POST['email'],
                'products' => $products_in_cart,
                'first_name' => $_POST['first_name'],
                'last_name' => $_POST['last_name'],
                'address_street' => $_POST['address_street'],
                'address_city' => $_POST['address_city'],
                'address_zip' => $_POST['address_zip'],
                'subtotal' => $subtotal+$shippingtotal,
                'order_id' => $order_id
            ];

            send_order_details_email(
                $_POST['email'],
                $products_in_cart,
                $_POST['first_name'],
                $_POST['last_name'],
                $_POST['address_street'],
                $_POST['address_city'],
                $_POST['address_zip'],
                $subtotal+$discounttotal,
                $order_id
            );

            header('location: ' . 'index.php?page=placeorder');
            exit;
        }
    } 

// Redirect the user if the shopping cart is empty
if (empty($_SESSION['cart'])) {
    header('location: ' . 'index.php?page=cart');
    exit;
}
?>

<body>
    <div class="header">
        <div class="container">
            <a href="#" class="navbar-brand scroll-top">Sopranos Pizzeria</a>
            <nav class="navbar navbar-inverse" role="navigation">
                <div class="navbar-header">
                    <button type="button" id="nav-toggle" class="navbar-toggle" data-toggle="collapse" data-target="#main-nav">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <!--/.navbar-header-->
                <div id="main-nav" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                         <li><a href="index.php">Home</a></li>
                        <li><a href="contact.php">Contact </a></li>
                    </ul>
                </div>
                <!--/.navbar-collapse-->
            </nav>
            <!--/.navbar-->
        </div>
        <!--/.container-->
    </div>
    <!--/.header-->

<div class="checkout content-wrapper">

    <h1>Checkout</h1>

        <h2>Verzendgegevens</h2>

        <form action="" method="post">

        <label for="email">E-mail</label>
        <input type="email" name="email" id="email" placeholder="">
        
        <div class="row1">
            <label for="first_name">Naam</label>
            <input type="text" value="<?=$account['first_name']?>" name="first_name" id="first_name" placeholder="" required>
        </div>

        <div class="row2">
            <label for="last_name">Achternaam</label>
            <input type="text" value="<?=$account['last_name']?>" name="last_name" id="last_name" placeholder="" required>
        </div>

        <label for="address_street">Adres</label>
        <input type="text" value="<?=$account['address_street']?>" name="address_street" id="address_street" placeholder="" required>

        <label for="address_city">Stad</label>
        <input type="text" value="<?=$account['address_city']?>" name="address_city" id="address_city" placeholder="" required>

        <div class="row2">
            <label for="address_zip">Postcode</label>
            <input type="text" value="<?=$account['address_zip']?>" name="address_zip" id="address_zip" placeholder="" required>
        </div>

        <button type="submit" name="checkout">Bestellen</button>

    </form>

  <?php  include 'includes/footer.php'; ?>
    
</div>
