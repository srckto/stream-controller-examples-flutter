import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stream_examples/product/product_controller.dart';
import 'package:stream_examples/product/product_model.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductController productController = ProductController();
  TextStyle _myStyle = TextStyle(
    fontSize: 20,
  );

  @override
  void dispose() {
    super.dispose();
    productController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Screen"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: productController.productsStream,
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) return Center(child: Text("Error"));
              if (!snapshot.hasData) return Center(child: Text("No Data"));
              if (snapshot.data != null && snapshot.data!.isEmpty)
                return Center(child: Text("Empty Products"));
              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 0);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(snapshot.data![index].title!, style: _myStyle),
                        TextButton(
                          onPressed: () {
                            productController.removeProductSink.add(snapshot.data![index]);
                          },
                          child: Text("REMOVE"),
                        ),
                      ],
                    ),
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Random random = Random();
          int number = random.nextInt(100);
          ProductModel model = ProductModel(
            id: "123",
            title: "$number titles",
            description: "$number any desc",
          );
          productController.addProductSink.add(model);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
