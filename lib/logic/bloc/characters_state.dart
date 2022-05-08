part of 'characters_bloc.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {
  final List<Character> oldChars;
  final int pageToLoad;

  CharactersLoading(this.oldChars, this.pageToLoad);
}

class CharactersLoaded extends CharactersState {
  final List<Character> chars;
  final int lastLoadedPage;
  final bool isLastPage;

  CharactersLoaded({
    required this.chars,
    required this.lastLoadedPage,
    required this.isLastPage,
  });
}

class CharactersError extends CharactersState {
  final String errMessage;

  CharactersError(this.errMessage);
}
