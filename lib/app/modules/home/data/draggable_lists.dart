import 'package:to_do_list_dev/app/modules/home/model/draggable_list.dart';

List<DraggableList> allLists = [
   DraggableList(
    listTitle: 'Pendentes',
    activityList: const [
      ActivityListItem(
        title: 'Estudar Flutter',
        createDate: '10/11/2023',
      ),
      ActivityListItem(
        title: 'Prova APS',
        createDate: '10/11/2023',
      ),
    ],
  ),
   DraggableList(
    listTitle: 'Em andamento',
    activityList: const  [
      ActivityListItem(
        title: 'APS Dispositivos Móveis',
        createDate: '10/11/2023',
      ),
    ],
  ),
   DraggableList(
    listTitle: 'Concluídas',
    activityList: const [
      ActivityListItem(
        title: 'Estudar AWS',
        createDate: '10/11/2023',
      ),
      ActivityListItem(
        title: 'Fazer compras',
        createDate: '10/11/2023',
      ),
    ],
  ),
];
