import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_emissary/app/core/modules/root/root_store.dart';
import 'package:delivery_emissary/app/core/utils/auth_status_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import '../../models/agent_model.dart';
import 'auth_service.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  // _AuthStoreBase() {
  //   _authService.handleGetUser().then(setUser);
  // }
  final AuthService _authService = Modular.get();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RootStore rootController = Modular.get();

  Agent agent = Agent();
  @observable
  AuthStatus status = AuthStatus.loading;
  @observable
  String? userVerifyId;
  @observable
  String mobile = '';
  @observable
  String? phoneMobile;
  @observable
  bool linked = false;
  @observable
  User? user;
  @observable
  bool codeSent = false;
  @observable
  Agent? agentBD;
  @observable
  OverlayEntry? overlayEntry;
  @observable
  bool canBack = true;

  @action
  bool getCanBack() => canBack;
  @action
  String getUserVerifyId() => userVerifyId!;
  @action
  setCodeSent(bool _valc) => codeSent = _valc;
  @action
  setLinked(bool _vald) => linked = _vald;
  @action
  setUser(User? value) {
    user = value;
    status = user == null ? AuthStatus.signed_out : AuthStatus.signed_in;
  }

  // _AuthStoreBase(this.seller);

  @action
  Future signinWithGoogle() async {
    await _authService.handleGoogleSignin();
  }

  @action
  Future linkAccountGoogle() async {
    await _authService.handleLinkAccountGoogle(user!);
  }

  @action
  Future getUser() async {
    user = await _authService.handleGetUser();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      // //print'dentro do then  ${value.data['firstName']}');
      agentBD = Agent.fromDoc(value);
      // user = ;
      // //print'depois do fromDoc  $user');

      return user;
    });
  }

  @action
  Future signup(Agent agent) async {
    agent = await _authService.handleSignup(agent);
  }

  @action
  Future siginEmail(String email, String password) async {
    user = await _authService.handleEmailSignin(email, password);
  }

  @action
  Future signout() async {
    setUser(null);
    return _authService.handleSetSignout();
  }

  @action
  Future sentSMS(String userPhone) async {
    return _authService.verifyNumber(userPhone);
  }

  @action
  Future verifyNumber(String userPhone) async {
    String verifID = '';
    phoneMobile = '+55' + userPhone;
    print('phoneMobile === $phoneMobile');
    mobile = userPhone;

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneMobile!,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) async {
        print('authCredential: =================$authCredential');
        final User _user =
            (await _auth.signInWithCredential(authCredential)).user!;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("agents")
            .doc(_user.uid)
            .get();
        if (userDoc.exists) {
          print('%%%%%%%% signinPhone _user.exists == true  %%%%%%%%');
          String? tokenString = await FirebaseMessaging.instance.getToken();
          print('tokenId: $tokenString');
          await userDoc.reference.update({
            'token_id': [tokenString]
          });
          // overlayEntry!.remove();
          // overlayEntry = null;
          Modular.to.pushNamed('/main');
        } else {
          print('%%%%%%%% signinPhone _user.exists == false  %%%%%%%%');
          // overlayEntry!.remove();
          // overlayEntry = null;
          agent.phone = _user.phoneNumber;
          await _authService.handleSignup(agent);
          Modular.to.pushNamed('/main');
          // Modular.to.pushNamed('/address/address-setup');
        }
      },
      verificationFailed: (FirebaseAuthException authException) {
        print("authException.message: ${authException.message}");
        overlayEntry!.remove();
        overlayEntry = null;
      },
      codeSent: (String verificationId, int? forceResendingToken) async {
        print("verificationId: $verificationId");
        userVerifyId = verificationId;
        verifID = verificationId;
        codeSent = true;
        setCodeSent(true);

        overlayEntry!.remove();
        overlayEntry = null;
        canBack = true;
        await Modular.to.pushNamed('/sign/verify', arguments: userPhone);
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        print("codeAutoRetrievalTimeout ID: $verificationId");
        verificationId = verificationId;
        verifID = verificationId;
        codeSent = true;
        setCodeSent(true);

        if(overlayEntry != null){
          overlayEntry!.remove();
          overlayEntry = null;
        }
        canBack = true;
        await Modular.to.pushNamed('/sign/verify', arguments: userPhone);
      },
    );
    return verifID;
  }

  @action
  handleSmsSignin(String smsCode, String verificationId) async {
    print('%%%%%%%% handleSmsSignin %%%%%%%%');

    print('credential: =================$verificationId');
    print('credential: =================$smsCode');

    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    // print('credential: =================$credential');
    try {
      final User _user = (await _auth.signInWithCredential(credential)).user!;
      print('user: =================$_user');
      user = _user;
      // await FirebaseAuth.instance
      //     .signInWithCredential(credential)
      //     .then((authResult) {
      //   print('KKKKKKKKKKKKKKKKKKKKKK${authResult.user}');
      // });
      return _user;
    } catch (e) {
      print('%%%%%%%%% error: ${e.toString()} %%%%%%%%%%%');
      if (e.toString() ==
          '[firebase_auth/invalid-verification-code] The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user.') {
        Fluttertoast.showToast(
            msg: "Código inválido!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
