import 'package:flutter/material.dart';
import 'package:flutter_mystore/home_page.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);

  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerStock = TextEditingController();

  var url = Uri.parse("https://ublmobilekmmi.web.id/flutter_store/insert.php");
  void addData() {
    http.post(url, body: {
      "item_code": controllerCode.text,
      "item_name" : controllerName.text,
      "price": controllerPrice.text,
      "stock": controllerStock.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Data"),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: controllerCode,
                  decoration: InputDecoration(
                      hintText: "Item Code", labelText: "Item Code")),
              TextField(
                controller: controllerName,
                  decoration: InputDecoration(
                      hintText: "Item Name", labelText: "Item Name")),
              TextField(
                controller: controllerPrice,
                  decoration:
                      InputDecoration(hintText: "Price", labelText: "Price")),
              TextField(
                controller: controllerStock,
                  decoration:
                      InputDecoration(hintText: "Stock", labelText: "Stock")),
              SizedBox(height: 10.0),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    return Colors.blue;
                  }),
                ),
                onPressed: () {
                  //TODO: ADD ThIS SHIT
                  if(controllerCode.text.length != 0 && controllerName.text.length != 0 && controllerPrice.text.length != 0 && controllerStock.text.isNotEmpty) {
                    addData();
                    Navigator.pop(context);
                    print(controllerCode.text);
                  } else {
                    print("Isi semua data");
                  }
                },
                child: Text('Add Data', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
