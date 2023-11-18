import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_dev/app/modules/home/data/draggable_lists.dart';
import 'package:to_do_list_dev/app/modules/home/model/draggable_list.dart';
import 'package:to_do_list_dev/app/modules/home/presentation/history_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<DragAndDropList> lists;

  @override
  void initState() {
    super.initState();

    lists = allLists.map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("To-Do List DEV",
                style: Theme.of(context).textTheme.bodyMedium),
            IconButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage()));},
              icon: Icon(Icons.history, color: Colors.white),
            ),
          ],
        ),
        elevation: 1,
      ),
      body: DragAndDropLists(
        listPadding: const EdgeInsets.all(16),
        listInnerDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10),
        ),
        children: lists,
        itemDecorationWhileDragging: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        listDragHandle: buildDragHandle(isList: true),
        itemDragHandle: buildDragHandle(),
        onItemReorder: onReorderListItem,
        onListReorder: onReorderList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  DragHandle buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.black : Colors.black26;

    return DragHandle(
      verticalAlignment: verticalAlignment,
      child: Container(
        padding: const EdgeInsets.only(right: 10, top: 10),
        child: Icon(Icons.menu, color: color),
      ),
    );
  }

  DragAndDropList buildList(DraggableList list) => DragAndDropList(
        header: Container(
          width: double.infinity,
          height: 45,
          padding: const EdgeInsets.all(8),
          color: list.listTitle == 'Pendentes'
              ? Colors.red
              : list.listTitle == 'Em andamento'
                  ? Colors.yellow
                  : Colors.green,
          child: Text(
            list.listTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        children: list.activityList
            .map(
              (item) => DragAndDropItem(
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Text(
                    item.createDate,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color.fromARGB(96, 137, 137, 137),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      );

  void onReorderListItem(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);
    });
  }

  void onReorderList(
    int oldListIndex,
    int newListIndex,
  ) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }

  Future<void> addNote() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        String descricao = '';
        return AlertDialog(
          title: const Text('Adicionar nota'),
          content: TextField(
            onChanged: (value) {
              descricao = value;
            },
            decoration: const InputDecoration(hintText: 'Digite a descrição'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                setState(() {
                  lists[0].children.add(
                        DragAndDropItem(
                          child: ListTile(
                            title: Text(descricao),
                            subtitle: Text(
                              DateFormat('dd/MM/yyyy').format(DateTime.now()),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color.fromARGB(96, 137, 137, 137),
                              ),
                            ),
                          ),
                        ),
                      );
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
