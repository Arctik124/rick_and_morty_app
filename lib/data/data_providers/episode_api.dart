import 'dart:convert';

import 'package:http/http.dart' as http;

class EpisodeAPI {
  final baseUrl = 'https://rickandmortyapi.com/api';

  Future<List> getRawEpisodes(List<String> episodesList) async {
    episodesList =
        episodesList.map((episodeLink) => episodeLink.split('/').last).toList();
    String ids = episodesList.join(',');
    final response = await http.get(Uri.parse(baseUrl + '/episode/$ids'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (episodesList.length == 1) {
        final responseMap = (jsonDecode(response.body) as Map);
        return [responseMap];
      }

      final responseList = (jsonDecode(response.body) as List);
      return responseList;
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
