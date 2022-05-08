import 'package:rick_and_morty_app/logic/bloc/characters_bloc.dart';
import 'package:rick_and_morty_app/presentation/widgets/character_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaracterListScreen extends StatelessWidget {
  const CaracterListScreen({Key? key}) : super(key: key);

  static const String routeName = '/characters';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersBloc>(context).add(CharacterPageRequest());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Character list'),
      ),
      body: CharacterList(),
    );
  }
}


          // ElevatedButton(
          //   child: Text('Fetch'),
          //   onPressed: () {
          //     BlocProvider.of<CharactersBloc>(context)
          //         .add(CharacterPageRequest());
          //   },
          // ),