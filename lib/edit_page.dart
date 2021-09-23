import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  EditPage({Key? key, required this.list, required this.index})
      : super(key: key);

  final List list;
  final int index;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerStock = TextEditingController();

  var url = Uri.parse("https://ublmobilekmmi.web.id/flutter_store/update.php");

  void editData() {
    http.post(url, body: {
      "id": widget.list[widget.index]["id"],
      "item_name": controllerName.text,
      "item_code": controllerCode.text,
      "price": controllerPrice.text,
      "stock": controllerStock.text,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    controllerCode =
        TextEditingController(text: widget.list[widget.index]["item_code"]);
    controllerName =
        TextEditingController(text: widget.list[widget.index]["item_name"]);
    controllerPrice =
        TextEditingController(text: widget.list[widget.index]["price"]);
    controllerStock =
        TextEditingController(text: widget.list[widget.index]["stock"]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Data"),
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
                  if (controllerCode.text.length != 0 &&
                      controllerName.text.length != 0 &&
                      controllerPrice.text.length != 0 &&
                      controllerStock.text.isNotEmpty) {
                    editData();
                    Navigator.pop(context);
                    print(controllerCode.text);
                  } else {
                    print("Isi semua data");
                  }
                },
                child: Text('Edit Data', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
