
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearl_talent_test/blocs/favorite_bloc/favorite_event.dart';
import 'package:pearl_talent_test/blocs/favorite_bloc/favorite_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<LoadFavoritesEvent>(_onLoad);
    on<ToggleFavoriteEvent>(_onToggle);
  }

  void _onLoad(LoadFavoritesEvent event, Emitter<FavoriteState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favorites') ?? [];
    emit(FavoriteLoaded(favs.toSet()));
  }

  void _onToggle(ToggleFavoriteEvent event, Emitter<FavoriteState> emit) async {
    if (state is! FavoriteLoaded) return;

    final prefs = await SharedPreferences.getInstance();
    final current = Set<String>.from((state as FavoriteLoaded).favorites);

    if (current.contains(event.id)) {
      current.remove(event.id);
    } else {
      current.add(event.id);
    }

    await prefs.setStringList('favorites', current.toList());
    emit(FavoriteLoaded(current));
  }
}
