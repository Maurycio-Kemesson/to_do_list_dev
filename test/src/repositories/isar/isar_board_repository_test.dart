import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list_dev/src/models/task.dart';
import 'package:to_do_list_dev/src/repositories/board_repository.dart';
import 'package:to_do_list_dev/src/repositories/isar/isar_board_repository.dart';
import 'package:to_do_list_dev/src/repositories/isar/isar_datasource.dart';
import 'package:to_do_list_dev/src/repositories/isar/task_model.dart';

class IsarDatasourceMock extends Mock implements IsarDatasource {}

void main() {
  late IsarDatasource datasource;
  late BoardRepository repository;

  setUp(() {
    datasource = IsarDatasourceMock();
    repository = IsarBoardRepository(datasource);
  });
  test("fetch", () async {
    when(() => datasource.getTasks()).thenAnswer((_) async => [
          TaskModel()..id = 1,
        ]);

    final List<Task> tasks = await repository.fetch();
    expect(tasks.length, 1);
  });

  test("update", () async {
    when(() => datasource.deteleAllTask()).thenAnswer((_) async => []);
    when(() => datasource.putAllTasks(models: any(named: 'models')))
        .thenAnswer((_) async => []);

    final tasks = await repository.update(tasks: [
      const Task(id: -1, description: ''),
      const Task(id: 2, description: ''),
    ]);
    expect(tasks.length, 2);
  });
}
