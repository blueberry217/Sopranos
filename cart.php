<?php

include 'includes/header.php';

// If the user clicked the add to cart button on the product page we can check for the form data
if (isset($_POST['product_id'], $_POST['quantity']) && is_numeric($_POST['product_id']) && is_numeric($_POST['quantity'])) {
    // Set the post variables so we easily identify them, also make sure they are integer
    $product_id = (int)$_POST['product_id'];
    $quantity = (int)$_POST['quantity'];
    // Get product options
    $options = '';
    $options_price = 0.00;
    foreach ($_POST as $k => $v) {
        if (strpos($k, 'option-') !== false) {
            $options .= str_replace('option-', '', $k) . '-' . $v . ',';
            $stmt = $pdo->prepare('SELECT * FROM products_options WHERE title = ? AND name = ? AND product_id = ?');
            $stmt->execute([ str_replace('option-', '', $k), $v, $product_id ]);
            $option = $stmt->fetch(PDO::FETCH_ASSOC);
            $options_price += $option['price'];
        }
    }
    $options = rtrim($options, ',');
    // Prepare the SQL statement, we basically are checking if the product exists in our database
    $stmt = $pdo->prepare('SELECT * FROM products WHERE id = ?');
    $stmt->execute([ $_POST['product_id'] ]);
    // Fetch the product from the database and return the result as an Array
    $product = $stmt->fetch(PDO::FETCH_ASSOC);
    // Check if the product exists (array is not empty)
    if ($product && $quantity > 0) {
        // Product exists in database, now we can create/update the session variable for the cart
        if (!isset($_SESSION['cart'])) {
            // Shopping cart session variable doesnt exist, create it
            $_SESSION['cart'] = [];
        }
        $cart_product = &get_cart_product($product_id, $options);
        if ($cart_product) {
            // Product exists in cart, update the quanity
            $cart_product['quantity'] += $quantity;
        } else {
            // Product is not in cart, add it
            $_SESSION['cart'][] = [
                'id' => $product_id,
                'quantity' => $quantity,
                'options' => $options,
                'options_price' => $options_price,
            ];
        }
    }
    // Prevent form resubmission...
    header('location: index.php?page=cart');
    exit;
}
// Remove product from cart, check for the URL param "remove", this is the product id, make sure it's a number and check if it's in the cart
if (isset($_GET['remove']) && is_numeric($_GET['remove']) && isset($_SESSION['cart']) && isset($_SESSION['cart'][$_GET['remove']])) {
    // Remove the product from the shopping cart
    unset($_SESSION['cart'][$_GET['remove']]);
}
// Empty the cart
if (isset($_POST['emptycart']) && isset($_SESSION['cart'])) {
    // Remove all products from the shopping cart
    unset($_SESSION['cart']);
    header('location: index.php?page=cart');
    exit;
}
//Update product quantities in cart if the user clicks the "Update" button on the shopping cart page
if ((isset($_POST['update']) || isset($_POST['checkout'])) && isset($_SESSION['cart'])) {
    // Iterate the post data and update quantities for every product in cart
    foreach ($_POST as $k => $v) {
        if (strpos($k, 'quantity') !== false && is_numeric($v)) {
            $id = str_replace('quantity-', '', $k);
            // abs() function will prevent minus quantity and (int) will make sure the number is an integer
            $quantity = abs((int)$v);
            // Always do checks and validation
            if (is_numeric($id) && isset($_SESSION['cart'][$id]) && $quantity > 0) {
                // Update new quantity
                $_SESSION['cart'][$id]['quantity'] = $quantity;
            }
        }
    }
     // Send the user to the place order page if they click the Place Order button, also the cart should not be empty
    if (isset($_POST['checkout']) && !empty($_SESSION['cart'])) {
        header('location: index.php?page=checkout');
        exit;
    }

    header('location: index.php?page=cart');
    exit;
}

// Check the session variable for products in cart
$products_in_cart = isset($_SESSION['cart']) ? $_SESSION['cart'] : [];
$subtotal = $new_product_price = 0.00;
$discounttotal = 0.00;
$roundtotal = 0.00;

// If there are products in cart
if ($products_in_cart) {
    // There are products in the cart so we need to select those products from the database
    // Products in cart array to question mark string array, we need the SQL statement to include: IN (?,?,?,...etc)
    $array_to_question_marks = implode(',', array_fill(0, count($products_in_cart), '?'));
    $stmt = $pdo->prepare('SELECT p.id, pc.category_id, p.* FROM products p  LEFT JOIN products_categories pc ON p.id = pc.product_id LEFT JOIN categories c ON c.id = pc.category_id WHERE p.id IN (' . $array_to_question_marks . ') GROUP BY p.id');
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
                // Calculate 50% discount 
                $quantity = (int)$cart_product['quantity'];
                $new_product_price = $new_product_price - ($product_price * 0.5 * floor($quantity / 2));
            }
        }
    }
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

<div class="cart content-wrapper">

    <h1>Winkelmand</h1>

    <form action="index.php?page=cart" method="post">
        <table>
            <thead>
                <tr>
                    <td colspan="2">Producten</td>
                    <td></td>
                    <td class="rhide">Prijs</td>
                    <td>Hoeveelheid</td>
                    <td>Totaal</td>
                </tr>
            </thead>
            <tbody>
                <?php if (empty($products_in_cart)): ?>
                <tr>
                    <td colspan="6" style="text-align:center;">Je hebt geen producten in je winkelmandje..</td>
                </tr>
                <?php else: ?>
                <?php foreach ($products_in_cart as $num => $product): ?>
                <tr>
                    <td class="img">
                        <?php if (!empty($product['meta']['img']) && file_exists('imgs/' . $product['meta']['img'])): ?>
                        <a href="<?=('index.php?page=product&id=' . $product['id'])?>">
                            <img src="imgs/<?=$product['meta']['img']?>" width="50" height="50" alt="<?=$product['meta']['name']?>">
                        </a>
                        <?php endif; ?>
                    </td>
                    <td>
                        <a href="<?=('index.php?page=product&id=' . $product['id'])?>"><?=$product['meta']['name']?></a>
                        <br>
                        <a href="<?=('index.php?page=cart&remove=' . $num)?>" class="remove">Remove</a>
                    </td>
                    <td class="price">
                        <?=$product['options']?>
                        <input type="hidden" name="options" value="<?=$product['options']?>">
                    </td>
                    <?php if ($product['options_price'] > 0): ?>
                    <td class="price rhide">€<?=number_format($product['options_price'],2)?></td>
                    <?php else: ?>
                    <td class="price rhide">€<?=number_format($product['meta']['price'],2)?></td>
                    <?php endif; ?>
                    <td class="quantity">
                        <input type="number" class="ajax-update" name="quantity-<?=$num?>" value="<?=$product['quantity']?>" min="1" <?php if ($product['meta']['quantity'] != -1): ?>max="<?=$product['meta']['quantity']?>"<?php endif; ?> placeholder="Quantity" required>
                    </td>
                    <?php if ($product['options_price'] > 0): ?>
                    <td class="price product-total">€<?=number_format($product['options_price'] * $product['quantity'],2)?></td>
                    <?php else: ?>
                    <td class="price product-total">€<?=number_format($product['meta']['price'] * $product['quantity'],2)?></td>
                    <?php endif; ?>
                </tr>
                <?php endforeach; ?>
                <?php endif; ?>
            </tbody>
        </table>

        <div class="subtotal">
            <span class="text">Subtotaal</span>
            <span class="price">€<?=number_format($subtotal,2)?></span>
        </div>

        <div class="shipping">
            <span class="text">Korting</span>
            <span class="price">€<?=number_format($roundtotal += $new_product_price,2)?></span>
        </div>

        <div class="total">
            <span class="text">Totaal</span>
            <span class="price">€<?=number_format(($subtotal-round($discounttotal,2))+$roundtotal,2)?></span>
        </div>

        <div class="buttons">
            <!-- <input type="submit" value="Update" name="update"> -->
            <input type="submit" value="Empty Cart" name="emptycart">
            <input type="submit" value="Checkout" name="checkout">
        </div>

        <?php include 'includes/footer.php'; ?>

    </form>

</div>


