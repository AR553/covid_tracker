class DateItemModel {
  final int _cases;
  final int _deaths;
  final int _recovered;

  DateItemModel({int cases, int deaths, int recovered})
      : _cases = cases,
        _deaths = deaths,
        _recovered = recovered;

  DateItemModel.fromJson(Map<String, dynamic> json)
      : _cases = json['total_cases'],
        _deaths = json['total_deaths'],
        _recovered = json['total_recovered'];

  int get cases => _cases;
  int get deaths => _deaths;
  int get recovered => _recovered;
}
