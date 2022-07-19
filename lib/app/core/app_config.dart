import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'helpers/environments.dart';

class AppConfig {
  const AppConfig();

  Future<void> configureApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _setScreenOrientationToPortrait();
    await _loadEnvs();
  }

  Future<void> _loadEnvs() async => await Environments.loadEnvs();

  Future<void> _setScreenOrientationToPortrait() async =>
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
}
