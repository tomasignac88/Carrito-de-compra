import 'package:flutter/material.dart';
import 'package:kart_list/pages/pages_list.dart';

class Presentation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Container(
        width: _screensize.width,
        height: _screensize.height,
        child: Center(
          child: Column(children: [
            Expanded(
                flex: 3,
                child: FadeInImage(
                    placeholder: AssetImage("assets/images/karrito.jpg"),
                    image: AssetImage("assets/images/karrito.jpg"))),
            Container(
              width: _screensize.width / 2,
              child: FittedBox(
                child: FlatButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageList()),
                      );
                    },
                    child: Text("Empezar")),
              ),
            ),
            Container(
                height: _screensize.height / 3,
                child: FittedBox(
                  child: Text(
                    "KARTLIST",
                    style: TextStyle(decoration: TextDecoration.overline),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
