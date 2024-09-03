class ChecklistItem {
  final int id;
  final String name;
  final bool itemCompletionStatus;

  ChecklistItem({
    required this.id,
    required this.name,
    required this.itemCompletionStatus,
  });

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      id: json['id'],
      name: json['name'].toString(),
      itemCompletionStatus: json['itemCompletionStatus'],
    );
  }
}

class Checklist {
  final int id;
  final String name;
  final bool checklistCompletionStatus;
  final List<ChecklistItem>? items;

  Checklist({
    required this.id,
    required this.name,
    required this.checklistCompletionStatus,
    this.items,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List?;
    List<ChecklistItem>? items = itemsJson != null
        ? itemsJson.map((item) => ChecklistItem.fromJson(item)).toList()
        : null;

    return Checklist(
      id: json['id'],
      name: json['name'].toString(),
      checklistCompletionStatus: json['checklistCompletionStatus'],
      items: items,
    );
  }
}
