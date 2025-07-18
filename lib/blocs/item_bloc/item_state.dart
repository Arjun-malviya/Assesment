
import 'package:equatable/equatable.dart';
import 'package:pearl_talent_test/models/item_model.dart';

abstract class ItemState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Item> items;
  final List<Item>? filteredItems;

  ItemLoaded({required this.items, this.filteredItems});

  @override
  List<Object?> get props => [items, filteredItems ?? []];
}
