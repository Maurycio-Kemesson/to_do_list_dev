import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_dev/src/cubits/board_cubit.dart';
import 'package:to_do_list_dev/src/models/task.dart';
import 'package:to_do_list_dev/src/repositories/board_repository.dart';
import 'package:to_do_list_dev/src/states/board_state.dart';

class BoardRepositoryMock extends Mock implements BoardRepository {}

void main() {
  late BoardRepository repository = BoardRepositoryMock();
  late BoardCubit cubit;
  setUp(() {
    repository = BoardRepositoryMock();
    cubit = BoardCubit(repository);
  });

  group("fetchTasks", () {
    test('Must get all tasks', () async {
      when(() => repository.fetch()).thenAnswer(
        (_) async => [
          const Task(id: 1, description: "", check: false),
        ],
      );

      expect(
        cubit.stream,
        emitsInOrder([
          isA<LoadingBoardState>(),
          isA<GettedTasksBoardState>(),
        ]),
      );
      await cubit.fetchTask();
    });

    test("should return error state on failure", () async {
      when(() => repository.fetch()).thenThrow(Exception('Error'));
      expect(
        cubit.stream,
        emitsInOrder(
          [
            isA<LoadingBoardState>(),
            isA<FailureBoardState>(),
          ],
        ),
      );

      await cubit.fetchTask();
    });
  });

  group("removeTask |", () {
    test('Must remove a task', () async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenAnswer((_) async => []);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );

      const Task task = Task(id: 1, description: '');
      await cubit.addTask(newTask: task);

      final state = cubit.state as GettedTasksBoardState;

      expect(state.tasks.length, 1);
      expect(state.tasks, [task]);
    });

    test("should return error state on failure", () async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenThrow(Exception('Error'));
      expect(
        cubit.stream,
        emitsInOrder(
          [
            isA<FailureBoardState>(),
          ],
        ),
      );

      const Task task = Task(id: 1, description: '');
      await cubit.addTask(newTask: task);
    });
  });

  group("addTask |", () {
    test('Must add a tasks', () async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenAnswer((_) async => []);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );

      const Task task = Task(id: 1, description: '');
      await cubit.addTask(newTask: task);

      final state = cubit.state as GettedTasksBoardState;

      expect(state.tasks.length, 1);
      expect(state.tasks, [task]);
    });

    test("should return error state on failure", () async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenThrow(Exception('Error'));
      expect(
        cubit.stream,
        emitsInOrder(
          [
            isA<FailureBoardState>(),
          ],
        ),
      );

      const Task task = Task(id: 1, description: '');
      await cubit.addTask(newTask: task);
    });
  });

  group("removeTask |", () {
    test('Must remove a task', () async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenAnswer((_) async => []);
      const Task task = Task(id: 1, description: '');
      cubit.addTasks(tasks: [task]);
      expect((cubit.state as GettedTasksBoardState).tasks.length, 1);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );

      await cubit.remove(newTask: task);
      final state = cubit.state as GettedTasksBoardState;

      expect(state.tasks.length, 0);
    });

    test("should return error state on failure", () async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenThrow(Exception('Error'));
      const Task task = Task(id: 1, description: '');
      cubit.addTasks(tasks: [task]);

      expect(
        cubit.stream,
        emitsInOrder(
          [
            isA<FailureBoardState>(),
          ],
        ),
      );

      await cubit.remove(newTask: task);
    });
  });

  group("checkTask |", () {
    test('Must check a task', () async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenAnswer((_) async => []);
      const Task task = Task(id: 1, description: '');
      cubit.addTasks(tasks: [task]);
      expect((cubit.state as GettedTasksBoardState).tasks.first.check, false);
      expect((cubit.state as GettedTasksBoardState).tasks.length, 1);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );

      await cubit.checkTask(newTask: task);
      final state = cubit.state as GettedTasksBoardState;

      expect(state.tasks.length, 1);
      expect(state.tasks.first.check, true);
    });

    test("should return error state on failure", () async {
      when(() => repository.update(tasks: any(named: 'tasks')))
          .thenThrow(Exception('Error'));
      const Task task = Task(id: 1, description: '');
      cubit.addTasks(tasks: [task]);

      expect(
        cubit.stream,
        emitsInOrder(
          [
            isA<FailureBoardState>(),
          ],
        ),
      );

      await cubit.checkTask(newTask: task);
    });
  });
}
