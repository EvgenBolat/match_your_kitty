import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:match_your_kitty/data/services/cat_api_client.dart';
import 'package:match_your_kitty/domain/cat.dart';
import 'package:match_your_kitty/presentation/block/cat_bloc.dart';
import 'package:match_your_kitty/presentation/block/cat_event.dart';
import 'package:match_your_kitty/presentation/screens/cat_details_screen.dart';
import 'package:match_your_kitty/presentation/screens/home_screen.dart';

import 'domain/cat_repository.dart';

final getIt = GetIt.instance;

void setupDI() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.thecatapi.com/v1',
      headers: {
        'x-api-key':
            'live_rs2cYwd6t2U172ZVENYGbtNNF4GcNn5CI17YBNd7cG1L0lqlSmFQUwp3bsmZdMtI',
      },
    ),
  );
  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<CatApiClient>(CatApiClient(getIt<Dio>()));
  getIt.registerSingleton<CatRepository>(CatRepository(getIt<CatApiClient>()));
  getIt.registerFactory<CatBloc>(() => CatBloc(getIt<CatRepository>()));
}

void main() {
  setupDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match Your Kitty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF4E1C1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD2B48C),
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder:
                (context) => BlocProvider(
                  create: (_) => getIt<CatBloc>()..add(LoadCat()),
                  child: const HomeScreen(),
                ),
          );
        } else if (settings.name == CatDetailsScreen.routeName) {
          final cat = settings.arguments as Cat;
          return MaterialPageRoute(
            builder: (context) => CatDetailsScreen(cat: cat),
          );
        }
        return null;
      },
    );
  }
}
