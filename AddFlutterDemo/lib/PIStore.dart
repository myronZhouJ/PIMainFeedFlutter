import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Item {

}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];
  int get totalPrice => _items.length * 42;
  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}

class PIStore{
  static Widget run() {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: PIStoreApp(),
    );
  }
}

class PIStoreApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PIStorePage(title: 'PIFlutterPB Page'),
    );
  }
}

class PIStorePage extends StatelessWidget {
  PIStorePage({this.title});
  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('add item'),
                    onPressed: (){
                      Provider.of<CartModel>(context, listen: false).add(Item());
                    },
                  ),
                  Consumer<CartModel>(
                      builder: (context, cart, child) {
                        return Text("Total price: ${cart.totalPrice}");
                      }
                  ),
                ])
        )
    );
  }
}