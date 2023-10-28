// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrdersStore on _OrdersStoreBase, Store {
  final _$viewableOrderStatusAtom =
      Atom(name: '_OrdersStoreBase.viewableOrderStatus');

  @override
  ObservableList<dynamic> get viewableOrderStatus {
    _$viewableOrderStatusAtom.reportRead();
    return super.viewableOrderStatus;
  }

  @override
  set viewableOrderStatus(ObservableList<dynamic> value) {
    _$viewableOrderStatusAtom.reportWrite(value, super.viewableOrderStatus, () {
      super.viewableOrderStatus = value;
    });
  }

  final _$secondsToCancelAtom = Atom(name: '_OrdersStoreBase.secondsToCancel');

  @override
  int get secondsToCancel {
    _$secondsToCancelAtom.reportRead();
    return super.secondsToCancel;
  }

  @override
  set secondsToCancel(int value) {
    _$secondsToCancelAtom.reportWrite(value, super.secondsToCancel, () {
      super.secondsToCancel = value;
    });
  }

  final _$timerAtom = Atom(name: '_OrdersStoreBase.timer');

  @override
  Timer get timer {
    _$timerAtom.reportRead();
    return super.timer;
  }

  @override
  set timer(Timer value) {
    _$timerAtom.reportWrite(value, super.timer, () {
      super.timer = value;
    });
  }

  final _$delivryngAtom = Atom(name: '_OrdersStoreBase.delivryng');

  @override
  bool get delivryng {
    _$delivryngAtom.reportRead();
    return super.delivryng;
  }

  @override
  set delivryng(bool value) {
    _$delivryngAtom.reportWrite(value, super.delivryng, () {
      super.delivryng = value;
    });
  }

  final _$canBackAtom = Atom(name: '_OrdersStoreBase.canBack');

  @override
  bool get canBack {
    _$canBackAtom.reportRead();
    return super.canBack;
  }

  @override
  set canBack(bool value) {
    _$canBackAtom.reportWrite(value, super.canBack, () {
      super.canBack = value;
    });
  }

  final _$hasArrivedAtom = Atom(name: '_OrdersStoreBase.hasArrived');

  @override
  bool get hasArrived {
    _$hasArrivedAtom.reportRead();
    return super.hasArrived;
  }

  @override
  set hasArrived(bool value) {
    _$hasArrivedAtom.reportWrite(value, super.hasArrived, () {
      super.hasArrived = value;
    });
  }

  final _$inNavigationMapAtom = Atom(name: '_OrdersStoreBase.inNavigationMap');

  @override
  bool get inNavigationMap {
    _$inNavigationMapAtom.reportRead();
    return super.inNavigationMap;
  }

  @override
  set inNavigationMap(bool value) {
    _$inNavigationMapAtom.reportWrite(value, super.inNavigationMap, () {
      super.inNavigationMap = value;
    });
  }

  final _$orderSelectedAtom = Atom(name: '_OrdersStoreBase.orderSelected');

  @override
  Order? get orderSelected {
    _$orderSelectedAtom.reportRead();
    return super.orderSelected;
  }

  @override
  set orderSelected(Order? value) {
    _$orderSelectedAtom.reportWrite(value, super.orderSelected, () {
      super.orderSelected = value;
    });
  }

  final _$sellerAtom = Atom(name: '_OrdersStoreBase.seller');

  @override
  Seller? get seller {
    _$sellerAtom.reportRead();
    return super.seller;
  }

  @override
  set seller(Seller? value) {
    _$sellerAtom.reportWrite(value, super.seller, () {
      super.seller = value;
    });
  }

  final _$customerAtom = Atom(name: '_OrdersStoreBase.customer');

  @override
  Customer? get customer {
    _$customerAtom.reportRead();
    return super.customer;
  }

  @override
  set customer(Customer? value) {
    _$customerAtom.reportWrite(value, super.customer, () {
      super.customer = value;
    });
  }

  final _$locationAtom = Atom(name: '_OrdersStoreBase.location');

  @override
  Marker? get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(Marker? value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  final _$destinationAtom = Atom(name: '_OrdersStoreBase.destination');

  @override
  Marker? get destination {
    _$destinationAtom.reportRead();
    return super.destination;
  }

  @override
  set destination(Marker? value) {
    _$destinationAtom.reportWrite(value, super.destination, () {
      super.destination = value;
    });
  }

  final _$destinationAddressAtom =
      Atom(name: '_OrdersStoreBase.destinationAddress');

  @override
  Address? get destinationAddress {
    _$destinationAddressAtom.reportRead();
    return super.destinationAddress;
  }

  @override
  set destinationAddress(Address? value) {
    _$destinationAddressAtom.reportWrite(value, super.destinationAddress, () {
      super.destinationAddress = value;
    });
  }

  final _$googleMapControllerAtom =
      Atom(name: '_OrdersStoreBase.googleMapController');

  @override
  GoogleMapController? get googleMapController {
    _$googleMapControllerAtom.reportRead();
    return super.googleMapController;
  }

  @override
  set googleMapController(GoogleMapController? value) {
    _$googleMapControllerAtom.reportWrite(value, super.googleMapController, () {
      super.googleMapController = value;
    });
  }

  final _$navigationMapControllerAtom =
      Atom(name: '_OrdersStoreBase.navigationMapController');

  @override
  GoogleMapController? get navigationMapController {
    _$navigationMapControllerAtom.reportRead();
    return super.navigationMapController;
  }

  @override
  set navigationMapController(GoogleMapController? value) {
    _$navigationMapControllerAtom
        .reportWrite(value, super.navigationMapController, () {
      super.navigationMapController = value;
    });
  }

  final _$circleAtom = Atom(name: '_OrdersStoreBase.circle');

  @override
  Circle? get circle {
    _$circleAtom.reportRead();
    return super.circle;
  }

  @override
  set circle(Circle? value) {
    _$circleAtom.reportWrite(value, super.circle, () {
      super.circle = value;
    });
  }

  final _$infoAtom = Atom(name: '_OrdersStoreBase.info');

  @override
  Directions? get info {
    _$infoAtom.reportRead();
    return super.info;
  }

  @override
  set info(Directions? value) {
    _$infoAtom.reportWrite(value, super.info, () {
      super.info = value;
    });
  }

  final _$positionSubscriptionAtom =
      Atom(name: '_OrdersStoreBase.positionSubscription');

  @override
  StreamSubscription<Position>? get positionSubscription {
    _$positionSubscriptionAtom.reportRead();
    return super.positionSubscription;
  }

  @override
  set positionSubscription(StreamSubscription<Position>? value) {
    _$positionSubscriptionAtom.reportWrite(value, super.positionSubscription,
        () {
      super.positionSubscription = value;
    });
  }

  final _$scrollingMapAtom = Atom(name: '_OrdersStoreBase.scrollingMap');

  @override
  bool get scrollingMap {
    _$scrollingMapAtom.reportRead();
    return super.scrollingMap;
  }

  @override
  set scrollingMap(bool value) {
    _$scrollingMapAtom.reportWrite(value, super.scrollingMap, () {
      super.scrollingMap = value;
    });
  }

  final _$orderListenAtom = Atom(name: '_OrdersStoreBase.orderListen');

  @override
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? get orderListen {
    _$orderListenAtom.reportRead();
    return super.orderListen;
  }

  @override
  set orderListen(
      StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? value) {
    _$orderListenAtom.reportWrite(value, super.orderListen, () {
      super.orderListen = value;
    });
  }

  final _$getMarkerAsyncAction = AsyncAction('_OrdersStoreBase.getMarker');

  @override
  Future<Uint8List> getMarker(dynamic context) {
    return _$getMarkerAsyncAction.run(() => super.getMarker(context));
  }

  final _$getUsersAsyncAction = AsyncAction('_OrdersStoreBase.getUsers');

  @override
  Future<dynamic> getUsers() {
    return _$getUsersAsyncAction.run(() => super.getUsers());
  }

  final _$getMarkersAsyncAction = AsyncAction('_OrdersStoreBase.getMarkers');

  @override
  Future<void> getMarkers(dynamic context) {
    return _$getMarkersAsyncAction.run(() => super.getMarkers(context));
  }

  final _$changeOrderStatusAsyncAction =
      AsyncAction('_OrdersStoreBase.changeOrderStatus');

  @override
  Future<dynamic> changeOrderStatus(
      Order model, String status, String token, dynamic context) {
    return _$changeOrderStatusAsyncAction
        .run(() => super.changeOrderStatus(model, status, token, context));
  }

  final _$startNewMissionAsyncAction =
      AsyncAction('_OrdersStoreBase.startNewMission');

  @override
  Future startNewMission(dynamic context) {
    return _$startNewMissionAsyncAction
        .run(() => super.startNewMission(context));
  }

  final _$phoneCallWithCustomerAsyncAction =
      AsyncAction('_OrdersStoreBase.phoneCallWithCustomer');

  @override
  Future<void> phoneCallWithCustomer() {
    return _$phoneCallWithCustomerAsyncAction
        .run(() => super.phoneCallWithCustomer());
  }

  final _$confirmProductAsyncAction =
      AsyncAction('_OrdersStoreBase.confirmProduct');

  @override
  Future confirmProduct(dynamic context) {
    return _$confirmProductAsyncAction.run(() => super.confirmProduct(context));
  }

  final _$concludeOrderAsyncAction =
      AsyncAction('_OrdersStoreBase.concludeOrder');

  @override
  Future concludeOrder(dynamic context, dynamic token) {
    return _$concludeOrderAsyncAction
        .run(() => super.concludeOrder(context, token));
  }

  final _$_OrdersStoreBaseActionController =
      ActionController(name: '_OrdersStoreBase');

  @override
  void sendMessage() {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.sendMessage');
    try {
      return super.sendMessage();
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateMarkerAndCircle(Position newLocalData, Uint8List imageData) {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.updateMarkerAndCircle');
    try {
      return super.updateMarkerAndCircle(newLocalData, imageData);
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addOrderListen(dynamic context) {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.addOrderListen');
    try {
      return super.addOrderListen(context);
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cleanMissionInProgressVars() {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.cleanMissionInProgressVars');
    try {
      return super.cleanMissionInProgressVars();
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool getInNavigationMap() {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.getInNavigationMap');
    try {
      return super.getInNavigationMap();
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool getCanBack() {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.getCanBack');
    try {
      return super.getCanBack();
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setOrderStatusView(ObservableList<dynamic> _viewableOrderStatus) {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.setOrderStatusView');
    try {
      return super.setOrderStatusView(_viewableOrderStatus);
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setOrderSelected(Order _order) {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.setOrderSelected');
    try {
      return super.setOrderSelected(_order);
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cancelOrder(dynamic context) {
    final _$actionInfo = _$_OrdersStoreBaseActionController.startAction(
        name: '_OrdersStoreBase.cancelOrder');
    try {
      return super.cancelOrder(context);
    } finally {
      _$_OrdersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
viewableOrderStatus: ${viewableOrderStatus},
secondsToCancel: ${secondsToCancel},
timer: ${timer},
delivryng: ${delivryng},
canBack: ${canBack},
hasArrived: ${hasArrived},
inNavigationMap: ${inNavigationMap},
orderSelected: ${orderSelected},
seller: ${seller},
customer: ${customer},
location: ${location},
destination: ${destination},
destinationAddress: ${destinationAddress},
googleMapController: ${googleMapController},
navigationMapController: ${navigationMapController},
circle: ${circle},
info: ${info},
positionSubscription: ${positionSubscription},
scrollingMap: ${scrollingMap},
orderListen: ${orderListen}
    ''';
  }
}
