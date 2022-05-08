import 'package:rick_and_morty_app/logic/bloc/episodes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/character.dart';
import '../../data/models/episode.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({Key? key, required this.char})
      : super(key: key);

  static const routeName = '/character/details';

  final Character char;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EpisodesBloc>(context).add(EpisodeRequest(char.episode));

    final mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      // appBar: AppBar(title: Text(char.name)),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _generateSliverAppBar(mediaQueryData),
            _generateInfo(),
            _generateEpisodeList()
          ],
        ),
      ),
    );
  }

  SliverList _generateInfo() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _generateTitle('Info'),
          Card(
            child: ListTile(
              trailing: Text(
                char.status,
                style: TextStyle(color: char.getStatusColor()),
              ),
              title: Text(char.name),
              subtitle: Text('Species: ${char.species}'),
              leading: CircleAvatar(child: char.getGenderIcon()),
            ),
          )
        ],
      ),
    );
  }

  Widget _generateEpisodeList() {
    return BlocConsumer<EpisodesBloc, EpisodesState>(
      listener: ((context, state) {
        if (state is EpisodesError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errMessage),
            duration: const Duration(seconds: 1),
          ));
        }
      }),
      builder: (context, state) {
        if (state is EpisodesLoaded) {
          final episodes = state.episodes;

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => index == 0
                  ? _generateTitle('Episodes')
                  : _generateEpisodeTile(episodes[index - 1]),
              childCount: episodes.length + 1,
            ),
          );
        }

        if (state is EpisodesLoading) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              ],
            ),
          );
        }

        return SliverList(
          delegate: SliverChildListDelegate(
            [],
          ),
        );
      },
    );
  }

  Widget _generateEpisodeTile(Episode episode) {
    return Card(
      child: ListTile(
        title: Text(episode.name),
        subtitle: Text('Air Date: ${episode.airDate}'),
        trailing: Text(episode.episode),
      ),
    );
  }

  SliverAppBar _generateSliverAppBar(MediaQueryData mediaQueryData) {
    return SliverAppBar(
      expandedHeight: mediaQueryData.size.width,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(char.name, textScaleFactor: 1),
        stretchModes: const [StretchMode.blurBackground],
        background: Image.network(
          char.image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _generateTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
