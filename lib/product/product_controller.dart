import 'dart:async';

import 'package:stream_examples/contracts/disposable.dart';
import 'package:stream_examples/product/product_model.dart';

class ProductController implements Disposable {
  late List<ProductModel> _products;

  final StreamController<List<ProductModel>> _productsController =
      StreamController<List<ProductModel>>();
  Stream<List<ProductModel>> get productsStream => _productsController.stream;
  StreamSink<List<ProductModel>> get productsSink => _productsController.sink;

  final StreamController<ProductModel> _addProductController = StreamController<ProductModel>();
  StreamSink<ProductModel> get addProductSink => _addProductController.sink;

  final StreamController<ProductModel> _removeProductController = StreamController<ProductModel>();
  StreamSink<ProductModel> get removeProductSink => _removeProductController.sink;

  ProductController() {
    _products = [];
    _productsController.add(_products);
    _addProductController.stream.listen(_addProduct);
    _removeProductController.stream.listen(_removeProduct);
  }

  void _addProduct(ProductModel model) {
    _products.add(model);
    productsSink.add(_products);
  }

  void _removeProduct(ProductModel model) {
    _products.remove(model);
    productsSink.add(_products);
  }

  @override
  void dispose() {
    _productsController.close();
    _addProductController.close();
    _removeProductController.close();
  }
}
