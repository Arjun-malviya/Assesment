import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearl_talent_test/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:pearl_talent_test/blocs/favorite_bloc/favorite_event.dart';
import 'package:pearl_talent_test/blocs/favorite_bloc/favorite_state.dart';
import 'package:pearl_talent_test/blocs/item_bloc/item_bloc.dart';
import 'package:pearl_talent_test/blocs/item_bloc/item_event.dart';
import 'package:pearl_talent_test/blocs/item_bloc/item_state.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemBloc = context.read<ItemBloc>();
    final favoriteBloc = context.read<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              final count = state is FavoriteLoaded ? state.favorites.length : 0;
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    const Icon(Icons.favorite),
                    if (count > 0)
                      Positioned(
                        top: 2,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          child: Text('$count', style: const TextStyle(fontSize: 10, color: Colors.white)),
                        ),
                      )
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Search', border: OutlineInputBorder()),
              onChanged: (value) => itemBloc.add(SearchItemsEvent(value)),
            ),
          ),
          Expanded(
            child: BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                if (state is ItemLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ItemLoaded) {
                  final items = state.filteredItems ?? state.items;

                  return BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, favState) {
                     final favorites = favState is FavoriteLoaded ? favState.favorites : <String>{};

                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isFav = favorites.contains(item.id);

                          return ListTile(
                            key: ValueKey(item.id),
                            title: Text(item.title),
                            subtitle: Text(timeago.format(item.createdAt)),
                            leading: CircleAvatar(
                              backgroundColor: _tagColor(item.tag),
                              child: Text(item.tag[0]),
                            ),
                            trailing: IconButton(
                              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : null),
                              onPressed: () => favoriteBloc.add(ToggleFavoriteEvent(item.id)),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _tagColor(String tag) {
    switch (tag) {
      case 'New':
        return Colors.green;
      case 'Old':
        return Colors.blueGrey;
      case 'Hot':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
