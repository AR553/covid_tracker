class TimelineItemModel {
  final int _cases;
  final DateTime _date;

  TimelineItemModel({int cases, DateTime date})
      : _cases = cases,
        _date = date;

  TimelineItemModel.fromJson(Map<String, dynamic> json)
      : _cases = json['total_cases'],
        _date = DateTime.parse(json['last_update']);

  int get cases => _cases;

  DateTime get date => _date;
}
