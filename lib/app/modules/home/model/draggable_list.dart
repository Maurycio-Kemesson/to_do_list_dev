class DraggableList {
  final String listTitle;
   List<ActivityListItem> activityList;

   DraggableList({
    required this.listTitle,
     this.activityList = const [],
  });
}

class ActivityListItem {
  final String title;
  final String createDate;

  const ActivityListItem({
    required this.title,
    required this.createDate,
  });
}
