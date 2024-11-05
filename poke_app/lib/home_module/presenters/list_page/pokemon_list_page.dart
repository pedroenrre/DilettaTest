import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/home_module/presenters/list_page/components/modal_loading.dart';
import 'package:poke_app/home_module/presenters/list_page/components/pokemon_card.dart';
import 'package:poke_app/home_module/presenters/list_page/pokemon_list_controller.dart';
import 'package:poke_app/home_module/presenters/list_page/pokemon_list_state.dart';

class PokeListPage extends StatefulWidget {
  const PokeListPage({super.key});

  @override
  State<PokeListPage> createState() => _PokeListPageState();
}

class _PokeListPageState extends State<PokeListPage> {
  final controller = Modular.get<PokemonListController>();

  @override
  void initState() {
    super.initState();
    controller.fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poke App'),
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.listState,
        builder: (context, state, child) {
          if (state is PokemonListLoadingState) {
            return Stack(
              children: [
                ModalBarrier(
                  color: Colors.black.withOpacity(0.5),
                  dismissible: false,
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
          if (state is PokemonListLoadedState) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: state.pokemons.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final pokemon = state.pokemons[index];
                    if (index == state.pokemons.length - 1) {
                      return Column(
                        children: [
                          PokemonCard(
                              pokemon: pokemon,
                              onFavoritePressed: () {
                                controller.toggleFavorite(
                                    pokemon.id, pokemon.favorite);
                              }),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: controller.fetchPokemons,
                            child: const Text('Carregar mais'),
                          ),
                        ],
                      );
                    }
                    return PokemonCard(
                      pokemon: pokemon,
                      onFavoritePressed: () {
                        controller.toggleFavorite(pokemon.id, pokemon.favorite);
                      },
                    );
                  },
                ),
                ModalLoading(showModalLoading: state.loading),
                // ModalBarrier(
                //   color: Colors.black.withOpacity(0.5),
                //   dismissible: false,
                // ),
                // const Center(
                //   child: CircularProgressIndicator(),
                // ),
              ],
            );
          }
          if (state is PokemonListErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}
