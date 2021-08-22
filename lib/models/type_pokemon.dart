import 'link_model.dart';

class TypePokemon {
  late int ?slot;
  late LinkModel ?type;

  TypePokemon({this.slot, this.type});

  TypePokemon.fromJson(Map<String, dynamic> json) {
    slot   = json['slot'];
    type = json['type'] != null ? LinkModel.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot']   = this.slot;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

