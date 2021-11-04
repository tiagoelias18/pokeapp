import 'package:flutter/material.dart';
import 'package:pokeapp/models/pokeApi_model.dart';
import 'package:pokeapp/modules/pokemon_list/widgets/card_pokemon.dart';
import 'package:pokeapp/modules/pokemon_list/widgets/search_pokemon.dart';
import 'package:pokeapp/resources/pokemon_servicos.dart';
import 'package:pokeapp/styles/components/common_widgets.dart';

// ignore: must_be_immutable
class ListPokemonsPage extends StatefulWidget {
  PokeApi listPokemons;
  ListPokemonsPage(this.listPokemons);

  @override
  _ListPokemonsPageState createState() => _ListPokemonsPageState();
}

class _ListPokemonsPageState extends State<ListPokemonsPage> {
  PokeApi listPokemons = PokeApi();
  ScrollController _scrollController = ScrollController();
  bool _loading = false;

  @override
  void initState() {
    listPokemons = widget.listPokemons;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetch();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: buildAppBar(),
        body: Stack(
          children: [
            SearchPokemon(),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: listPokemons.results!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardPokemon(pokemon: listPokemons.results![index]);
                  }),
            ),
            Visibility(
              visible: _loading,
              child: Center(
                child: loadWidget()
              ),
            )
          ],
        ));
  }

  fetch() async {
    setState(() {
      _loading = true;
    });
    listPokemons.next == null
        ? showMyDialog(
            context, "End of list", "Congratulations, you found all pokémons.")
        : await PokemonServicos.getPokemons(listPokemons.next!).then((value) {
            if (value.next == null) {
              showMyDialog(context, "Network error",
                  "There was an error in your connection or connection with Api. Try again later.");
            } else {
              listPokemons.next = value.next;
              listPokemons.previous = value.previous;
              listPokemons.results = [
                ...listPokemons.results!,
                ...value.results!
              ];
            }
            _loading = false;
            setState(() {});
          });
  }
}
