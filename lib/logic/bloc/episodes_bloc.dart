import 'package:bloc/bloc.dart';
import 'package:rick_and_morty_app/data/models/episode.dart';
import 'package:rick_and_morty_app/data/repositories/episode_repository.dart';
import 'package:meta/meta.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final EpisodeRepository _episodeRepository = EpisodeRepository();

  EpisodesBloc() : super(EpisodesInitial()) {
    on<EpisodeRequest>((event, emit) async {
      emit(EpisodesLoading());
      try {
        final episodes =
            await _episodeRepository.getEpisodes(event.episodesLinks);
        emit(EpisodesLoaded(episodes: episodes));
      } catch (err) {
        emit(EpisodesError(err.toString()));
      }
    });
  }
}
