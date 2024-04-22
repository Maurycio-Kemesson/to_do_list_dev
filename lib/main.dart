import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_dev/src/cubits/board_cubit.dart';
import 'package:to_do_list_dev/src/pages/board_page.dart';
import 'package:to_do_list_dev/src/repositories/board_repository.dart';
import 'package:to_do_list_dev/src/repositories/isar/isar_board_repository.dart';
import 'package:to_do_list_dev/src/repositories/isar/isar_datasource.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(create: (ctx) => IsarDatasource()),
        RepositoryProvider<BoardRepository>(
            create: (ctx) => IsarBoardRepository(ctx.read())),
        BlocProvider(create: (ctx) => BoardCubit(ctx.read()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
                color: Colors.white, fontFamily: 'LTWave', fontSize: 22),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black,
          ),
          useMaterial3: true,
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff011c26),
            iconTheme: IconThemeData(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.white),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
                color: Colors.white, fontFamily: 'LTWave', fontSize: 22),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xff011c26),
          ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.light,
        home: const BoardPage(),
      ),
    );
  }
}
