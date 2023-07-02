import 'package:custom_shop/constants/loader.dart';
import 'package:custom_shop/features/home/services/cart_service.dart';
import 'package:custom_shop/features/models/products.dart';
import 'package:custom_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
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

  double calculateTotal(List<dynamic> items) {
    double total = 0;

    for (var item in items) {
      final quantity = item['quantity'];
      final price = item['product']['price'];
      total += quantity * price;
    }

    return total;
  }

  final CartServices cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final cart_products_list = userProvider.user.cart;
    // print(cart_products_list);
    double total_no = calculateTotal(cart_products_list);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart',
            style: TextStyle(fontSize: 30.0, color: Color(0xFF6C6C6C))),
        backgroundColor: Color(0xFFD9D9D9),
      ),
      body: cart_products_list == null
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    // Expanded(
                    // child:
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cart_products_list.length,
                        itemBuilder: (context, index) {
                          return Container(
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.black54)),
                              padding: EdgeInsets.all(15),
                              child: Row(children: <Widget>[
                                Image.network(
                                  cart_products_list[index]['product']['image'],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(cart_products_list[index]
                                        ['product']['name']),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text('x ' +
                                      cart_products_list[index]['quantity']
                                          .toString() +
                                      '     '),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(cart_products_list[index]
                                          ['product']['price']
                                      .toString()),
                                ),
                              ]));
                        }),

                    Row(children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Text('Total:'),
                        ),
                        // width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('HKD' + total_no.toString()),
                      ),
                    ]),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          cartServices.placeOrder(
                            context: context,
                            totalSum: total_no,
                          );
                        },
                        child: Text('Confirm Order'))
                  ],
                ),
              ),
            ),
    );
  }
}
