import 'package:custom_shop/constants/loader.dart';
import 'package:custom_shop/features/auth/service/auth_services.dart';
import 'package:custom_shop/features/home/services/cart_service.dart';
import 'package:custom_shop/features/home/services/product_service.dart';
import 'package:custom_shop/features/models/products.dart';
import 'package:custom_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService authService = AuthService();
  final ProductServices productServices = ProductServices();
  final CartServices cartServices = CartServices();
  final List<Product> items = [
    Product(
        name: 'Product1',
        provider: 'ProductAdmin1',
        description: "The Product is cute",
        image: "source",
        price: 10,
        quantity: 1),
    Product(
        name: 'Product2',
        provider: 'ProductAdmin2',
        description: "The Product is cute",
        image: "source",
        price: 20,
        quantity: 1),
    Product(
        name: 'Product3',
        provider: 'ProductAdmin3',
        description: "The Product is cute",
        image: "source",
        price: 30,
        quantity: 1),
  ];
  List<Product>? products;

  // List<Product>? cart_products;
  // List<String>? cart_id;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void addToCart(product) {
    cartServices.addToCart(
      context: context,
      product: product,
    );
  }

  fetchAllProducts() async {
    products = await productServices.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final cart_products = userProvider.user.cart;

    final cart_id_list =
        cart_products.map((product) => product['product']['_id']).toList();

    return Scaffold(
      appBar: AppBar(
          title: const Text('ShopShop',
              style: TextStyle(fontSize: 30.0, color: Color(0xFF6C6C6C))),
          backgroundColor: Color(0xFFD9D9D9),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Show Snackbar',
              onPressed: () => authService.logOut(context),
            ),
          ]),
      body: products == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: ListView.builder(
                itemCount: products?.length,
                itemBuilder: (context, index) {
                  print('reload');
                  final productData = products![index];
                  //set boolean for added to cart
                  if (cart_id_list.contains(productData.id)) {
                    productData.addedToCart = true;
                  }
                  // bool added_cart = cart_id_list.contains(productData.id);
                  Color btnColor =
                      productData.addedToCart ? Colors.grey : Colors.black;
                  String cartTxt =
                      productData.addedToCart ? 'In Cart' : 'Add to Cart';
                  void addedCart() async {
                    // if (!added_cart) {
                    setState(() {
                      productData.addedToCart = true;
                      // added_cart = true;
                      btnColor = Colors.grey;
                      cartTxt = 'In Cart';
                    });
                    // }
                  }

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Card(
                          color: Colors.grey[200],
                          // Define the shape of the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),

                          // Define how the card's content should be clipped
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          // Define the child widget of the card
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              // Add padding around the row widget
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Add an image widget to display an image
                                    Image.network(
                                      productData.image,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    // Add some spacing between the image and the text
                                    Container(width: 20),
                                    // Add an expanded widget to take up the remaining horizontal space
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // Add some spacing between the top of the card and the title
                                          Container(height: 5),
                                          // Add a title widget
                                          Text(productData.provider,
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.grey[500])),

                                          Text(
                                            productData.name,
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: MyColorsSample.grey_80,
                                            ),
                                          ),

                                          Text(
                                            productData.description,
                                            maxLines: 2,
                                            style: MyTextSample.body2(context)!
                                                .copyWith(
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          Text(
                                            'USD ' +
                                                productData.price.toString(),
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 1.5, color: Colors.black),

                              Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: btnColor,
                                    ),
                                    onPressed: () {
                                      addedCart();
                                      addToCart(productData);
                                    },
                                    child: Text('$cartTxt'),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

class ImgSample {
  static String get(String name) {
    return 'assets/images/$name';
  }
}

class MyColorsSample {
  static const Color primary = Color(0xFF12376F);
  static const Color primaryDark = Color(0xFF0C44A3);
  static const Color primaryLight = Color(0xFF43A3F3);
  static const Color green = Colors.green;
  static Color black = const Color(0xFF000000);
  static const Color accent = Color(0xFFFF4081);
  static const Color accentDark = Color(0xFFF50057);
  static const Color accentLight = Color(0xFFFF80AB);
  static const Color grey_3 = Color(0xFFf7f7f7);
  static const Color grey_5 = Color(0xFFf2f2f2);
  static const Color grey_10 = Color(0xFFe6e6e6);
  static const Color grey_20 = Color(0xFFcccccc);
  static const Color grey_40 = Color(0xFF999999);
  static const Color grey_60 = Color(0xFF666666);
  static const Color grey_80 = Color(0xFF37474F);
  static const Color grey_90 = Color(0xFF263238);
  static const Color grey_95 = Color(0xFF1a1a1a);
  static const Color grey_100_ = Color(0xFF0d0d0d);
  static const Color transparent = Color(0x00f7f7f7);
}

class MyTextSample {
  static TextStyle? display4(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge;
  }

  static TextStyle? display3(BuildContext context) {
    return Theme.of(context).textTheme.displayMedium;
  }

  static TextStyle? display2(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall;
  }

  static TextStyle? display1(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium;
  }

  static TextStyle? headline(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall;
  }

  static TextStyle? title(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge;
  }

  static TextStyle medium(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 18,
        );
  }

  static TextStyle? subhead(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium;
  }

  static TextStyle? body2(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge;
  }

  static TextStyle? body1(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium;
  }

  static TextStyle? caption(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall;
  }

  static TextStyle? button(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(letterSpacing: 1);
  }

  static TextStyle? subtitle(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall;
  }

  static TextStyle? overline(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall;
  }
}

class MyStringsSample {
  static const String lorem_ipsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam efficitur ipsum in placerat molestie.  Fusce quis mauris a enim sollicitudin"
      "\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam efficitur ipsum in placerat molestie.  Fusce quis mauris a enim sollicitudin";
  static const String middle_lorem_ipsum =
      "Flutter is an open-source UI software development kit created by Google. It is used to develop cross-platform applications for Android, iOS, Linux, macOS, Windows, Google Fuchsia, and the web from a single codebase.";
  static const String card_text =
      "Cards are surfaces that display content and actions on a single topic.";
}
