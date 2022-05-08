import 'package:rick_and_morty_app/presentation/routers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/bloc/characters_bloc.dart';

void main() {
  final appRouter = AppRouter();
  runApp(MyApp(
    appRouter: appRouter,
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(),
      child: MaterialApp(
        title: 'Rick and Morty demo app',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
