import 'package:flutter/material.dart';
import 'package:ZocoKarrito/pages/pages_list.dart';

class Presentation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: _screensize.width,
        height: _screensize.height,
        child: Center(
          child: Column(children: [
            Expanded(
                flex: 3,
                child: FadeInImage(
                    placeholder: AssetImage(
                        "assets/images/logo_negro_amarillo_zoco.png"),
                    image: AssetImage(
                        "assets/images/logo_negro_amarillo_zoco.png"))),
            Container(
              width: _screensize.width / 2,
              child: FittedBox(
                child: FlatButton(
                    color: Colors.yellow,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageList()),
                      );
                    },
                    child: Text(
                      "Empezar",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            ),
            Container(
                height: _screensize.height / 3,
                child: FittedBox(
                  child: Text(
                    "ZocoKarrito",
                    style: TextStyle(decoration: TextDecoration.overline),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
