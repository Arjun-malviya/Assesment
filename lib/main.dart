
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearl_talent_test/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:pearl_talent_test/blocs/item_bloc/item_bloc.dart';
import 'package:pearl_talent_test/blocs/item_bloc/item_event.dart';
import 'blocs/favorite_bloc/favorite_event.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemBloc>(create: (_) => ItemBloc()..add(LoadItemsEvent())),
        BlocProvider<FavoriteBloc>(create: (_) => FavoriteBloc()..add(LoadFavoritesEvent())),
      ],
      child: MaterialApp(
        title: 'Item List App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const HomePage(),
      ),
    );
  }
}