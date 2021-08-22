import 'package:flutter/material.dart';
import 'package:pokeapp/models/pokeApi_model.dart';
import 'package:pokeapp/modules/pokemon/list_pokemons_page.dart';
import 'package:pokeapp/resources/pokemon_servicos.dart';
import 'package:pokeapp/styles/components/carrega_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isBusy = true;
  PokeApi listPokemons = PokeApi();

  void initState() {
    PokemonServicos.getPokemons("https://pokeapi.co/api/v2/pokemon/?limit=5")
        .then((value) {
      listPokemons = value;
      setState(() {
        isBusy = false;
      });
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isBusy ? CarregaPage() : ListPokemonsPage(listPokemons);
  }
}
