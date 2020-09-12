import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kart_list/pages/pages_presentation.dart';

void main() {
  runApp(Kartlist());
}

class Kartlist extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _KartlistState createState() => _KartlistState();
}

class _KartlistState extends State<Kartlist> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de compras para el super',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => Presentation(),
        );
      },
    );
  }
}
