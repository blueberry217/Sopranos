<?php

include 'includes/header.php'; 

// Check to make sure the id parameter is specified in the URL
if (isset($_GET['id'])) {
    // Prepare statement and execute, prevents SQL injection
    $stmt = $pdo->prepare('SELECT * FROM products WHERE id = ? OR url_structure = ?');
    $stmt->execute([ $_GET['id'], $_GET['id'] ]);
    // Fetch the product from the database and return the result as an Array
    $product = $stmt->fetch(PDO::FETCH_ASSOC);
    // Check if the product exists (array is not empty)
    if (!$product) {
        // Output simple error if the id for the product doesn't exists (array is empty)
        http_response_code(404);
        exit('Product does not exist!');
    }
    // Select the product images (if any) from the products_images table
    $stmt = $pdo->prepare('SELECT * FROM products_images WHERE product_id = ?');
    $stmt->execute([ $product['id'] ]);
    // Fetch the product images from the database and return the result as an Array
    $product_imgs = $stmt->fetchAll(PDO::FETCH_ASSOC);
    // Select the product options (if any) from the products_options table
    $stmt = $pdo->prepare('SELECT title, GROUP_CONCAT(name) AS options, GROUP_CONCAT(price) AS prices FROM products_options WHERE product_id = ? GROUP BY title');
    $stmt->execute([ $product['id'] ]);
    // Fetch the product options from the database and return the result as an Array
    $product_options = $stmt->fetchAll(PDO::FETCH_ASSOC);
} else {
    // Output simple error if the id wasn't specified
    http_response_code(404);
    exit('Product does not exist!');
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

<div class="product content-wrapper">
    <div class="product-imgs">
        <img class="product-img-large" src="imgs/<?=$product['img']?>" width="500" height="500" alt="<?=$product['name']?>">
        <div class="product-small-imgs">
            <img class="product-img-small selected" src="imgs/<?=$product['img']?>" width="150" height="150" alt="<?=$product['name']?>">
        </div>
    </div>
<div class="product-wrapper">

<h1 class="name"><?=$product['name']?></h1>

<span class="price">
    €<?=number_format($product['price'],2)?>
</span>

<form id="product-form" action="<?='index.php?page=cart'?>" method="post">
    <?php foreach ($product_options as $option): ?>
    <select name="option-<?=$option['title']?>" required>
    <option value="" selected disabled style="display:none"><?=$option['title']?></option>
        <?php
        $options_names = explode(',', $option['options']);
        $options_prices = explode(',', $option['prices']);
        ?>
        <?php foreach ($options_names as $k => $name): ?>
        <option value="<?=$name?> "data-price="<?=$options_prices[$k]?>"><?=$name?></option>
        <?php endforeach; ?>
    </select>
    <?php endforeach; ?>
    <input type="number" name="quantity" value="1" min="1" <?php if ($product['quantity'] != -1): ?>max="<?=$product['quantity']?>"<?php endif; ?> placeholder="Quantity" required>
    <input type="hidden" name="product_id" value="<?=$product['id']?>">
    <?php if ($product['quantity'] == 0): ?>
    <input type="submit" value="Out of Stock" disabled>
    <?php else: ?>
    <input type="submit" value="Add To Cart">
    <?php endif; ?>
</form>

<div class="description">
    <?=$product['description']?>
</div>

<?php include 'includes/footer.php';?>

</div>

</div>





