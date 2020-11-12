import 'dart:io';

import 'package:enciclopiedia_deportiva/common/constants/colors.dart';
import 'package:enciclopiedia_deportiva/common/constants/general.dart';
import 'package:enciclopiedia_deportiva/repository/category_call_api.dart';
import 'package:enciclopiedia_deportiva/repository/category_repository.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'app.dart';
import 'bloc/category_bloc.dart';
import 'bloc/category_sub_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpClient.enableTimelineLogging = true;
  foundation.LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
    yield foundation.LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  if (!isWeb) {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: darkBG,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: darkBG),
    );
  }
  final CategoryRepository repository = CategoryRepository(
    categoryApi: CategoryApi(
      httpClient: http.Client(),
    ),
  );

  Bloc.observer = SimpleBlocObserver();
  GlobalKey _key = GlobalKey();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(
            repository: repository,
          ),
        ),
        BlocProvider(
          create: (context) => CategorySubBloc(
            repository: repository,
          ),
        ),
      ],
      child: MyApp(
        repository: repository,
        key: _key,
      ),
    ),
  );
}

class SimpleBlocObserver implements BlocObserver {
  @override
  void onChange(Stream<dynamic> stream, Change change) {}

  @override
  void onError(Stream<dynamic> stream, Object error, StackTrace stackTrace) {}

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object event) {}

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {}

  @override
  void onClose(Cubit cubit) {}

  @override
  void onCreate(Cubit cubit) {}
}
