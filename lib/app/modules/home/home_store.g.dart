// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  final _$calendarControllerAtom =
      Atom(name: '_HomeStoreBase.calendarController');

  @override
  CalendarController get calendarController {
    _$calendarControllerAtom.reportRead();
    return super.calendarController;
  }

  @override
  set calendarController(CalendarController value) {
    _$calendarControllerAtom.reportWrite(value, super.calendarController, () {
      super.calendarController = value;
    });
  }

  final _$filterOverlayAtom = Atom(name: '_HomeStoreBase.filterOverlay');

  @override
  OverlayEntry? get filterOverlay {
    _$filterOverlayAtom.reportRead();
    return super.filterOverlay;
  }

  @override
  set filterOverlay(OverlayEntry? value) {
    _$filterOverlayAtom.reportWrite(value, super.filterOverlay, () {
      super.filterOverlay = value;
    });
  }

  final _$removeOverlayAtom = Atom(name: '_HomeStoreBase.removeOverlay');

  @override
  bool get removeOverlay {
    _$removeOverlayAtom.reportRead();
    return super.removeOverlay;
  }

  @override
  set removeOverlay(bool value) {
    _$removeOverlayAtom.reportWrite(value, super.removeOverlay, () {
      super.removeOverlay = value;
    });
  }

  final _$startTimestampAtom = Atom(name: '_HomeStoreBase.startTimestamp');

  @override
  Timestamp? get startTimestamp {
    _$startTimestampAtom.reportRead();
    return super.startTimestamp;
  }

  @override
  set startTimestamp(Timestamp? value) {
    _$startTimestampAtom.reportWrite(value, super.startTimestamp, () {
      super.startTimestamp = value;
    });
  }

  final _$endTimestampAtom = Atom(name: '_HomeStoreBase.endTimestamp');

  @override
  Timestamp? get endTimestamp {
    _$endTimestampAtom.reportRead();
    return super.endTimestamp;
  }

  @override
  set endTimestamp(Timestamp? value) {
    _$endTimestampAtom.reportWrite(value, super.endTimestamp, () {
      super.endTimestamp = value;
    });
  }

  final _$startDateAtom = Atom(name: '_HomeStoreBase.startDate');

  @override
  DateTime? get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(DateTime? value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  final _$endDateAtom = Atom(name: '_HomeStoreBase.endDate');

  @override
  DateTime? get endDate {
    _$endDateAtom.reportRead();
    return super.endDate;
  }

  @override
  set endDate(DateTime? value) {
    _$endDateAtom.reportWrite(value, super.endDate, () {
      super.endDate = value;
    });
  }

  final _$nowDateAtom = Atom(name: '_HomeStoreBase.nowDate');

  @override
  DateTime get nowDate {
    _$nowDateAtom.reportRead();
    return super.nowDate;
  }

  @override
  set nowDate(DateTime value) {
    _$nowDateAtom.reportWrite(value, super.nowDate, () {
      super.nowDate = value;
    });
  }

  final _$yesterdayDateAtom = Atom(name: '_HomeStoreBase.yesterdayDate');

  @override
  DateTime get yesterdayDate {
    _$yesterdayDateAtom.reportRead();
    return super.yesterdayDate;
  }

  @override
  set yesterdayDate(DateTime value) {
    _$yesterdayDateAtom.reportWrite(value, super.yesterdayDate, () {
      super.yesterdayDate = value;
    });
  }

  final _$filterIndexAtom = Atom(name: '_HomeStoreBase.filterIndex');

  @override
  int get filterIndex {
    _$filterIndexAtom.reportRead();
    return super.filterIndex;
  }

  @override
  set filterIndex(int value) {
    _$filterIndexAtom.reportWrite(value, super.filterIndex, () {
      super.filterIndex = value;
    });
  }

  final _$previousFilterIndexAtom =
      Atom(name: '_HomeStoreBase.previousFilterIndex');

  @override
  int get previousFilterIndex {
    _$previousFilterIndexAtom.reportRead();
    return super.previousFilterIndex;
  }

  @override
  set previousFilterIndex(int value) {
    _$previousFilterIndexAtom.reportWrite(value, super.previousFilterIndex, () {
      super.previousFilterIndex = value;
    });
  }

  final _$filterBoolAtom = Atom(name: '_HomeStoreBase.filterBool');

  @override
  bool get filterBool {
    _$filterBoolAtom.reportRead();
    return super.filterBool;
  }

  @override
  set filterBool(bool value) {
    _$filterBoolAtom.reportWrite(value, super.filterBool, () {
      super.filterBool = value;
    });
  }

  final _$getConcludedOrdersAsyncAction =
      AsyncAction('_HomeStoreBase.getConcludedOrders');

  @override
  Future<Map<dynamic, dynamic>> getConcludedOrders() {
    return _$getConcludedOrdersAsyncAction
        .run(() => super.getConcludedOrders());
  }

  final _$getTotalAmountAsyncAction =
      AsyncAction('_HomeStoreBase.getTotalAmount');

  @override
  Future<String> getTotalAmount() {
    return _$getTotalAmountAsyncAction.run(() => super.getTotalAmount());
  }

  final _$getStatisticsAsyncAction =
      AsyncAction('_HomeStoreBase.getStatistics');

  @override
  Future<List<dynamic>> getStatistics(int index) {
    return _$getStatisticsAsyncAction.run(() => super.getStatistics(index));
  }

  final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase');

  @override
  bool filterisNotNull() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.filterisNotNull');
    try {
      return super.filterisNotNull();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic insertOverlay(dynamic context, OverlayEntry _overlay) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.insertOverlay');
    try {
      return super.insertOverlay(context, _overlay);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterAltered(int index) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.filterAltered');
    try {
      return super.filterAltered(index);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filter() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.filter');
    try {
      return super.filter();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
calendarController: ${calendarController},
filterOverlay: ${filterOverlay},
removeOverlay: ${removeOverlay},
startTimestamp: ${startTimestamp},
endTimestamp: ${endTimestamp},
startDate: ${startDate},
endDate: ${endDate},
nowDate: ${nowDate},
yesterdayDate: ${yesterdayDate},
filterIndex: ${filterIndex},
previousFilterIndex: ${previousFilterIndex},
filterBool: ${filterBool}
    ''';
  }
}
