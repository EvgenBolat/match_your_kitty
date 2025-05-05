import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_your_kitty/presentation/block/cat_bloc.dart';
import 'package:match_your_kitty/presentation/block/cat_event.dart';
import 'package:match_your_kitty/presentation/block/cat_state.dart';

import '../widgets/cat_card_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CatBloc>().add(LoadInitialCats());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatBloc, CatState>(
      listener: (outerContext, state) {
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
        int likeCount = 0;
        if (state is CatLoaded) {
          likeCount = state.likeCount;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('❤️ Liked $likeCount cat'),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          body: Builder(
            builder: (context) {
              if (state is CatLoading || state is CatInitial) {
                return Center(child: CircularProgressIndicator());
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
                      onLike: () => context.read<CatBloc>().add(LikeCat()),
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
