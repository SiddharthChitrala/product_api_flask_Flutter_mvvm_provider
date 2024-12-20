import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../models/product_model.dart';
import '../res/app_url.dart'; // Import AppUrl

class ProductRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<List<ProductModel>> fetchProducts() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.products);
      return (response as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.products, product.toJson());
      return ProductModel.fromJson(response);
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      dynamic response = await _apiServices.getUpdateApiResponse(
          '${AppUrl.products}/${product.id}', product.toJson());
      return ProductModel.fromJson(response);
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _apiServices.getDeleteApiResponse('${AppUrl.products}/$id');
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
