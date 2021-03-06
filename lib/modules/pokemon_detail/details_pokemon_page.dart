import 'package:flutter/material.dart';
import 'package:pokeapp/models/pokemon_model.dart';
import 'package:pokeapp/modules/pokemon_detail/widgets/infos_box.dart';
import 'package:pokeapp/styles/components/color_type.dart';
import 'package:pokeapp/styles/components/common_widgets.dart';

// ignore: must_be_immutable
class DetailsPokemonPage extends StatelessWidget {
  late Pokemon pokemon;
  DetailsPokemonPage(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                      colorByType(pokemon.types![0].type!.name!),
                      Theme.of(context).primaryColor,
                    ],
                        stops: [
                      0,
                      1.0
                    ],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        tileMode: TileMode.repeated)),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildText(pokemon.name!.toUpperCase()),
                        buildText("#" + pokemon.id!.toString().padLeft(4, '0')),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      constraints: BoxConstraints.tightFor(height: 200),
                      child: Image.network(
                        pokemon.frontDefault!,
                        errorBuilder: (context, exception, stackTrack) => Icon(
                          Icons.error,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    buildText("Main type: " + pokemon.types![0].type!.name!.toUpperCase()),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InfosBox(title: "Height", text: (pokemon.height!/10).toString() + " m"),
                        InfosBox(title: "Width", text: (pokemon.weight!/10).toString() + " kg")
                      ],
                    ),
                    SizedBox(height: 20),
                    InfosBox(title: "Exp", text: (pokemon.baseExperience).toString())
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
