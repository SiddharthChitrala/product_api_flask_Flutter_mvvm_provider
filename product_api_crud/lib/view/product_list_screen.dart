import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/components/product_list_form.dart';
import '../vm/product_view_model.dart';


class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: productViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productViewModel.errorMessage != null
              ? Center(child: Text(productViewModel.errorMessage!))
              : ListView.builder(
                  itemCount: productViewModel.products.length,
                  itemBuilder: (context, index) {
                    final product = productViewModel.products[index];
                    return ListTile(
                      title: Text(product.name ?? ''),
                      subtitle: Text('\$${product.price?.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Navigate to ProductFormScreen for editing
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductFormScreen(product: product),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              productViewModel.deleteProduct(product.id!);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to ProductFormScreen for creating a new product
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
