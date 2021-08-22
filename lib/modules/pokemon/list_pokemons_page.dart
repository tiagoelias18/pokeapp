import 'package:flutter/material.dart';
import 'package:pokeapp/models/pokeApi_model.dart';
import 'package:pokeapp/modules/pokemon/details_pokemon_page.dart';
import 'package:pokeapp/resources/pokemon_servicos.dart';
import 'package:pokeapp/styles/components/carrega_page.dart';
import 'package:pokeapp/styles/components/color_type.dart';
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
  TextEditingController _tecSearch = TextEditingController();

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
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: buildAppBar(),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.04, right: width * 0.04, top: 20),
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: listPokemons.results!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPokemonPage(
                                    listPokemons.results![index])));
                      },
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        elevation: 10,
                        margin: EdgeInsets.only(
                            left: width * 0.04,
                            right: width * 0.04,
                            bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    colorByType(listPokemons
                                        .results![index].types![0].type!.name!),
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
                              buildText(listPokemons.results![index].name!
                                  .toUpperCase()),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      constraints:
                                          BoxConstraints.tightFor(height: 125),
                                      child: Image.network(listPokemons
                                          .results![index].frontDefault!),
                                    ),
                                    buildText("#" +
                                        listPokemons.results![index].id!
                                            .toString()
                                            .padLeft(4, '0'))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)),
                  )
                : SizedBox()
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
