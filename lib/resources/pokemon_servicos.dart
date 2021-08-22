import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokeapp/models/pokeApi_model.dart';
import 'package:pokeapp/models/pokemon_model.dart';

final String urlApi = "https://pokeapi.co/api/v2/pokemon";

class PokemonServicos {
  //Autor do comentário: Tiago Elias
  //Data do comentário: 21/08/2021
  //Função: Recebe a url e retorna uma lista de Pokémons
  static Future<PokeApi> getPokemons(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      PokeApi listPokemons = PokeApi.fromJson(jsonDecode(response.body));
      List<Pokemon> listPokemonsAux = [];
      for (Pokemon pokemon in listPokemons.results!) {
        listPokemonsAux.add(await getSpecificPokemon(pokemon.name!));
      }
      listPokemons.results = listPokemonsAux;
      return listPokemons;
    } catch (e) {
      return PokeApi();
    }
  }

  //Autor do comentário: Tiago Elias
  //Data do comentário: 21/08/2021
  //Função: Recebe o nome de um Pokémon e retorna suas informações
  static Future<Pokemon> getSpecificPokemon(String name) async {
    try {
      String url = urlApi + "/$name";
      var response = await http.get(Uri.parse(url));
      Pokemon pokemon = Pokemon.fromJson(jsonDecode(response.body));
      return pokemon;
    } catch (e) {
      return Pokemon();
    }
  }
}
