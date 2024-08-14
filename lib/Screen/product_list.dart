import 'package:crud_rest_api/Screen/product_create.dart';
import 'package:crud_rest_api/Screen/product_update.dart';
import 'package:crud_rest_api/style/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../RestApi/rest_client.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List ProductList = [];
  bool isLoading = true;

  @override
  void initState() {
    CallData();
    super.initState();
  }

  CallData() async {
    isLoading = true;
    var data = await ProductGridViewisRequest();
    setState(() {
      ProductList = data;
      isLoading = false;
    });
  }

  DeleteItem(id) async {
    showDialog(
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
            title: Text('Delete!'),
            content: Text('Do you Want to Delete?'),
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      isLoading = true;
                    });
                    await ProductDeleteRequest(id);
                    await CallData();
                  },
                  child: Text('Yes')),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Product'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductCreateScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: isLoading
                ? (Center(
                    child: CircularProgressIndicator(),
                  ))
                : RefreshIndicator(
                    onRefresh: () async {
                      await CallData();
                    },
                    child: GridView.builder(
                      gridDelegate: ProductGridView(),
                      itemCount: ProductList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: Image.network(
                                ProductList[index]['Img'],
                                fit: BoxFit.fill,
                              )),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 5, bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(ProductList[index]['ProductName']),
                                    Gap(7),
                                    Text("Price" +
                                        ProductList[index]
                                            ['UnitPrice' + "BDT"]),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                            ProductUpdate(productItem: {},)));

                                            },
                                            child: const Icon(Icons.edit),),
                                        OutlinedButton(
                                            onPressed: () {
                                              DeleteItem(
                                                  ProductList[index]['_id']);
                                            },
                                            child: const Icon(Icons.delete)),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
