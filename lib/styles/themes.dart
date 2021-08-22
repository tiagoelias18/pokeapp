import 'package:flutter/material.dart';

final pokeTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    primaryColor: Color(0xFF4527a0),
  );
}
