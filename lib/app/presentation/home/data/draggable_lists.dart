import 'package:to_do_list_dev/app/presentation/home/model/draggable_list.dart';

List<DraggableList> allLists = [
  const DraggableList(
    listTitle: 'Pendentes',
    activityList: [
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
  const DraggableList(
    listTitle: 'Em andamento',
    activityList: [
      ActivityListItem(
        title: 'APS Dispositivos Móveis',
        createDate: '10/11/2023',
      ),
    ],
  ),
  const DraggableList(
    listTitle: 'Concluídas',
    activityList: [
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
