class DraggableList {
  final String listTitle;
  final List<ActivityListItem> activityList;

  const DraggableList({
    required this.listTitle,
    required this.activityList,
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
