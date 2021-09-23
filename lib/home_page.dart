// ignore_for_file: non_constant_identifier_names, unnecessary_new, prefer_const_constructors, unnecessary_null_comparison, prefer_const_constructors_in_immutables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mystore/add_page.dart';
import 'package:flutter_mystore/detail_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = Uri.parse("https://ublmobilekmmi.web.id/flutter_store/select.php");

  Future<List> getData() async {
    final response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("MY STORE"),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPage(),
                      ),
                    );
            }, child: Icon(Icons.add)),
        body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemList(
                    list: snapshot.data!,
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  final List list;
  ItemList({Key? key, required this.list}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(5.0),
          child: new GestureDetector(
            child: new Card(
              child: new ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        id: i,
                        list: widget.list,
                      ),
                    ),
                  );
                },
                title: new Text(widget.list[i]['item_name']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Stock : ${widget.list[i]['stock']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
