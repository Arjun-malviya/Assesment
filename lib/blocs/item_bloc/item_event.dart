
import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadItemsEvent extends ItemEvent {}

class SearchItemsEvent extends ItemEvent {
  final String query;
  SearchItemsEvent(this.query);

  @override
  List<Object?> get props => [query];
}
