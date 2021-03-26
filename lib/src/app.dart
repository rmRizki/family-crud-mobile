import 'package:family/src/ui/edit.dart';
import 'package:family/src/ui/form.dart';
import 'package:family/src/ui/home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Family',
      initialRoute: '/',
      routes: {
        "/": (context) => HomePage(),
        "/form": (context) => FormPage(),
        "/edit": (context) =>
            EditPage(family: ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
