<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="classes.Articulo" %>
<%@page import="classes.Detalle_Venta" %>
<%@page import="controladores.ControladorProducto"%>
<%@page import="classes.Producto"%>
<%@page import="com.fasterxml.jackson.core.JsonProcessingException" %>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper" %>

<%
    //aqui recuperamos nuestros articulos de "carrito"
    HttpSession sesion = request.getSession(true);
    ArrayList<Articulo> articulos = sesion.getAttribute("carrito")==null? null : (ArrayList)sesion.getAttribute("carrito");
    String myJSON="";
    
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Cart | E-Shopper</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/prettyPhoto.css" rel="stylesheet">
        <link href="css/price-range.css" rel="stylesheet">
        <link href="css/animate.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->       
        <link rel="shortcut icon" href="images/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
    </head><!--/head-->

    <body>
        <header id="header"><!--header-->

            <div class="header-middle"><!--header-middle-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="logo pull-left">
                                <a href="index.jsp"><h1>Boutique Store</h1></a><!--img src="images/home/logo.png" alt="" /></a-->
                            </div>
                            <div class="btn-group pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                                        USA
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a href="">Canada</a></li>
                                        <li><a href="">UK</a></li>
                                    </ul>
                                </div>

                                <div class="btn-group">
                                    <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                                        DOLLAR
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a href="">Canadian Dollar</a></li>
                                        <li><a href="">Pound</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="shop-menu pull-right">
                                <ul class="nav navbar-nav">
                                    <li><a href=""><i class="fa fa-user"></i> Account</a></li>
                                    <li><a href=""><i class="fa fa-star"></i> Wishlist</a></li>
                                    <li><a href="checkout.jsp"><i class="fa fa-crosshairs"></i> Checkout</a></li>
                                    <li><a href="cart.jsp" class="active"><i class="fa fa-shopping-cart"></i> Cart</a></li>
                                    <li><a href="login.jsp"><i class="fa fa-lock"></i> Login</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/header-middle-->

            <div class="header-bottom"><!--header-bottom-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                            </div>
                            <div class="mainmenu pull-left">
                                <ul class="nav navbar-nav collapse navbar-collapse">
                                    <li><a href="index.jsp">Home</a></li>
                                    <li class="dropdown"><a href="#">Shop<i class="fa fa-angle-down"></i></a>
                                        <ul role="menu" class="sub-menu">
                                            <li><a href="shop.jsp">Products</a></li>
                                            <li><a href="product-details.jsp">Product Details</a></li> 
                                            <li><a href="checkout.jsp">Checkout</a></li> 
                                            <li><a href="cart.jsp" class="active">Cart</a></li> 
                                            <li><a href="login.jsp">Login</a></li> 
                                        </ul>
                                    </li> 
                                    <li class="dropdown"><a href="#">Blog<i class="fa fa-angle-down"></i></a>
                                        <ul role="menu" class="sub-menu">
                                            <li><a href="blog.html">Blog List</a></li>
                                            <li><a href="blog-single.html">Blog Single</a></li>
                                        </ul>
                                    </li> 
                                    <li><a href="404.html">404</a></li>
                                    <li><a href="contact-us.html">Contact</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="search_box pull-right">
                                <input type="text" placeholder="Search"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/header-bottom-->
        </header><!--/header-->

        <section id="cart_items">
            <div class="container">
                <div class="breadcrumbs">
                    <ol class="breadcrumb">
                        <li><a href="#">Home</a></li>
                        <li class="active">Shopping Cart</li>
                    </ol>
                </div>
                <div class="table-responsive cart_info" id="cart-container">
                    <table class="table table-condensed" id="shop-table">
                        <thead>
                            <tr class="cart_menu">
                                <td class="image">Item</td>
                                <td class="description"></td>
                                <td class="price">Price</td>
                                <td class="quantity">Quantity</td>
                                <td class="total">Total</td>
                                <td></td>
                            </tr>
                        </thead>
                        <tbody>

                            <%
                                ControladorProducto cp = new ControladorProducto();
                                double total = 0;
                                                                                                                                                 
                                ObjectMapper objectMapper = new ObjectMapper();   
                                String json_articulos="";
                                                                                                                                                
                                //Creamos un Array para enviar al servlet
                                List<String> list_articulos = new ArrayList<>();
                                                                                                                                                    
                                myJSON="";
                                                                                                                                                    
                            if(articulos != null){
                                                                                                                                                   
                            //~AQUI SE PUEDE CREAR EL ARRAY DE PRODUCTOS SELECCIONADOS
                                                                                                                                               
                                try{
                                //aqui se convierte el objeto articulos a JSON
                                                                                                                                               
                                for(Articulo a: articulos){
                                //aqui recuperamos todos los articulos del array "articulos"
                                    Producto producto = cp.getProducto(a.getIdProducto());
                                    total += a.getCantidad() * producto.getPrecio();
                                    //agregamos (id_producto y cantidad) al ArrayArticulos~
                                    //System.out.println("{\"idProducto\":"+ producto.getId()+",\"cantidad\":"+a.getCantidad()+"}");
                                    myJSON=myJSON+"{\"id_detalle\":1,\"id_producto\":"+ producto.getId()+",\"id_venta\":3,\"cantidad\":"+a.getCantidad()+",\"precio_venta\":"+Math.round(producto.getPrecio()*a.getCantidad()*100.0)/100.0+"},";
                                    System.out.println("["+myJSON+"]");
                                                                                                                                                        
                                    list_articulos.add(producto.getId()+"@"+a.getCantidad() );
                                    //list_articulos.add("valorrrrr22222");
                                                                                                                                                        
                            %>
                            <tr>
                                <td class="cart_product">
                                    <a href=""><img src="<%= producto.getImg()%>" alt="" width="120"></a>
                                </td>
                                <td class="cart_description">
                                    <h4><a href=""><%= producto.getNombre()%></a></h4>
                                    <p>Web ID: <%= producto.getId()%></p>
                                </td>
                                <td class="cart_price">
                                    <p>$<%= producto.getPrecio()%></p>
                                </td>
                                <td class="cart_quantity">
                                    <div class="cart_quantity_button">
                                        <a class="cart_quantity_up" href=""> + </a>
                                        <input class="cart_quantity_input" type="text" name="quantity" value="<%= a.getCantidad()%>" autocomplete="off" size="2">
                                        <a class="cart_quantity_down" href=""> - </a>
                                    </div>
                                </td>
                                <td class="cart_total">
                                    <p class="cart_total_price">$<%= Math.round(producto.getPrecio()*a.getCantidad()*100.0)/100.0%></p>
                                </td>
                                <td class="cart_delete">
                                    <span id="idarticulo" style="display:none" ><%= producto.getId()%></span>
                                    <a class="cart_quantity_delete" href="" id="deleteitem"><i class="fa fa-times"></i></a>
                                </td>
                                <!-- form action="createventa" method="post">
id_venta: <input type="number" name="nombre"  value="999"><br><!-- se genera solo --
id_usuario: <input type="number" name="email"  value="2"><br><!-- dato q biene de la session --
id_pago: <input type="numbe" name="categoria"  value="1"><br><!-- del pago -
fecha_venta: <input type="date" name="precio"  value=""><br><!-- fecha seleccionable --
monto: <input type="number" name="precio"  value="%= Math.round(producto.getPrecio()*a.getCantidad()*100.0)/100.0%>"><br><!-- monto total de la compra --
estado: <input type="text" name="stock"  value="comprado_canceladoXddd"><br><!-- estado, nada relevante xd --
<input type="submit" value="Agregar">
</form-->
                            </tr>

                            <%}
                                //intentamos convertir a JSON
                                json_articulos = objectMapper.writeValueAsString(list_articulos);
                                //System.out.println("JSON articulo: "+articulos.get(1));
                                                                                                                                                    
                                                                                                                                                    
                            }catch(JsonProcessingException e){
                                    e.printStackTrace();
                                }//~aqui deberia cerrar el TRY
                              }
                            %>

                        </tbody>
                    </table>
                    <%
                    if(articulos ==null){
                    %>
                    <h3>No Hay Articulos en el Carrito De Compras</h3>
                    <%}%>
                </div>
                <!-- <a href="javascript:window.history.go(-2);">Seguir Comprando</a>-->
                <a href="shop.jsp">Seguir Comprando</a>

            </div>
        </section> <!--/#cart_items-->

        <section id="do_action">
            <div class="container">
                <div class="heading">
                    <h3>What would you like to do next?</h3>
                    <p>Choose if you have a discount code or reward points you want to use or would like to estimate your delivery cost.</p>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="chose_area">
                            <ul class="user_option">
                                <li>
                                    <input type="checkbox">
                                    <label>Use Coupon Code</label>
                                </li>
                                <li>
                                    <input type="checkbox">
                                    <label>Use Gift Voucher</label>
                                </li>
                                <li>
                                    <input type="checkbox">
                                    <label>Estimate Shipping & Taxes</label>
                                </li>
                            </ul>
                            <ul class="user_info">
                                <li class="single_field">
                                    <label>Country:</label>
                                    <select>
                                        <option>United States</option>
                                        <option>Bangladesh</option>
                                        <option>UK</option>
                                        <option>India</option>
                                        <option>Pakistan</option>
                                        <option>Ucrane</option>
                                        <option>Canada</option>
                                        <option>Dubai</option>
                                    </select>

                                </li>
                                <li class="single_field">
                                    <label>Region / State:</label>
                                    <select>
                                        <option>Select</option>
                                        <option>Dhaka</option>
                                        <option>London</option>
                                        <option>Dillih</option>
                                        <option>Lahore</option>
                                        <option>Alaska</option>
                                        <option>Canada</option>
                                        <option>Dubai</option>
                                    </select>

                                </li>
                                <li class="single_field zip-field">
                                    <label>Zip Code:</label>
                                    <input type="text">
                                </li>
                            </ul>
                            <a class="btn btn-default update" href="">Get Quotes</a>
                            <a class="btn btn-default check_out" href="">Continue</a>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="total_area">
                            <ul>
                                <li>Cart Sub Total <span id="txt-subtotal">$<%= Math.round(total*100.0)/100.0%></span></li>
                                <li>Eco Tax <span>$0.0</span></li>
                                <li>Shipping Cost <span>Free</span></li>
                                <li>Total <span id="txt-total">$<%= Math.round(total*100.0)/100.0%></span></li>
                            </ul>
                            <a class="btn btn-default update" href="">Up</a>
                            <!-- ~  aqui se establecera conexion con el servlet de compra Finalizada -->
                            <a class="btn btn-default check_out" href="#" id="ejecutarcompra">Comprar</a>
                            <a class="btn" name="ejecutar" id="ejecutar" href="createventa" style="display: none">xddddd</a>

                            <form id="formtotal" action="createventa" method="post"> <!--style="display: none"-->
                                <input type="number" name="id_venta"  value="999" style="display: none"><br><!-- se genera solo -->
                                <input type="number" name="id_usuario"  value="2" style="display: none"><br><!-- dato q biene de la session -->
                                <input type="number" name="id_pago"  value="1" style="display: none"><br><!-- del pago -->
                                <input type="date" name="fecha_venta"  value="" style="display: none"><br><!-- fecha seleccionable -->
                                <input type="text" name="monto"  value="<%= Math.round(total*100.0)/100.0%>" style="display: none"><br><!-- monto total de la compra -->
                                <input type="text" name="estado"  value="comprado" style="display: none"><br><!-- estado, nada relevante xd -->
                                <textarea id="mi_articulos" name="articulosJSON" rows="4" cols="50" style="display: none">
                                    <%="["+myJSON+"]"%>
                                </textarea>
                                <input type="text" name="json_productos"  style="display: none" value="<%="PARA VALUE::::["+myJSON+"]"%>"><br><!-- json, de productos -->
                                <input type="submit" value="Agregar">
                            </form>


                        </div>
                    </div>


                </div>
            </div>
        </section><!--/#do_action-->

        <footer id="footer"><!--Footer-->
            <div class="footer-top">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-2">
                            <div class="companyinfo">
                                <h2><span>e</span>-shopper</h2>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,sed do eiusmod tempor</p>
                            </div>
                        </div>
                        <div class="col-sm-7">
                            <div class="col-sm-3">
                                <div class="video-gallery text-center">
                                    <a href="#">
                                        <div class="iframe-img">
                                            <img src="images/home/iframe1.png" alt="" />
                                        </div>
                                        <div class="overlay-icon">
                                            <i class="fa fa-play-circle-o"></i>
                                        </div>
                                    </a>
                                    <p>Circle of Hands</p>
                                    <h2>24 DEC 2014</h2>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="video-gallery text-center">
                                    <a href="#">
                                        <div class="iframe-img">
                                            <img src="images/home/iframe2.png" alt="" />
                                        </div>
                                        <div class="overlay-icon">
                                            <i class="fa fa-play-circle-o"></i>
                                        </div>
                                    </a>
                                    <p>Circle of Hands</p>
                                    <h2>24 DEC 2014</h2>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="video-gallery text-center">
                                    <a href="#">
                                        <div class="iframe-img">
                                            <img src="images/home/iframe3.png" alt="" />
                                        </div>
                                        <div class="overlay-icon">
                                            <i class="fa fa-play-circle-o"></i>
                                        </div>
                                    </a>
                                    <p>Circle of Hands</p>
                                    <h2>24 DEC 2014</h2>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="video-gallery text-center">
                                    <a href="#">
                                        <div class="iframe-img">
                                            <img src="images/home/iframe4.png" alt="" />
                                        </div>
                                        <div class="overlay-icon">
                                            <i class="fa fa-play-circle-o"></i>
                                        </div>
                                    </a>
                                    <p>Circle of Hands</p>
                                    <h2>24 DEC 2014</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="address">
                                <img src="images/home/map.png" alt="" />
                                <p>505 S Atlantic Ave Virginia Beach, VA(Virginia)</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="footer-widget">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>Service</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="">Online Help</a></li>
                                    <li><a href="">Contact Us</a></li>
                                    <li><a href="">Order Status</a></li>
                                    <li><a href="">Change Location</a></li>
                                    <li><a href="">FAQ’s</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>Quock Shop</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="">T-Shirt</a></li>
                                    <li><a href="">Mens</a></li>
                                    <li><a href="">Womens</a></li>
                                    <li><a href="">Gift Cards</a></li>
                                    <li><a href="">Shoes</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>Policies</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="">Terms of Use</a></li>
                                    <li><a href="">Privecy Policy</a></li>
                                    <li><a href="">Refund Policy</a></li>
                                    <li><a href="">Billing System</a></li>
                                    <li><a href="">Ticket System</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>About Shopper</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="">Company Information</a></li>
                                    <li><a href="">Careers</a></li>
                                    <li><a href="">Store Location</a></li>
                                    <li><a href="">Affillate Program</a></li>
                                    <li><a href="">Copyright</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-3 col-sm-offset-1">
                            <div class="single-widget">
                                <h2>About Shopper</h2>
                                <form action="#" class="searchform">
                                    <input type="text" placeholder="Your email address" />
                                    <button type="submit" class="btn btn-default"><i class="fa fa-arrow-circle-o-right"></i></button>
                                    <p>Get the most recent updates from <br />our site and be updated your self...</p>
                                </form>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <div class="container">
                    <div class="row">
                        <p class="pull-left">Copyright © 2013 E-SHOPPER Inc. All rights reserved.</p>
                        <p class="pull-right">Designed by <span><a target="_blank" href="http://www.themeum.com">Themeum</a></span></p>
                    </div>
                </div>
            </div>

        </footer><!--/Footer-->



        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
        <script src="js/carrito.js"></script>
    </body>
</html>