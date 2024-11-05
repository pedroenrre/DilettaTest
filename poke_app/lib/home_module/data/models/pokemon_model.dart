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
    List<String> types = (json['types'] as List<dynamic>)
        .map((typeInfo) =>
            typeInfo is String ? typeInfo : typeInfo['type']['name'] as String)
        .toList();
    return PokemonModel(
      name: json['name'] as String,
      url: json['url'] as String? ?? json['sprites']['front_default'] as String,
      id: json['id'] as num,
      types: types,
    );
  }

  PokemonListItemEntity toEntity() {
    return PokemonListItemEntity(
      id: id,
      name: name,
      url: url,
      types: types,
    );
  }

  factory PokemonModel.fromEntity(PokemonListItemEntity entity) {
    return PokemonModel(
      name: entity.name,
      url: entity.url,
      id: entity.id,
      types: entity.types,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'url': url,
      'types': types,
    };
  }
}
