import 'package:flutter/material.dart';

class Thank extends StatelessWidget {
  const Thank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Thank you for your purchase'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () => Navigator.pushNamed(context, '/'),
                child: Text('Back')),
          ),
        ],
      )),
    );
  }
}
