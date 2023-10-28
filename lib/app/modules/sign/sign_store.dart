import 'package:delivery_emissary/app/core/services/auth/auth_service_interface.dart';
import 'package:delivery_emissary/app/shared/widgets/load_circular_overlay.dart';
import 'package:delivery_emissary/app/core/services/auth/auth_store.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';

import '../../core/models/agent_model.dart';

part 'sign_store.g.dart';

class SignStore = _SignStoreBase with _$SignStore;

abstract class _SignStoreBase with Store {
  final AuthStore authStore = Modular.get();
  final Agent agent;
  AuthServiceInterface authService = Modular.get();
  @observable
  User? valueUser;
  @observable
  String? phone;
  @observable
  int start = 60;
  @observable
  Timer? timer;

  @observable
  _SignStoreBase(this.agent);

  @action
  void setPhone(_phone) => phone = _phone;

  @action
  int getStart() => start;

  @action
  verifyNumber(BuildContext context) async {
    authStore.overlayEntry =
        OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(authStore.overlayEntry!);
    authStore.canBack = false;

    print('##### phone $phone');
    String userPhone = '+55' + phone!;
    print('##### userPhone $userPhone');
    await authStore.verifyNumber(phone!);
  }

  @action
  signinPhone(String _code, String verifyId, context) async {
    print('%%%%%%%% signinPhone %%%%%%%%');
    print('$_code, $verifyId');
    OverlayEntry overlayEntry =
        OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(overlayEntry);
    authStore.canBack = false;

    await authStore.handleSmsSignin(_code, verifyId).then((value) async {
      print("Dentro do then");
      print('%%%%%%%% signinPhone2 $value %%%%%%%%');
      if (value != null) {
        valueUser = value;
        DocumentSnapshot _user = await FirebaseFirestore.instance
            .collection('agents')
            .doc(value.uid)
            .get();
        // QuerySnapshot addresses =
        //     await _user.reference.collection("addresses").get();
        if (_user.exists) {
          print('%%%%%%%% signinPhone _user.exists == true  %%%%%%%%');

          String? tokenString = await FirebaseMessaging.instance.getToken();
          print('tokenId: $tokenString');
          await _user.reference.update({
            'token_id': [tokenString]
          });
          // if (addresses.docs.isEmpty) {
          //   Modular.to.pushNamed('/address', arguments: true);
          // } else {
            Modular.to.pushNamed("/main");
          // }
        } else {
          print('%%%%%%%% signinPhone _user.exists == false  %%%%%%%%');
          agent.phone = value.phoneNumber;
          await authService.handleSignup(agent);
          // if (addresses.docs.isEmpty) {
          //   Modular.to.pushNamed('/address', arguments: true);
          // } else {
            Modular.to.pushNamed("/main");
          // }
        }
      } else {}
    });

    print("Fora do then");
    overlayEntry.remove();

    authStore.canBack = true;
  }
}
