import 'package:rick_and_morty_app/presentation/screens/character_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/character.dart';
import '../../logic/bloc/episodes_bloc.dart';
import '../screens/character_list_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CaracterListScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const CaracterListScreen(),
        );

      case CharacterDetailsScreen.routeName:
        Character char = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EpisodesBloc(),
            child: CharacterDetailsScreen(
              char: char,
            ),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const CaracterListScreen(),
        );
    }
  }
}
