import 'package:pokeapp/models/type_pokemon.dart';

class Pokemon {
  late String? name;
  late String? url;
  late int? id;
  late int? height;
  late int? weight;
  late int? baseExperience;
  late String? frontDefault;
  late List<TypePokemon>? types;

  Pokemon(
      {this.name,
      this.url,
      this.id,
      this.height,
      this.weight,
      this.baseExperience,
      this.frontDefault,
      this.types});

  Pokemon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = "https://pokeapi.co/api/v2/pokemon/$name";
    id = json['id'];
    height = json['height'];
    weight = json['weight'];
    baseExperience = json['base_experience'];
    frontDefault =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
    if (json['types'] != null) {
      types = [];
      json['types'].forEach((v) {
        types!.add(TypePokemon.fromJson(v));
      });
    } else {
      types = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['id'] = this.id;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['base_experience'] = this.baseExperience;
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
