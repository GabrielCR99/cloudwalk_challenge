import 'package:flutter_modular/flutter_modular.dart';

import 'core/shared/data/rest_client/dio/dio_rest_client.dart';
import 'core/shared/data/rest_client/rest_client.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<RestClient>((_) => DioRestClient()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
