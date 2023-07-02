import 'package:custom_shop/features/home/screen/cart.dart';
import 'package:custom_shop/features/home/screen/home.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 2;

  List<Widget> pages = [
    const Home(),
    // const Center(child: Text("Cart")),
    const Cart(),
    // const Center(child: Text("account")),
    // const AccountScreen(),
    // const Center(child: Text("Cart")),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_page],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: Colors.black45,
          unselectedItemColor: Colors.black87,
          backgroundColor: Color(0xffebecee),
          iconSize: 28,
          onTap: updatePage,
          items: [
            BottomNavigationBarItem(
                icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: _page == 0 ? Colors.black45 : Color(0xffebecee),
                      width: bottomBarBorderWidth,
                    ))),
                    child: Icon(Icons.home)),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: _page == 1 ? Colors.black45 : Color(0xffebecee),
                      width: bottomBarBorderWidth,
                    ))),
                    child: Icon(Icons.card_giftcard)),
                label: "Cart"),
          ],
        ));
  }
}
