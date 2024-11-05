import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF2F5FF);
  static const Color darkBlue = Color(0xFF001F5A);
  static const Color favorite = Color(0xFFC40000);
  static const Color darkGreyFont = Color(0xFF515151);
  static const Color darkBlueFont = Color(0xFF2E3A59);

  static const Color normal = Color(0xFFA8A77A);
  static const Color fire = Color(0xFFEE8130);
  static const Color water = Color(0xFF6390F0);
  static const Color electric = Color(0xFFF7D02C);
  static const Color grass = Color(0xFF7AC74C);
  static const Color ice = Color(0xFF96D9D6);
  static const Color fighting = Color(0xFFC22E28);
  static const Color poison = Color(0xFFA33EA1);
  static const Color ground = Color(0xFFE2BF65);
  static const Color flying = Color(0xFFA98FF3);
  static const Color psychic = Color(0xFFF95587);
  static const Color bug = Color(0xFFA6B91A);
  static const Color rock = Color(0xFFB6A136);
  static const Color ghost = Color(0xFF735797);
  static const Color dragon = Color(0xFF6F35FC);
  static const Color dark = Color(0xFF705746);
  static const Color steel = Color(0xFFB7B7CE);
  static const Color fairy = Color(0xFFD685AD);

  static Color getColorByType(String type) {
    final typeColorMap = {
      'normal': normal,
      'fire': fire,
      'water': water,
      'electric': electric,
      'grass': grass,
      'ice': ice,
      'fighting': fighting,
      'poison': poison,
      'ground': ground,
      'flying': flying,
      'psychic': psychic,
      'bug': bug,
      'rock': rock,
      'ghost': ghost,
      'dragon': dragon,
      'dark': dark,
      'steel': steel,
      'fairy': fairy,
    };

    return typeColorMap[type.toLowerCase()] ?? background;
  }
}
