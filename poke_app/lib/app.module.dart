import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/home_module/home.module.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module('/', module: HomeModule());
  }
}
