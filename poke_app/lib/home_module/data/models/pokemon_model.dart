import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';

class PokemonModel {
  num id;
  String name;
  String url;
  List<String> types;

  PokemonModel({
    required this.id,
    required this.name,
    required this.url,
    required this.types,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    List<String> types = (json['types'] as List)
        .map((typeInfo) => typeInfo['type']['name'] as String)
        .toList();
    return PokemonModel(
      name: json['name'] as String,
      url: json['sprites']['front_default'] as String,
      id: json['id'] as num,
      types: types,
    );
  }

  PokemonListItemEntity toEntity({bool? isFavorite}) {
    return PokemonListItemEntity(
      id: id,
      name: name,
      url: url,
      types: types,
      favorite: isFavorite ?? false,
    );
  }
}
