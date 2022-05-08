part of 'episodes_bloc.dart';

@immutable
abstract class EpisodesState {}

class EpisodesInitial extends EpisodesState {}

class EpisodesLoading extends EpisodesState {}

class EpisodesLoaded extends EpisodesState {
  final List<Episode> episodes;

  EpisodesLoaded({
    required this.episodes,
  });
}

class EpisodesError extends EpisodesState {
  final String errMessage;

  EpisodesError(this.errMessage);
}
