import 'package:flutter/material.dart';
import 'package:poke_app/core/constants/app_colors.dart';
import 'package:poke_app/core/extentions/text_extention.dart';
import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';
import 'package:poke_app/home_module/presenters/list_page/components/type_tag.dart';

class PokemonCard extends StatelessWidget {
  final PokemonListItemEntity pokemon;
  final Function() onFavoritePressed;
  final bool favoriteDisabled;
  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.onFavoritePressed,
    this.favoriteDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.getColorByType(pokemon.types.first),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                    pokemon.url,
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pokemon.name).cardTitle(
                        // color: AppColors.getColorByType(
                        //   pokemon.type,
                        // ),
                        ),
                    const SizedBox(height: 4),
                    Row(
                      children: pokemon.types.map((type) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 4.0), // Espaçamento entre as tags
                          child: TypeTag(
                            type: type,
                            color: AppColors.getColorByType(type),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                pokemon.favorite ? Icons.favorite : Icons.favorite_border,
                color: pokemon.favorite ? AppColors.favorite : Colors.grey,
              ),
              onPressed: favoriteDisabled ? null : onFavoritePressed,
            ),
          ],
        ),
      ),
    );
  }
}
