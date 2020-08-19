import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de compras para el super',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _kart_list = List();
  @override
  void setState(fn) {
    print(_kart_list);
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    String producto;
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de compras"),
        centerTitle: true,
      ),
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
                        decoration: InputDecoration(
                            hintText: "Ingrese el producto a su lista",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                        onChanged: (texto) {
                          producto = texto;
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                          // color: Colors.black38,
                          child: FlatButton(
                              color: Colors.blue,
                              child: Text("Agregar a la lista"),
                              onPressed: () {
                                setState(() {
                                  _kart_list.add(producto);
                                  print(_kart_list);
                                });
                              })),
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
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _kart_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: CheckboxListTile(
                                    title: Text(_kart_list[index].toString()),
                                    value: timeDilation != 1.0,
                                    onChanged: (bool value) {
                                      setState(() {
                                        timeDilation = value ? 10.0 : 1.0;
                                      });
                                    },
                                    secondary:
                                        const Icon(Icons.hourglass_empty),
                                  )),
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
