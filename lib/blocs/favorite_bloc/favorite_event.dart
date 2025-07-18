

import 'package:equatable/equatable.dart';


abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent extends FavoriteEvent {}

class ToggleFavoriteEvent extends FavoriteEvent {
  final String id;
  ToggleFavoriteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
