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
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }