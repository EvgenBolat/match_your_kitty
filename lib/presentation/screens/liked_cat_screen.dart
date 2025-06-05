import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_bloc.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_event.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_state.dart';

class LikedCatsScreen extends StatelessWidget {
  static const routeName = '/liked-cats';

  const LikedCatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedCatBloc, LikedCatsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Liked Cats'),
            actions: [
              DropdownButton<String>(
                value: state.selectedBreedFilter,
                hint: Text('Filter by breed'),
                items: [
                  DropdownMenuItem(value: 'all', child: Text('All')),
                  ...state.likedCats
                      .map((e) => e.breedName)
                      .toSet()
                      .map(
                        (breed) =>
                            DropdownMenuItem(value: breed, child: Text(breed)),
                      ),
                ],
                onChanged: (value) {
                  context.read<LikedCatBloc>().add(SetBreedFilter(value));
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              if (state.filteredCats.isEmpty)
                Center(child: Text('No liked cats'))
              else
                ListView.builder(
                  itemCount: state.filteredCats.length,
                  itemBuilder: (context, index) {
                    final cat = state.filteredCats[index];
                    return Card(
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: cat.imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => const SizedBox(
                                width: 80,
                                height: 80,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                        ),
                        title: Text(cat.breedName),
                        subtitle: Text(
                          'Liked at: ${DateFormat('dd.MM.yyyy HH:mm').format(cat.likedAt)}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed:
                              () => context.read<LikedCatBloc>().add(
                                RemoveLikedCat(cat.id),
                              ),
                        ),
                      ),
                    );
                  },
                ),
              if (state.isLoading) Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}
