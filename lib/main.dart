import 'dart:convert';

import 'package:data_fetch/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<ProductModel>> _getProduct() async {
    var response = await http.get("https://bigagora24.com/apps/getproduct.php");
    var jsonResponse = json.decode(response.body);

    List<ProductModel> products = [];

    for (var i in jsonResponse['products']) {
      try {
        ProductModel data = ProductModel(
          productId: i['product_id'].toString(),
          productName: i['product_name'].toString(),
          productPrice: i['product_price'].toString(),
          productCatId: i['product_cat_id'].toString(),
          productCatSub: i['product_cat_sub'].toString(),
          productCatBrand: i['product_cat_brand'].toString(),
          productDetails: i['product_details'].toString(),
          productImage: i['product_image'].toString(),
          productQun: i['product_qun'].toString(),
          discount: i['discount'].toString(),
          entryby: i['entryby'].toString(),
        );
        products.add(data);
      } catch (e) {
        print(e);
      }
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text(
                "ALL PRODUCTS",
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: productFuture(),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<ProductModel>> productFuture() {
    return FutureBuilder(
      future: _getProduct(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 20,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var item = snapshot.data[index];
              var thumb =
                  'http://bigagora24.com/dashboard/uploads/${item.productImage}';
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(item.productName),
                      trailing: Text("${item.productPrice}"),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(thumb),
                        radius: 25,
                      ),
                      onLongPress: () {
                        return showSmartDialog(
                            context: context,
                            child: CupertinoAlertDialog(
                              title: Text(item.productName),
                              content: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(item.productDetails),
                              ),
                              actions: <Widget>[
                                CupertinoButton(
                                  child: Text("Order"),
                                  onPressed: () {},
                                ),
                                CupertinoButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                
                                
                              ],
                            ));
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void showSmartDialog({BuildContext context, Widget child}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }
}
