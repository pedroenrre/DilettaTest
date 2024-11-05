import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/home_module/data/datasources/local/local_datasource.dart';
import 'package:poke_app/home_module/data/datasources/local/local_datasource_imp.dart';
import 'package:poke_app/home_module/domain/usercases/get_favorites_usercase.dart';
import 'package:poke_app/home_module/domain/usercases/get_favorites_usercase_imp.dart';
import 'package:poke_app/home_module/domain/usercases/set_favorites_usercase.dart';
import 'package:poke_app/home_module/domain/usercases/set_favorites_usercase_imp.dart';
import 'package:poke_app/home_module/presenters/favorites_page/favorites_controller.dart';
import 'package:poke_app/home_module/presenters/favorites_page/favorites_page.dart';
import 'package:poke_app/shared_module/shared.module.dart';
import 'package:poke_app/shared_module/http_client/http_client_adapter.dart';
import 'package:poke_app/home_module/data/datasources/remote/remote_datasource.dart';
import 'package:poke_app/home_module/data/datasources/remote/remote_datasource_imp.dart';
import 'package:poke_app/home_module/data/repositories/pokemon_repository_imp.dart';
import 'package:poke_app/home_module/domain/repositories/pokemon_repository.dart';
import 'package:poke_app/home_module/domain/usercases/get_pokemons_usercase.dart';
import 'package:poke_app/home_module/domain/usercases/get_pokemons_usercase_imp.dart';
import 'package:poke_app/home_module/presenters/list_page/pokemon_list_controller.dart';
import 'package:poke_app/home_module/presenters/list_page/pokemon_list_page.dart';
import 'package:poke_app/shared_module/stores/favorites_store.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        SharedModule(),
      ];

  @override
  void binds(Injector i) {
    //DATASOURCES
    i.add<IRemoteDataSource>(
      () => RemoteDataSource(
        httpCLient: i.get<IHttpClientAdapter>(),
      ),
    );

    i.add<ILocalDataSource>(
      () => LocalDatasource(),
    );

    //REPOSITORIES
    i.add<IPokemonRepository>(
      () => PokemonRespository(
        dataSource: i.get<IRemoteDataSource>(),
        localDataSource: i.get<ILocalDataSource>(),
      ),
    );

    //USECASES
    i.add<IGetPokemonsUsecase>(
      () => GetPokemonsUsecase(
        repository: i.get<IPokemonRepository>(),
      ),
    );

    i.add<ISetFavoritesUsercase>(
      () => SetFavoritesUsercase(
        repository: i.get<IPokemonRepository>(),
      ),
    );

    i.add<IGetFavoritesUsercase>(
      () => GetFavoritesUsercase(
        repository: i.get<IPokemonRepository>(),
      ),
    );

    //CONTROLLERS
    i.add<PokemonListController>(
      () => PokemonListController(
        favoritesStore: i.get<FavoritesStore>(),
        getInitialPokemonsUsecase: i.get<IGetPokemonsUsecase>(),
        setFavoritesUsercase: i.get<ISetFavoritesUsercase>(),
        getFavoritesUsercase: i.get<IGetFavoritesUsercase>(),
      ),
    );

    i.add<FavoritesController>(
      () => FavoritesController(
        favoritesStore: i.get<FavoritesStore>(),
        setFavoritesUsercase: i.get<ISetFavoritesUsercase>(),
        getFavoritesUsercase: i.get<IGetFavoritesUsercase>(),
      ),
    );
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const PokeListPage());
    r.child('/favorites', child: (context) => const FavoritesPage());
  }
}
