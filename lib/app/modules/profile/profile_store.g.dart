// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStoreBase, Store {
  final _$profileEditAtom = Atom(name: '_ProfileStoreBase.profileEdit');

  @override
  ObservableMap<dynamic, dynamic> get profileEdit {
    _$profileEditAtom.reportRead();
    return super.profileEdit;
  }

  @override
  set profileEdit(ObservableMap<dynamic, dynamic> value) {
    _$profileEditAtom.reportWrite(value, super.profileEdit, () {
      super.profileEdit = value;
    });
  }

  final _$profileDataAtom = Atom(name: '_ProfileStoreBase.profileData');

  @override
  ObservableMap<dynamic, dynamic> get profileData {
    _$profileDataAtom.reportRead();
    return super.profileData;
  }

  @override
  set profileData(ObservableMap<dynamic, dynamic> value) {
    _$profileDataAtom.reportWrite(value, super.profileData, () {
      super.profileData = value;
    });
  }

  final _$birthdayValidateAtom =
      Atom(name: '_ProfileStoreBase.birthdayValidate');

  @override
  bool get birthdayValidate {
    _$birthdayValidateAtom.reportRead();
    return super.birthdayValidate;
  }

  @override
  set birthdayValidate(bool value) {
    _$birthdayValidateAtom.reportWrite(value, super.birthdayValidate, () {
      super.birthdayValidate = value;
    });
  }

  final _$bankValidateAtom = Atom(name: '_ProfileStoreBase.bankValidate');

  @override
  bool get bankValidate {
    _$bankValidateAtom.reportRead();
    return super.bankValidate;
  }

  @override
  set bankValidate(bool value) {
    _$bankValidateAtom.reportWrite(value, super.bankValidate, () {
      super.bankValidate = value;
    });
  }

  final _$genderValidateAtom = Atom(name: '_ProfileStoreBase.genderValidate');

  @override
  bool get genderValidate {
    _$genderValidateAtom.reportRead();
    return super.genderValidate;
  }

  @override
  set genderValidate(bool value) {
    _$genderValidateAtom.reportWrite(value, super.genderValidate, () {
      super.genderValidate = value;
    });
  }

  final _$avatarValidateAtom = Atom(name: '_ProfileStoreBase.avatarValidate');

  @override
  bool get avatarValidate {
    _$avatarValidateAtom.reportRead();
    return super.avatarValidate;
  }

  @override
  set avatarValidate(bool value) {
    _$avatarValidateAtom.reportWrite(value, super.avatarValidate, () {
      super.avatarValidate = value;
    });
  }

  final _$pixKeyValidateAtom = Atom(name: '_ProfileStoreBase.pixKeyValidate');

  @override
  bool get pixKeyValidate {
    _$pixKeyValidateAtom.reportRead();
    return super.pixKeyValidate;
  }

  @override
  set pixKeyValidate(bool value) {
    _$pixKeyValidateAtom.reportWrite(value, super.pixKeyValidate, () {
      super.pixKeyValidate = value;
    });
  }

  final _$concludedAtom = Atom(name: '_ProfileStoreBase.concluded');

  @override
  bool get concluded {
    _$concludedAtom.reportRead();
    return super.concluded;
  }

  @override
  set concluded(bool value) {
    _$concludedAtom.reportWrite(value, super.concluded, () {
      super.concluded = value;
    });
  }

  final _$clearNewRatingsAsyncAction =
      AsyncAction('_ProfileStoreBase.clearNewRatings');

  @override
  Future<void> clearNewRatings() {
    return _$clearNewRatingsAsyncAction.run(() => super.clearNewRatings());
  }

  final _$changeNotificationEnabledAsyncAction =
      AsyncAction('_ProfileStoreBase.changeNotificationEnabled');

  @override
  Future changeNotificationEnabled(bool change) {
    return _$changeNotificationEnabledAsyncAction
        .run(() => super.changeNotificationEnabled(change));
  }

  final _$setProfileEditFromDocAsyncAction =
      AsyncAction('_ProfileStoreBase.setProfileEditFromDoc');

  @override
  Future<dynamic> setProfileEditFromDoc() {
    return _$setProfileEditFromDocAsyncAction
        .run(() => super.setProfileEditFromDoc());
  }

  final _$pickAvatarAsyncAction = AsyncAction('_ProfileStoreBase.pickAvatar');

  @override
  Future<void> pickAvatar() {
    return _$pickAvatarAsyncAction.run(() => super.pickAvatar());
  }

  final _$setBirthdayAsyncAction = AsyncAction('_ProfileStoreBase.setBirthday');

  @override
  Future setBirthday(dynamic context, Function callBack) {
    return _$setBirthdayAsyncAction
        .run(() => super.setBirthday(context, callBack));
  }

  final _$saveProfileAsyncAction = AsyncAction('_ProfileStoreBase.saveProfile');

  @override
  Future<dynamic> saveProfile(dynamic context) {
    return _$saveProfileAsyncAction.run(() => super.saveProfile(context));
  }

  final _$setTokenLogoutAsyncAction =
      AsyncAction('_ProfileStoreBase.setTokenLogout');

  @override
  Future<void> setTokenLogout() {
    return _$setTokenLogoutAsyncAction.run(() => super.setTokenLogout());
  }

  final _$getAdsDocAsyncAction = AsyncAction('_ProfileStoreBase.getAdsDoc');

  @override
  Future<DocumentSnapshot<Object?>> getAdsDoc(String orderId) {
    return _$getAdsDocAsyncAction.run(() => super.getAdsDoc(orderId));
  }

  final _$answerRatingAsyncAction =
      AsyncAction('_ProfileStoreBase.answerRating');

  @override
  Future<void> answerRating(
      String ratingId, String answer, BuildContext context) {
    return _$answerRatingAsyncAction
        .run(() => super.answerRating(ratingId, answer, context));
  }

  final _$_ProfileStoreBaseActionController =
      ActionController(name: '_ProfileStoreBase');

  @override
  bool getValidate() {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.getValidate');
    try {
      return super.getValidate();
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
profileEdit: ${profileEdit},
profileData: ${profileData},
birthdayValidate: ${birthdayValidate},
bankValidate: ${bankValidate},
genderValidate: ${genderValidate},
avatarValidate: ${avatarValidate},
pixKeyValidate: ${pixKeyValidate},
concluded: ${concluded}
    ''';
  }
}
