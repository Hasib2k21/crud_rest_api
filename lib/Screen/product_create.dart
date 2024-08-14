import 'package:flutter/material.dart';

import '../RestApi/rest_client.dart';
import '../Style/Style.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  Map<String, String> FormValues = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": ""
  };
  bool Loading = false;

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['Img']!.isEmpty) {
      ErrorToast('Image Link Required !');
    } else if (FormValues['ProductCode']!.isEmpty) {
      ErrorToast('Product Code Required !');
    } else if (FormValues['ProductName']!.isEmpty) {
      ErrorToast('Product Name Required !');
    } else if (FormValues['Qty']!.isEmpty) {
      ErrorToast('Product Qty Required !');
    } else if (FormValues['TotalPrice']!.isEmpty) {
      ErrorToast('Total Price Required !');
    } else if (FormValues['UnitPrice']!.isEmpty) {
      ErrorToast('Unit Price Required !');
    } else {
      setState(() {
        Loading = true;
      });
      await ProductCreateRequest(FormValues);
      setState(() {
        Loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: Loading
                ? (Center(
                    child: CircularProgressIndicator(),
                  ))
                : ((SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("ProductName", Textvalue);
                          },
                          decoration: AppInputDecoration('Product Name'),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("ProductCode", Textvalue);
                          },
                          decoration: AppInputDecoration('Product Code'),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("Img", Textvalue);
                          },
                          decoration: AppInputDecoration('Product Image'),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("UnitPrice", Textvalue);
                          },
                          decoration: AppInputDecoration('Unit Price'),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (Textvalue) {
                            InputOnChange("TotalPrice", Textvalue);
                          },
                          decoration: AppInputDecoration('Total Price'),
                        ),
                        SizedBox(height: 20),
                        AppDropDownStyle(DropdownButton(
                          value: FormValues['Qty'],
                          items: const [
                            DropdownMenuItem(
                              child: Text('Select Qt'),
                              value: "",
                            ),
                            DropdownMenuItem(
                              child: Text('1 pcs'),
                              value: "1 pcs",
                            ),
                            DropdownMenuItem(
                              child: Text('2 pcs'),
                              value: '2 pcs',
                            ),
                            DropdownMenuItem(
                              child: Text('3 pcs'),
                              value: '3 pcs',
                            ),
                            DropdownMenuItem(
                              child: Text('4 pcs'),
                              value: '4 pcs',
                            ),
                          ],
                          onChanged: (Textvalue) {
                            InputOnChange("Qty", Textvalue);
                          },
                          underline: Container(),
                          isExpanded: true,
                        )),
                        SizedBox(height: 20),
                        Container(
                          child: ElevatedButton(
                              style: AppButtonStyle(),
                              onPressed: () {
                                FormOnSubmit();
                              },
                              child: SuccessButtonChild('Submit')),
                        )
                      ],
                    ),
                  ))),
          ),
        ],
      ),
    );
  }
}
