

import 'package:equatable/equatable.dart';


abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final Set<String> favorites;
  FavoriteLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}
