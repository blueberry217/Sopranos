<?php include 'includes/header.php'; ?>

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
    
    <section class="contact-us">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="section-heading">
                        <h2>Bericht</h2>
                    </div>
                    <form id="contact" action="" method="post">
                        <div class="row">
                            <div class="col-md-6">
                                <fieldset>
                                    <input name="name" type="text" class="form-control" id="name" placeholder="Naam..." required="">
                                </fieldset>
                                <fieldset>
                                    <input name="email" type="text" class="form-control" id="email" placeholder="Email..." required="">
                                </fieldset>
                                <fieldset>
                                    <input name="phone" type="text" class="form-control" id="phone" placeholder="Telefoon..." required="">
                                </fieldset>
                            </div>
                            <div class="col-md-6">
                                <fieldset>
                                    <textarea name="message" rows="6" class="form-control" id="message" placeholder="Bericht..." required=""></textarea>
                                </fieldset>
                                <fieldset>
                                    <button type="submit" id="form-submit" class="btn">Verzenden</button>
                                </fieldset>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md-6">
                    <div class="section-heading contact-info">
                        <h2>Contact Info</h2>
                        <p>Pellentesque nec orci in erat venenatis viverra. Vivamus in lorem et leo feugiat ullamcorper. Donec volutpat fermentum erat non aliquet. Cras fermentum, risus a blandit sodales, erat turpis eleifend lacus, venenatis mollis leo lorem vel eros. Quisque et sem tempus, feugiat urna iaculis, tempor metus.<br><br><em>30 Raffles Ave, <br>Singapore 039803</em></p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="map">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div id="map">
      
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7895.485196115994!2d103.85995441789784!3d1.2880401763270322!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x7fb4e58ad9cd826e!2sSingapore+Flyer!5e0!3m2!1sen!2sth!4v1505825620371" width="100%" height="500" frameborder="0" style="border:0" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <?php include('includes/footer.php'); ?>
    
</body>
</html>