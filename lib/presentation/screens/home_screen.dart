import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_your_kitty/application/cat/cat_bloc.dart';
import 'package:match_your_kitty/application/cat/cat_event.dart';
import 'package:match_your_kitty/application/cat/cat_state.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_bloc.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_event.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_state.dart';
import 'package:match_your_kitty/data/models/liked_cat.dart';
import 'package:match_your_kitty/presentation/screens/liked_cat_screen.dart';

import '../widgets/cat_card_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isTakingLong = false;

  @override
  void initState() {
    super.initState();
    context.read<CatBloc>().add(LoadInitialCats());

    Future.delayed(Duration(seconds: 5), () {
      if (mounted && (context.read<CatBloc>().state is CatLoading)) {
        setState(() {
          _isTakingLong = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatBloc, CatState>(
      listener: (outerContext, state) {
        if (state is! CatLoading) {
          _isTakingLong = false;
        }
        if (state is CatLoaded &&
            state.catList.isEmpty &&
            state.errorMessage != null) {
          showDialog(
            context: outerContext,
            builder:
                (context) => AlertDialog(
                  title: const Text('Ошибка'),
                  content: Text(state.errorMessage!),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Закрыть'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        outerContext.read<CatBloc>().add(LoadInitialCats());
                      },
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: BlocBuilder<LikedCatBloc, LikedCatsState>(
              builder: (context, state) {
                int likeCount = state.likedCats.length;
                return Text(
                  '❤️ Liked $likeCount cat${likeCount != 1 ? 's' : ''}',
                );
              },
            ),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),

          floatingActionButton: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, LikedCatsScreen.routeName);
            },
            child: const Text('View liked cats'),
          ),
          body: Builder(
            builder: (context) {
              if (state is CatLoading || state is CatInitial) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      if (_isTakingLong)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Пожалуйста, подождите немного дольше...',
                          ),
                        ),
                    ],
                  ),
                );
              } else if (state is CatLoaded) {
                if (state.catList.isEmpty && state.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Нет данных'),
                        TextButton(
                          onPressed: () {
                            context.read<CatBloc>().add(LoadInitialCats());
                          },
                          child: Text('Повторить'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CatCardList(
                      catList: state.catList,
                      onLike: (cat) {
                        context.read<LikedCatBloc>().add(
                          AddLikedCat(
                            LikedCat(
                              id: cat.id,
                              imageUrl: cat.url,
                              breedName:
                                  cat.breeds.isNotEmpty
                                      ? cat.breeds[0].name
                                      : 'Unknown',
                              likedAt: DateTime.now(),
                            ),
                          ),
                        );
                        context.read<CatBloc>().add(LikeCat());
                      },
                      onNext: () => context.read<CatBloc>().add(NextCat()),
                      onCardTapped: (cat) {
                        Navigator.pushNamed(
                          context,
                          '/cat-details',
                          arguments: cat,
                        );
                      },
                    ),
                  );
                }
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Произошла непредвиденная ошибка'),
                    TextButton(
                      onPressed: () {
                        context.read<CatBloc>().add(LoadInitialCats());
                      },
                      child: Text('Повторить'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
