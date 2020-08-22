import 'package:kart_list/modelo/Products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class PageList extends StatefulWidget {
  PageList();

  @override
  _PageListState createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  List<Product> _kart_list = List();
  List<String> listProducts = List();
  String producto;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Product product = Product();
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                // color: Colors.red,
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 30),
                        decoration: InputDecoration(
                            hintText: "Escriba producto",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                        onChanged: (texto) {
                          producto = texto;
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            // color: Colors.black38,
                            child: FlatButton(
                                color: Colors.blue,
                                child: Text("Agregar a la lista"),
                                onPressed: () {
                                  setState(() {
                                    print("Producto: " + producto);
                                    print("kart_list " + _kart_list.toString());
                                    product.name = producto;
                                    product.value = false;
                                    product.color = Colors.white;
                                    _kart_list.add(product);
                                    print("kart_list new :" +
                                        _kart_list.toString());
                                    print(listProducts);
                                    addStringToSF(producto, listProducts);
                                  });
                                })),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // color: Colors.blue,
                    // child: getStringValuesSF() != []
                    child: _kart_list.length == 0
                        ? FutureBuilder(
                            future: getStringValuesSF(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Product temp = Product();
                                for (var item in snapshot.data) {
                                  temp.name = item;
                                  temp.color = Colors.white;
                                  temp.value = false;
                                  _kart_list.add(temp);
                                  print("Lista new " + item);
                                }
                                return ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Badge(
                                                badgeContent: GestureDetector(
                                                  child: Icon(Icons.cancel),
                                                  onTap: () {
                                                    print("borrar");
                                                  },
                                                ),
                                                badgeColor: Colors.blue,
                                                child: Container(
                                                  child: CheckboxListTile(
                                                    checkColor: Colors.black,
                                                    title: Text(
                                                        snapshot.data[index]),
                                                    value: false,
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        _kart_list[index]
                                                            .value = value;
                                                        if (value) {
                                                          _kart_list[index]
                                                                  .color =
                                                              Colors.green;
                                                        } else {
                                                          _kart_list[index]
                                                                  .color =
                                                              Colors.white;
                                                        }
                                                      });
                                                    },
                                                    secondary: Icon(
                                                        Icons.insert_emoticon),
                                                  ),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                return CircularProgressIndicator();
                              }
                            })
                        : ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: _kart_list.length,
                            itemBuilder: (BuildContext context, int index) {
                              print("Segundo builder");
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: _kart_list[index].color,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Badge(
                                              badgeContent: GestureDetector(
                                                child: Icon(Icons.cancel),
                                                onTap: () {
                                                  setState(() {
                                                    _kart_list.removeLast();
                                                  });
                                                },
                                              ),
                                              badgeColor: Colors.blue,
                                              child: Container(
                                                child: CheckboxListTile(
                                                  checkColor: Colors.black,
                                                  title: Text(
                                                      _kart_list[index].name),
                                                  value:
                                                      _kart_list[index].value,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      _kart_list[index].value =
                                                          value;
                                                      if (value) {
                                                        _kart_list[index]
                                                                .color =
                                                            Colors.green;
                                                      } else {
                                                        _kart_list[index]
                                                                .color =
                                                            Colors.white;
                                                      }
                                                    });
                                                  },
                                                  secondary: Icon(
                                                      Icons.insert_emoticon),
                                                ),
                                              ))),
                                    ],
                                  ),
                                ),
                              );
                            }),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

addStringToSF(String producto, List<String> listProducts) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  listProducts.add(producto);
  print("Lista:" + json.encode(listProducts));
  prefs.setStringList('my_string_list_key', listProducts);
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  final myStringList = prefs.getStringList('my_string_list_key') ?? [];
  print("Guardado: " + myStringList.toString());
  return myStringList;
}
