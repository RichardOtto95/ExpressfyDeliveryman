// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PaymentStore on _PaymentStoreBase, Store {
  final _$cardsAtom = Atom(name: '_PaymentStoreBase.cards');

  @override
  ObservableList<dynamic> get cards {
    _$cardsAtom.reportRead();
    return super.cards;
  }

  @override
  set cards(ObservableList<dynamic> value) {
    _$cardsAtom.reportWrite(value, super.cards, () {
      super.cards = value;
    });
  }

  final _$confirmDeleteOverlayAtom =
      Atom(name: '_PaymentStoreBase.confirmDeleteOverlay');

  @override
  OverlayEntry get confirmDeleteOverlay {
    _$confirmDeleteOverlayAtom.reportRead();
    return super.confirmDeleteOverlay;
  }

  @override
  set confirmDeleteOverlay(OverlayEntry value) {
    _$confirmDeleteOverlayAtom.reportWrite(value, super.confirmDeleteOverlay,
        () {
      super.confirmDeleteOverlay = value;
    });
  }

  @override
  String toString() {
    return '''
cards: ${cards},
confirmDeleteOverlay: ${confirmDeleteOverlay}
    ''';
  }
}
