import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_your_kitty/presentation/bloc/liked_cat/liked_cat_bloc.dart';
import 'package:match_your_kitty/presentation/bloc/liked_cat/liked_cat_event.dart';
import 'package:match_your_kitty/presentation/bloc/liked_cat/liked_cat_state.dart';

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
                        leading: Image.network(
                          cat.imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return SizedBox(
                              width: 80,
                              height: 80,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              context.read<LikedCatBloc>().add(
                                SetError('Failed to load image'),
                              );
                            });
                            return Icon(Icons.error);
                          },
                        ),
                        title: Text(cat.breedName),
                        subtitle: Text('Liked at: ${cat.likedAt}'),
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
