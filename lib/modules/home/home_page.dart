import 'package:flutter/material.dart';
import 'package:pokeapp/models/pokeApi_model.dart';
import 'package:pokeapp/modules/pokemon_list/list_pokemons_page.dart';
import 'package:pokeapp/resources/pokemon_servicos.dart';
import 'package:pokeapp/styles/components/carrega_page.dart';
import 'package:pokeapp/styles/components/network_error_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isBusy = true;
  bool isOnline = true;
  PokeApi listPokemons = PokeApi();

  void initState() {
    PokemonServicos.getPokemons("https://pokeapi.co/api/v2/pokemon/?limit=10")
        .then((value) {
      listPokemons = value;
      setState(() {
        listPokemons.count == null ? isOnline = false : isOnline = true;
        isBusy = false;
      });
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isBusy ? CarregaPage() : isOnline ? ListPokemonsPage(listPokemons) : NetworkErrorPage();
  }
}
