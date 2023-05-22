import '../../core/shared/domain/usecases/async_usecase.dart';
import 'data/datasources/home_datasource.dart';
import 'data/datasources/local/home_local_datasource_decorator_impl.dart';
import 'data/datasources/remote/home_remote_datasource_impl.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'presenter/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'domain/usecases/fetch_pictures_usecase.dart';
import 'presenter/controllers/home_controller.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<HomeDatasource>(
      (i) => HomeLocalDatasourceDecoratorImpl(
        homeDatasource: HomeRemoteDatasourceImpl(restClient: i()),
      ),
    ),
    Bind.lazySingleton<HomeRepository>(
      (i) => HomeRepositoryImpl(datasource: i()),
    ),
    Bind.lazySingleton<AsyncUsecase>(
      (i) => FetchPicturesUsecase(repository: i()),
    ),
    BlocBind.lazySingleton((i) => HomeController(usecase: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const HomePage()),
  ];
}
