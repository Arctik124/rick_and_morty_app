import 'package:rick_and_morty_app/data/data_providers/character_api.dart';

import '../models/character.dart';

class CharacterRepository {
  final CharacterAPI _characterAPI = CharacterAPI();

  Future<List<Character>> getCharacters(int page) async {
    var rawChars = await _characterAPI.getRawCharacters(page);

    return rawChars.map<Character>((char) => Character.fromMap(char)).toList();
  }

  Future<int> getMaxPages() async {
    var maxPages = await _characterAPI.getMaxPages();

    return maxPages;
  }
}
