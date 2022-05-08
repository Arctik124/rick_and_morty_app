import 'package:rick_and_morty_app/presentation/screens/character_details_screen.dart';
import 'package:flutter/material.dart';

import '../../data/models/character.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({Key? key, required this.char}) : super(key: key);

  final Character char;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          CharacterDetailsScreen.routeName,
          arguments: char,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Image.network(char.image),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                dense: true,
                title: Text(
                  char.name,
                  maxLines: 2,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                trailing: CircleAvatar(child: char.getGenderIcon()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
