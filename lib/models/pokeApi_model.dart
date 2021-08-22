import 'package:pokeapp/models/pokemon_model.dart';

class PokeApi {
  late int? count;
  late String? next;
  late String? previous;
  late List<Pokemon>? results;

  PokeApi({this.count, this.next, this.previous, this.results});

  PokeApi.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(Pokemon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['results'] = this.results!.map((v) => v.toJson()).toList();
    return data;
  }
}
