part of 'episodes_bloc.dart';

@immutable
abstract class EpisodesEvent {}

class EpisodeRequest extends EpisodesEvent {
  final List<String> episodesLinks;

  EpisodeRequest(this.episodesLinks);
}
