import 'package:flutter/material.dart';
import 'package:pokeapp/models/pokemon_model.dart';
import 'package:pokeapp/styles/components/color_type.dart';
import 'package:pokeapp/styles/components/common_widgets.dart';
import '../../pokemon_detail/details_pokemon_page.dart';

class CardPokemon extends StatelessWidget {
  final Pokemon pokemon;
  
  const CardPokemon({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailsPokemonPage(pokemon)));
      },
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 10,
        margin: EdgeInsets.only(
            left: width * 0.04, right: width * 0.04, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  colors: [
                    colorByType(
                        pokemon.types![0].type!.name!),
                    Theme.of(context).primaryColor,
                  ],
                  stops: [
                    0.3,
                    1.0
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated)),
          child: Column(
            children: [
              SizedBox(height: 10),
              buildText(pokemon.name!.toUpperCase()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: BoxConstraints.tightFor(height: 125),
                      child: Image.network(
                        pokemon.frontDefault!,
                        errorBuilder: (context, exception, stackTrack) => Icon(
                          Icons.error,
                        ),
                      ),
                    ),
                    buildText("#" + pokemon.id!.toString().padLeft(4, '0')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
