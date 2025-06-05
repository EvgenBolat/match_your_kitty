import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:match_your_kitty/application/cat/cat_bloc.dart';
import 'package:match_your_kitty/application/cat/cat_event.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_bloc.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_event.dart';
import 'package:match_your_kitty/application/network/network_cubit.dart';
import 'package:match_your_kitty/data/database/app_database.dart';
import 'package:match_your_kitty/data/services/cat_api_client.dart';
import 'package:match_your_kitty/domain/models/cat.dart';
import 'package:match_your_kitty/domain/repositories/liked_cat_repository.dart';
import 'package:match_your_kitty/domain/repositories/liked_cat_repository_impl.dart';
import 'package:match_your_kitty/presentation/screens/cat_details_screen.dart';
import 'package:match_your_kitty/presentation/screens/home_screen.dart';
import 'package:match_your_kitty/presentation/screens/liked_cat_screen.dart';

import 'domain/repositories/cat_repository.dart';

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
  getIt.registerSingleton<NetworkCubit>(NetworkCubit(Connectivity()));
  getIt.registerSingleton<CatApiClient>(CatApiClient(getIt<Dio>()));
  getIt.registerSingleton<CatRepository>(CatRepository(getIt<CatApiClient>()));
  getIt.registerFactory<CatBloc>(() => CatBloc(getIt<CatRepository>()));
  getIt.registerFactory<LikedCatBloc>(
    () => LikedCatBloc(getIt<ILikedCatsRepository>()),
  );
  getIt.registerSingleton<AppDatabase>(AppDatabase());
  getIt.registerSingleton<ILikedCatsRepository>(
    LikedCatsRepositoryImpl(getIt<AppDatabase>()),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CatBloc>()..add(LoadCat())),
        BlocProvider(
          create: (_) => getIt<LikedCatBloc>()..add(LoadLikedCats()),
        ),
        BlocProvider(create: (_) => getIt<NetworkCubit>()),
      ],
      child: MaterialApp(
        title: 'Match Your Kitty',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFF4E1C1),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFD2B48C),
            elevation: 0,
          ),
        ),
        builder: (context, child) {
          return BlocListener<NetworkCubit, NetworkStatus>(
            listener: (context, state) {
              final messenger = ScaffoldMessenger.of(context);
              if (state == NetworkStatus.offline) {
                messenger.showSnackBar(
                  const SnackBar(content: Text('Нет подключения к интернету')),
                );
              } else {
                messenger.showSnackBar(
                  const SnackBar(content: Text('Подключение восстановлено')),
                );
              }
            },
            child: child!,
          );
        },
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          } else if (settings.name == CatDetailsScreen.routeName) {
            final cat = settings.arguments as Cat;
            return MaterialPageRoute(
              builder: (context) => CatDetailsScreen(cat: cat),
            );
          } else if (settings.name == LikedCatsScreen.routeName) {
            return MaterialPageRoute(builder: (context) => LikedCatsScreen());
          }
          return null;
        },
      ),
    );
  }
}
