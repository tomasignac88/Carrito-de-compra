import 'package:flutter/material.dart';
import 'package:kart_list/pages/pages_list.dart';
import 'package:kart_list/pages/pages_presentation.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => Presentation(), //Pagina principal
    'pages_list': (BuildContext context) => PageList(), //Pagina carrito
  };
}
