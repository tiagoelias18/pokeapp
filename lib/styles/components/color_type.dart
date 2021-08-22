import 'package:flutter/material.dart';
import 'package:pokeapp/models/pokemon_model.dart';
import 'package:pokeapp/styles/colors.dart' as Col;

Color colorByType(String mainType) {
  try {
    if (mainType.toLowerCase() == "bug") {
      return Col.typeBug;
    } else if (mainType.toLowerCase() == "dark") {
      return Col.typeDark;
    } else if (mainType.toLowerCase() == "dragon") {
      return Col.typeDragon;
    } else if (mainType.toLowerCase() == "electric") {
      return Col.typeElectric;
    } else if (mainType.toLowerCase() == "fairy") {
      return Col.typeFairy;
    } else if (mainType.toLowerCase() == "fighting") {
      return Col.typeFighting;
    } else if (mainType.toLowerCase() == "fire") {
      return Col.typeFire;
    } else if (mainType.toLowerCase() == "flying") {
      return Col.typeFlying;
    } else if (mainType.toLowerCase() == "ghost") {
      return Col.typeGhost;
    } else if (mainType.toLowerCase() == "grass") {
      return Col.typeGrass;
    } else if (mainType.toLowerCase() == "ground") {
      return Col.typeGround;
    } else if (mainType.toLowerCase() == "ice") {
      return Col.typeIce;
    } else if (mainType.toLowerCase() == "normal") {
      return Col.typeNormal;
    } else if (mainType.toLowerCase() == "poison") {
      return Col.typePoison;
    } else if (mainType.toLowerCase() == "psychic") {
      return Col.typePsychic;
    } else if (mainType.toLowerCase() == "rock") {
      return Col.typeRock;
    } else if (mainType.toLowerCase() == "steel") {
      return Col.typeSteel;
    } else if (mainType.toLowerCase() == "water") {
      return Col.typeWater;
    } else {
      return Colors.white;
    }
  } catch (e) {
    return Colors.white;
  }
}
