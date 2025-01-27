import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'core/comman/app_user/app_user_cubit.dart';
import 'core/comman/helpers/bloc_observer.dart';
import 'core/utils/custom_error_screen.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {

  customErorrScreen();
  addDioInterceptors();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  Bloc.observer = MyBlocObserver();

  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void addDioInterceptors() {
  Dio dio = serviceLocator<Dio>();
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
      filter: (options, args) {
        // don't print requests with uris containing '/posts'
        if (options.path.contains('/posts')) {
          return false;
        }
        // don't print responses with unit8 list data
        return !args.isResponse || !args.hasUint8ListData;
      }));

  dio.interceptors.add(RetryInterceptor(
    dio: dio,
    logPrint: print, // specify log function (optional)
    retries: 3, // retry count (optional)
    retryDelays: const [
      // set delays between retries (optional)
      Duration(seconds: 1), // wait 1 sec before first retry
      Duration(seconds: 2), // wait 2 sec before second retry
      Duration(seconds: 3), // wait 3 sec before third retry
    ],
  ));
}
