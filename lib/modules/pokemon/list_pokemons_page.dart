import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/models/pokeApi_model.dart';
import 'package:pokeapp/modules/pokemon/details_pokemon_page.dart';
import 'package:pokeapp/resources/pokemon_servicos.dart';
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
              padding: const EdgeInsets.only(top: 20),
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
    await PokemonServicos.getPokemons(listPokemons.next!).then((value) {
      listPokemons.next = value.next;
      listPokemons.previous = value.previous;
      listPokemons.results = [...listPokemons.results!, ...value.results!];
      _loading = false;
      setState(() {});
    });
  }
}
