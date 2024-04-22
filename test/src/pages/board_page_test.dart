import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_dev/src/cubits/board_cubit.dart';
import 'package:to_do_list_dev/src/pages/board_page.dart';
import 'package:to_do_list_dev/src/repositories/board_repository.dart';

class BoardRepositoryMock extends Mock implements BoardRepository {}

void main() {
  late BoardRepository repository = BoardRepositoryMock();
  late BoardCubit cubit;
  setUp(() {
    repository = BoardRepositoryMock();
    cubit = BoardCubit(repository);
  });

  testWidgets('board page with all tasks', (widgetTester) async {
    when(() => repository.fetch()).thenAnswer((_) async => []);

    await widgetTester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(
          home: BoardPage(),
        ),
      ),
    );

    expect(find.byKey(const Key('EmptyState')), findsOneWidget);
    await widgetTester.pump(const Duration(seconds: 2));
    expect(find.byKey(const Key('GettedState')), findsOneWidget);
  });

  testWidgets('board page with all failure state', (widgetTester) async {
    when(() => repository.fetch()).thenThrow(Exception('Error'));

    await widgetTester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(
          home: BoardPage(),
        ),
      ),
    );

    expect(find.byKey(const Key('EmptyState')), findsOneWidget);
    await widgetTester.pump(const Duration(seconds: 2));
    expect(find.byKey(const Key('FailureState')), findsOneWidget);
  });
}
