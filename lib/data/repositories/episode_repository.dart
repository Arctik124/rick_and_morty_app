import '../data_providers/episode_api.dart';
import '../models/episode.dart';

class EpisodeRepository {
  final EpisodeAPI _episodeAPI = EpisodeAPI();

  Future<List<Episode>> getEpisodes(List<String> episodesList) async {
    var rawEpisodes = await _episodeAPI.getRawEpisodes(episodesList);
    return rawEpisodes
        .map<Episode>((episode) => Episode.fromMap(episode))
        .toList();
  }
}
