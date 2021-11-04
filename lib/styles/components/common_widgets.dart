import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    title: Image.asset('assets/pokemon_logo.png', fit: BoxFit.cover),
    centerTitle: true,
  );
}

Text buildText(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
  );
}

Widget loadWidget() {
  return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
}

Future<void> showMyDialog(
    BuildContext context, String title, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(text),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
