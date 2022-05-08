import 'dart:convert';

import 'package:http/http.dart' as http;

class CharacterAPI {
  final baseUrl = 'https://rickandmortyapi.com/api';

  Future<List> getRawCharacters(int page) async {
    final response =
        await http.get(Uri.parse(baseUrl + '/character?page=$page'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseMap = (jsonDecode(response.body) as Map);

      final rawCharacters = responseMap['results'] as List;

      return rawCharacters;
    } else {
      String errMessage = '';
      final responseMap = (jsonDecode(response.body) as Map);
      if (responseMap.containsKey('error')) {
        errMessage = responseMap['error'];
      } else {
        errMessage = response.body;
      }
      throw Exception(errMessage);
    }
  }

  Future<int> getMaxPages() async {
    final response = await http.get(Uri.parse(baseUrl + '/character?page=1'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseMap = (jsonDecode(response.body) as Map);

      final rawInfo = responseMap['info'] as Map;

      return rawInfo['pages'];
    } else {
      String errMessage = '';
      final responseMap = (jsonDecode(response.body) as Map);
      if (responseMap.containsKey('error')) {
        errMessage = responseMap['error'];
      } else {
        errMessage = response.body;
      }
      throw Exception(errMessage);
    }
  }
}
