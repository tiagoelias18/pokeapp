import 'package:flutter/material.dart';
import 'package:pokeapp/styles/components/common_widgets.dart';

class CarregaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/pokemon_logo.png"),
          SizedBox(height: 50),
          loadWidget()
        ],
      ),
    );
  }
}