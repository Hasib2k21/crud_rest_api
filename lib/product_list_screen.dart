import 'package:crud_rest_api/add_product_screen.dart';
import 'package:crud_rest_api/update_product_screen.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildProductItem();
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProductScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildProductItem() {
    return ListTile(
      leading: Image.network(
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
        height: 60,
      ),
      title: const Text("Product name"),
      subtitle: const Wrap(
        spacing: 16,
        children: [
          Text("Unit Price: 100"),
          Text("Quantity: 100"),
          Text("Total Price: 100"),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProductScreen()));
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {_showDeleteConfirmationDialog();},
            icon: const Icon(Icons.delete_outline_sharp),
          ),
        ],
      ),
    );
  }
  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure that you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Yes, delete'),
            ),
          ],
        );
      },
    );
  }
}
