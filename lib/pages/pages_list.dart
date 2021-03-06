import 'package:ZocoKarrito/modelo/Products.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class PageList extends StatefulWidget {
  PageList();

  @override
  _PageListState createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  //DEFINO VARIABLES A UTILIZAR
  List<Product> _zocoKarrito = List();
  List<String> listProducts = List();
  String producto;
  String price;
  double _total = 0;
  bool _sharedpreferences = true;
  TextEditingController _controllerTextEditing;
  TextEditingController _controllerTextEditing2;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Lista de productos"),
      ),
      drawer: drawer(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: _screensize.width,
          height: _screensize.height,
          child: Column(
            children: [
              textfield(),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: _sharedpreferences
                            ? productsSave()
                            : boxlistproducts()),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget listproducts() {
    return Container(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _zocoKarrito.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: _zocoKarrito[index].color,
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Badge(
                              badgeContent: GestureDetector(
                                child: Icon(Icons.clear),
                                onTap: () {
                                  setState(() {
                                    _zocoKarrito[index].price == null
                                        ? _total = _total
                                        : _total =
                                            _total - _zocoKarrito[index].price;
                                    _zocoKarrito.removeAt(index);
                                    cleanSF();
                                    addListStringToSF(_zocoKarrito);
                                  });
                                },
                              ),
                              badgeColor: Colors.yellow,
                              child: Container(
                                child: CheckboxListTile(
                                  checkColor: Colors.black,
                                  title: Text(_zocoKarrito[index].name),
                                  value: _zocoKarrito[index].value,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _zocoKarrito[index].value = value;
                                      if (value) {
                                        _zocoKarrito[index].color =
                                            Colors.green;
                                      } else {
                                        _zocoKarrito[index].color =
                                            Colors.white;
                                      }
                                    });
                                  },
                                ),
                              )),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _controllerTextEditing,
                          style: TextStyle(fontSize: 20),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(12),
                            FilteringTextInputFormatter.allow(
                                RegExp(r"^\d+\.?\d{0,2}"))
                          ],
                          decoration: InputDecoration(
                            hintText: "\$ 0.00",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          onChanged: (texto) {
                            _zocoKarrito[index].price = double.parse(texto);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  //LOGICA DEL MENU HAMBURGUESA (HERRAMIENTAS)
  Drawer drawer() {
    final _screensize = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
                width: _screensize.width,
                height: _screensize.height,
                child: FadeInImage(
                    placeholder: AssetImage(
                        "assets/images/logo_negro_amarillo_zoco.png"),
                    image: AssetImage(
                        "assets/images/logo_negro_amarillo_zoco.png"))),
          ),
          ListTile(
            title: Column(children: [
              FlatButton(
                  color: Colors.yellow,
                  child: Row(
                    children: [
                      Expanded(child: Icon(Icons.clear_all)),
                      Expanded(child: Text("Limpiar lista guardada")),
                    ],
                  ),
                  onPressed: () {
                    SweetAlert.show(context,
                        title: "Lista limpia!", style: SweetAlertStyle.success);
                    setState(() {
                      cleanSF();
                    });
                  })
            ]),
          ),
          ListTile(
            title: Column(children: [
              FlatButton(
                  color: Colors.yellow,
                  child: Row(
                    children: [
                      Expanded(child: Icon(Icons.clear_all)),
                      Expanded(child: Text("Limpiar lista")),
                    ],
                  ),
                  onPressed: () {
                    SweetAlert.show(context,
                        title: "Lista limpia!", style: SweetAlertStyle.success);
                    setState(() {
                      _zocoKarrito.clear();
                      _total = 0;
                    });
                  })
            ]),
          ),
        ],
      ),
    );
  }

  //LOGICA DE TEXTFIELD QUE AGREGA LOS PRODUCTOS A LA LISTA Y AL SharedPreferences
  Widget textfield() {
    Product product = Product();
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _controllerTextEditing2,
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                    hoverColor: Colors.yellow,
                    focusColor: Colors.yellow,
                    fillColor: Colors.yellow,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: "Escriba producto",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.black),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // _controllerTextEditing2.clear(); Se comenta para futuro desarrollo
                      },
                      icon: Icon(Icons.clear),
                    )),
                onChanged: (texto) {
                  producto = texto;
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                            // color: Colors.black38,
                            child: FlatButton(
                                color: Colors.yellow,
                                child: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    product.name = producto;
                                    product.value = false;
                                    product.color = Colors.white;
                                    _zocoKarrito.add(product);
                                    addListStringToSF(_zocoKarrito);
                                    FocusScope.of(context).unfocus();
                                  });
                                })),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //LISTA DE PRODUCTOS, CON PRECIOS
  Widget boxlistproducts() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey,
              child: Column(
                children: [
                  Expanded(child: listproducts()),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.yellow),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Expanded(
                                child: FlatButton(
                                  child: Text("Sumar productos"),
                                  onPressed: () {
                                    setState(() {
                                      _total = 0;
                                      for (var i = 0;
                                          i < _zocoKarrito.length;
                                          i++) {
                                        _total += _zocoKarrito[i].price == null
                                            ? 0
                                            : _zocoKarrito[i].price;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.yellow),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_bag),
                              Expanded(
                                child: Text(
                                  "Total \$" + _total.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //LOGICA QUE PREGUNTA SI HAY DATOS GUARDADOS PARA MOSTRARLOS AL INICIAR LA APLICACIÓN
  Widget productsSave() {
    return Container(
      child: FutureBuilder(
          future: getStringValuesSF(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _sharedpreferences = false;
              int i = 0;
              //seteo los productos guardados en la lista karrito
              for (var item in snapshot.data) {
                Product temp = new Product();
                temp.id = i;
                temp.name = item;
                temp.color = Colors.white;
                temp.value = false;
                _zocoKarrito.add(temp);
                i++;
              }
              // print(_zocoKarrito);
              return Column(children: [
                Expanded(
                  child: Container(child: boxlistproducts()),
                ),
              ]);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

//LIMPIA LOCAL STORAGE DEL CEL (SharedPreferences)
cleanSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

//AGREGAMOS PRODUCTOS AL LOCAL STORAGE DEL CEL (SharedPreferences)
addListStringToSF(List<Product> listProducts) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  List<String> newListProducts = [];
  for (var item in listProducts) {
    newListProducts.add(item.name.toString());
  }
  prefs.setStringList('my_string_list_key', newListProducts);
}

//LOGICA PAR OBTENER LOS DATOS QUE TIENE EL LOCAL STORAGE
getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  final myStringList = prefs.getStringList('my_string_list_key') ?? [];
  // print("Guardado: " + myStringList.toString());
  return myStringList;
}
