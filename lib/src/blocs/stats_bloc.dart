import 'package:zero_to_hero/src/models/timeline_item_model.dart';
import 'package:zero_to_hero/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zero_to_hero/src/models/date_item_model.dart';

class StatsBloc {
  final _repository = Repository();
  final _totalFetcher = BehaviorSubject<DateItemModel>();
  final _todayFetcher = BehaviorSubject<DateItemModel>();
  final _yesterdayFetcher = BehaviorSubject<DateItemModel>();
  final _timelineFetcher = BehaviorSubject<List<TimelineItemModel>>();

  StatsBloc() {
    // fetch once
    _fetchTotal();
    _fetchToday();
    _fetchYesterday();
    _fetchTimeline();
  }

  Stream<DateItemModel> get today => _todayFetcher.stream;
  Stream<DateItemModel> get yesterday => _yesterdayFetcher.stream;
  Stream<DateItemModel> get total => _totalFetcher.stream;
  Stream<List<TimelineItemModel>> get timeline => _timelineFetcher.stream;

  void _fetchTotal() async {
    final timelineItemModel = await _repository.fetchTotal();
    _totalFetcher.add(timelineItemModel);
  }

  void _fetchToday() async {
    DateItemModel dateItemModel = await _repository.fetchToday();
    _todayFetcher.add(dateItemModel);
  }

  void _fetchYesterday() async {
    DateItemModel dateItemModel = await _repository.fetchYesterday();
    _yesterdayFetcher.add(dateItemModel);
  }

  void _fetchTimeline() async {
    final timeline = await _repository.fetchTimeline();
    _timelineFetcher.add(timeline);
  }

  dispose() {
    _totalFetcher.close();
    _todayFetcher.close();
    _yesterdayFetcher.close();
    _timelineFetcher.close();
  }
}
