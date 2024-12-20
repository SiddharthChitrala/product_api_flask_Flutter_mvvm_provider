import 'package:flutter/foundation.dart';

import '../models/product_model.dart';
import '../provider/product_repository.dart';


class ProductViewModel with ChangeNotifier {
  final _productRepo = ProductRepository();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    setLoading(true);
    setErrorMessage(null);
    try {
      _products = await _productRepo.fetchProducts();
    } catch (e) {
      setErrorMessage('Error fetching products: $e');
    }
    setLoading(false);
  }

  Future<void> createProduct(ProductModel product) async {
    setLoading(true);
    setErrorMessage(null);
    try {
      ProductModel newProduct = await _productRepo.createProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      setErrorMessage('Error creating product: $e');
    }
    setLoading(false);
  }

  Future<void> updateProduct(ProductModel product) async {
    setLoading(true);
    setErrorMessage(null);
    try {
      ProductModel updatedProduct =
          await _productRepo.updateProduct(product);
      int index =
          _products.indexWhere((element) => element.id == updatedProduct.id);
      _products[index] = updatedProduct;
      notifyListeners();
    } catch (e) {
      setErrorMessage('Error updating product: $e');
    }
    setLoading(false);
  }

  Future<void> deleteProduct(int id) async {
    setLoading(true);
    setErrorMessage(null);
    try {
      await _productRepo.deleteProduct(id);
      _products.removeWhere((product) => product.id == id);
      notifyListeners();
    } catch (e) {
      setErrorMessage('Error deleting product: $e');
    }
    setLoading(false);
  }
}
