// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationsStore on _NotificationsStoreBase, Store {
  final _$getNotificationsAsyncAction =
      AsyncAction('_NotificationsStoreBase.getNotifications');

  @override
  Future<List<List<dynamic>>> getNotifications() {
    return _$getNotificationsAsyncAction.run(() => super.getNotifications());
  }

  final _$visualizedAllNotificationsAsyncAction =
      AsyncAction('_NotificationsStoreBase.visualizedAllNotifications');

  @override
  Future<void> visualizedAllNotifications() {
    return _$visualizedAllNotificationsAsyncAction
        .run(() => super.visualizedAllNotifications());
  }

  final _$_NotificationsStoreBaseActionController =
      ActionController(name: '_NotificationsStoreBase');

  @override
  String getTime(Timestamp sendedAt) {
    final _$actionInfo = _$_NotificationsStoreBaseActionController.startAction(
        name: '_NotificationsStoreBase.getTime');
    try {
      return super.getTime(sendedAt);
    } finally {
      _$_NotificationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
