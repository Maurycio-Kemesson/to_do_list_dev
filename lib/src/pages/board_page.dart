import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_dev/src/cubits/board_cubit.dart';
import 'package:to_do_list_dev/src/models/task.dart';
import 'package:to_do_list_dev/src/states/board_state.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BoardCubit>().fetchTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<BoardCubit>();
    final state = cubit.state;

    Widget body = Container();

    if (state is EmptyBoardState) {
      body = const Center(
        key: Key('EmptyState'),
        child: Text("Adicione uma nova task"),
      );
    } else if (state is GettedTasksBoardState) {
      final tasks = state.tasks;
      body = ListView.builder(
        key: const Key('GettedState'),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return GestureDetector(
            onLongPress: () {
              cubit.remove(newTask: task);
            },
            child: CheckboxListTile.adaptive(
              value: task.check,
              title: Text(task.description),
              onChanged: (value) {
                cubit.checkTask(newTask: task);
              },
            ),
          );
        },
      );
    } else if (state is FailureBoardState) {
      body = const Center(
        key: Key('FailureState'),
        child: Text('Falha ao pegar as tasks'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks", style: Theme.of(context).textTheme.bodyMedium),
        elevation: 1,
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskDialog();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void addTaskDialog() {
    var description = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Sair'),
            ),
            TextButton(
              onPressed: () {
                final Task task = Task(id: -1, description: description);
                context.read<BoardCubit>().addTask(newTask: task);
                Navigator.pop(context);
              },
              child: const Text('Criar'),
            )
          ],
          title: const Text('Adicionar uma task'),
          content: TextField(
            onChanged: (value) => description = value,
          ),
        );
      },
    );
  }
}
