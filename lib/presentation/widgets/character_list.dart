import 'package:rick_and_morty_app/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/character.dart';
import '../../logic/bloc/characters_bloc.dart';

class CharacterList extends StatelessWidget {
  CharacterList({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  bool get _isBottom {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      return currentScroll == maxScroll;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharactersBloc, CharactersState>(
      listener: (context, state) {
        if (state is CharactersError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errMessage),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      builder: (context, state) {
        _scrollController.addListener(() {
          if (_isBottom) {
            BlocProvider.of<CharactersBloc>(context)
                .add(CharacterPageRequest());
          }
        });

        if (state is CharactersLoading && state.pageToLoad == 1) {
          return _loadingWidget();
        }

        List<Character> chars = [];
        Widget? lastWidget;

        if (state is CharactersLoading) {
          chars = state.oldChars;
          lastWidget = _loadingWidget();
        } else if (state is CharactersLoaded) {
          chars = state.chars;
          if (state.isLastPage) {
            lastWidget = _lastPageWidget();
          }
        }

        if (chars.isEmpty) {
          return Container();
        }
        return GridView.builder(
          itemBuilder: (context, index) {
            if (index < chars.length) {
              return CharacterItem(
                char: chars[index],
              );
            } else {
              return lastWidget ?? Container();
            }
          },
          itemCount: chars.length + (lastWidget != null ? 1 : 0),
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 4 / 5,
          ),
        );
      },
    );
  }

  Widget _loadingWidget() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget _lastPageWidget() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: Text('The end!')),
    );
  }
}
