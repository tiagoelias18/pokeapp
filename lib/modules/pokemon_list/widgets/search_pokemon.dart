import 'package:flutter/material.dart';
import 'package:pokeapp/resources/pokemon_servicos.dart';
import 'package:pokeapp/styles/components/carrega_page.dart';
import 'package:pokeapp/styles/components/common_widgets.dart';

import '../../pokemon_detail/details_pokemon_page.dart';

class SearchPokemon extends StatefulWidget {
  const SearchPokemon({Key? key}) : super(key: key);

  @override
  _SearchPokemonState createState() => _SearchPokemonState();
}

class _SearchPokemonState extends State<SearchPokemon> {
  TextEditingController _tecSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.only(left: width * 0.04, right: width * 0.04, top: 20),
      child: Container(
        padding: EdgeInsets.only(left: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        child: TextField(
          controller: _tecSearch,
          cursorColor: Theme.of(context).primaryColor,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: "Find your Pokémon",
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                await searchPokemon(_tecSearch.text.toLowerCase());
              },
            ),
          ),
          onEditingComplete: () async {
            await searchPokemon(_tecSearch.text.toLowerCase());
          },
        ),
      ),
    );
  }

  searchPokemon(String namePokemon) async {
    FocusScope.of(context).unfocus();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CarregaPage()));
    await PokemonServicos.getSpecificPokemon(namePokemon).then((value) {
      Navigator.pop(context);
      value.name == null
          ? showMyDialog(
              context, "Search Error", "Pokémon not found, try again.")
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPokemonPage(value)));
    });
  }
}
