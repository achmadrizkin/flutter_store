import 'package:flutter/material.dart';
import 'package:flutter_mystore/edit_page.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.list, required this.id})
      : super(key: key);

  final List list;
  final int id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var store = widget.list[widget.id];

    var url =
        Uri.parse("https://ublmobilekmmi.web.id/flutter_store/delete.php");
    void deleteData() {
      http.post(url, body: {
      "id": widget.list[widget.id]["id"],
    });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(store["item_name"]),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  store["item_name"],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "Code: " + store["item_code"],
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Price: " + store["price"],
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Stock: " + store["stock"],
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => EditPage(
                              index: widget.id,
                              list: widget.list,
                            ),
                          ),
                        );
                      },
                      child: Text("EDIT"),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        deleteData();
                        Navigator.pop(context);
                      },
                      child: Text("DELETE"),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
