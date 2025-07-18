import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearl_talent_test/blocs/item_bloc/item_event.dart';
import 'package:pearl_talent_test/blocs/item_bloc/item_state.dart';
import 'package:pearl_talent_test/models/item_model.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemLoading()) {
    on<LoadItemsEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      final now = DateTime.now();
      final items = [
        Item(
          id: '1',
          title: 'Buy groceries',
          createdAt: now.subtract(Duration(minutes: 5)),
          tag: 'New',
        ),
        Item(
          id: '2',
          title: 'Read a book',
          createdAt: now.subtract(Duration(hours: 1)),
          tag: 'Old',
        ),
        Item(
          id: '3',
          title: 'Morning workout',
          createdAt: now.subtract(Duration(minutes: 20)),
          tag: 'Hot',
        ),
        Item(
          id: '4',
          title: 'Call Mom',
          createdAt: now.subtract(Duration(hours: 3)),
          tag: 'Old',
        ),
        Item(
          id: '5',
          title: 'Finish project',
          createdAt: now.subtract(Duration(minutes: 15)),
          tag: 'New',
        ),
      ];
      emit(ItemLoaded(items: items));
    });

    on<SearchItemsEvent>((event, emit) {
      if (state is ItemLoaded) {
        final items = (state as ItemLoaded).items;
        final filtered =
            items
                .where(
                  (item) => item.title.toLowerCase().contains(
                    event.query.toLowerCase(),
                  ),
                )
                .toList();
        emit(ItemLoaded(items: items, filteredItems: filtered));
      }
    });
  }
}
