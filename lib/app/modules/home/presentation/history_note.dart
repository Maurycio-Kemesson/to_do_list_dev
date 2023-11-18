import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_dev/app/modules/home/data/draggable_lists.dart';
import 'package:to_do_list_dev/app/modules/home/model/draggable_list.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
        title: Text("To-Do Histórico",
            style: Theme.of(context).textTheme.bodyMedium),
        elevation: 1,
      ),
      body: AbsorbPointer(
        child: DragAndDropLists(
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
}
