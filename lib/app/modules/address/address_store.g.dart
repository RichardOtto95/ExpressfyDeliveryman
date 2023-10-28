// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddressStore on _AddressStoreBase, Store {
  final _$locationResultAtom = Atom(name: '_AddressStoreBase.locationResult');

  @override
  LocationResult? get locationResult {
    _$locationResultAtom.reportRead();
    return super.locationResult;
  }

  @override
  set locationResult(LocationResult? value) {
    _$locationResultAtom.reportWrite(value, super.locationResult, () {
      super.locationResult = value;
    });
  }

  final _$editAddressOverlayAtom =
      Atom(name: '_AddressStoreBase.editAddressOverlay');

  @override
  OverlayEntry? get editAddressOverlay {
    _$editAddressOverlayAtom.reportRead();
    return super.editAddressOverlay;
  }

  @override
  set editAddressOverlay(OverlayEntry? value) {
    _$editAddressOverlayAtom.reportWrite(value, super.editAddressOverlay, () {
      super.editAddressOverlay = value;
    });
  }

  final _$addressOverlayAtom = Atom(name: '_AddressStoreBase.addressOverlay');

  @override
  bool get addressOverlay {
    _$addressOverlayAtom.reportRead();
    return super.addressOverlay;
  }

  @override
  set addressOverlay(bool value) {
    _$addressOverlayAtom.reportWrite(value, super.addressOverlay, () {
      super.addressOverlay = value;
    });
  }

  final _$newAddressAsyncAction = AsyncAction('_AddressStoreBase.newAddress');

  @override
  Future newAddress(
      Map<String, dynamic> addressMap, dynamic context, bool editing) {
    return _$newAddressAsyncAction
        .run(() => super.newAddress(addressMap, context, editing));
  }

  final _$_AddressStoreBaseActionController =
      ActionController(name: '_AddressStoreBase');

  @override
  dynamic getAdressPopUpOverlay(Address address, dynamic context) {
    final _$actionInfo = _$_AddressStoreBaseActionController.startAction(
        name: '_AddressStoreBase.getAdressPopUpOverlay');
    try {
      return super.getAdressPopUpOverlay(address, context);
    } finally {
      _$_AddressStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getLocationResult(dynamic _locationResult) {
    final _$actionInfo = _$_AddressStoreBaseActionController.startAction(
        name: '_AddressStoreBase.getLocationResult');
    try {
      return super.getLocationResult(_locationResult);
    } finally {
      _$_AddressStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locationResult: ${locationResult},
editAddressOverlay: ${editAddressOverlay},
addressOverlay: ${addressOverlay}
    ''';
  }
}
