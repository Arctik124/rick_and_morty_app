import 'package:bloc/bloc.dart';
import 'package:rick_and_morty_app/data/repositories/character_repository.dart';
import 'package:meta/meta.dart';

import '../../data/models/character.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharacterRepository characterRepository = CharacterRepository();

  int page = 0;
  int maxPages = 1;

  CharactersBloc() : super(CharactersInitial()) {
    initMaxPages();
    on<CharacterPageRequest>((event, emit) async {
      if (state is CharactersLoading) return;
      if (page >= maxPages) return;

      var oldChars = <Character>[];

      if (state is CharactersLoaded) {
        oldChars = (state as CharactersLoaded).chars;
      }
      page++;
      emit(CharactersLoading(oldChars, page));

      try {
        var newChars = await characterRepository.getCharacters(page);
        oldChars.addAll(newChars);
        emit(CharactersLoaded(
            lastLoadedPage: page,
            chars: oldChars,
            isLastPage: page >= maxPages));
      } catch (e) {
        emit(CharactersError(e.toString()));
      }
    });
  }

  void initMaxPages() async {
    maxPages = await characterRepository.getMaxPages();
    // maxPages = 3;
  }
}
