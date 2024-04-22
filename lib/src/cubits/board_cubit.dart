import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_dev/src/models/task.dart';
import 'package:to_do_list_dev/src/repositories/board_repository.dart';
import 'package:to_do_list_dev/src/states/board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  final BoardRepository repository;
  BoardCubit(this.repository) : super(EmptyBoardState());

  Future<void> fetchTask() async {
    emit(LoadingBoardState());
    try {
      final tasks = await repository.fetch();
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error'));
    }
  }

  Future<void> addTask({required Task newTask}) async {
    final List<Task>? tasks = _getTasks();
    if (tasks == null) return;
    tasks.add(newTask);
    await emitTasks(tasks: tasks);
  }

  Future<void> remove({required Task newTask}) async {
    final List<Task>? tasks = _getTasks();
    if (tasks == null) return;
    tasks.remove(newTask);
    await emitTasks(tasks: tasks);
  }

  Future<void> checkTask({required Task newTask}) async {
    final List<Task>? tasks = _getTasks();
    if (tasks == null) return;
    final int index = tasks.indexOf(newTask);
    tasks[index] = newTask.copyWith(check: !newTask.check);
    await emitTasks(tasks: tasks);
  }

  @visibleForTesting
  void addTasks({required List<Task> tasks}) {
    emit(GettedTasksBoardState(tasks: tasks));
  }

  List<Task>? _getTasks() {
    final state = this.state;

    if (state is! GettedTasksBoardState) {
      return null;
    }
    return state.tasks.toList();
  }

  Future<void> emitTasks({required List<Task> tasks}) async {
    try {
      await repository.update(tasks: tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState(message: 'Error'));
    }
  }
}
