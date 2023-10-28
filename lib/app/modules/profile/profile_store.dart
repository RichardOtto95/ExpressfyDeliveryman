import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_emissary/app/modules/main/main_store.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:delivery_emissary/app/shared/widgets/load_circular_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  final MainStore mainStore = Modular.get();

  @observable
  ObservableMap profileEdit = {}.asObservable();
  @observable
  ObservableMap profileData = {}.asObservable();
  @observable
  bool birthdayValidate = false;
  @observable
  bool bankValidate = false;
  @observable
  bool genderValidate = false;
  @observable
  bool avatarValidate = false;
  @observable
  bool pixKeyValidate = false;
  @observable
  bool concluded = false;
  late OverlayEntry loadOverlay;

  @action
  Future<void> clearNewRatings() async{
    print('clearNewRatings');
    User? _user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('agents').doc(_user!.uid).update({
      "new_ratings": 0,
    });
    setProfileEditFromDoc();
  }

  @action
  changeNotificationEnabled(bool change) async{
    print('changeNotificationEnabled $change');
    final User? _user = FirebaseAuth.instance.currentUser;
    profileEdit['notification_enabled'] = change;
    profileData['notification_enabled'] = change;
    FirebaseFirestore.instance.collection('agents').doc(_user!.uid).update({
      'notification_enabled': change
    });
  }

  @action
  Future setProfileEditFromDoc() async {
    print("user: ${mainStore.authStore.user?.uid}");
    DocumentSnapshot _ds = await FirebaseFirestore.instance
        .collection("agents")
        .doc(mainStore.authStore.user?.uid)
        .get();
    print("user.exist? ${_ds.exists}");
    Map<String, dynamic> map = _ds.data() as Map<String, dynamic>;
    map['linked_to_cnpj'] = map['linked_to_cnpj'] ?? false;
    map['savings_account'] = map['savings_account'] ?? false;
    ObservableMap<String, dynamic> sellerMap = map.asObservable();
    profileData = sellerMap;
    // profileEdit = sellerMap;
    // print("Seller Map: $sellerMap");
    // print("Username: ${sellerMap['username']}");
  }

  @action
  Future<void> pickAvatar() async {
    File? _imageFile = await pickImage();
    profileEdit['avatar'] = "";
    if (_imageFile != null) {
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
          'agents/${mainStore.authStore.user!.uid}/avatar/$_imageFile');

      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);

      TaskSnapshot taskSnapshot = await uploadTask;

      taskSnapshot.ref.getDownloadURL().then((downloadURL) async {
        print(
            'downloadURLdownloadURLdownloadURLdownloadURLdownloadURL    $downloadURL');
        profileEdit['avatar'] = downloadURL;
        // profileData['avatar'] = downloadURL;
        avatarValidate = false;
      });
    }
  }

  @action
  bool getValidate() {
    if (profileEdit['birthday'] == null) {
      birthdayValidate = true;
    } else {
      birthdayValidate = false;
    }

    if (profileEdit['bank'] == null || profileEdit['bank'] == '') {
      bankValidate = true;
    } else {
      bankValidate = false;
    }

    if (profileEdit['gender'] == null || profileEdit['gender'] == '') {
      genderValidate = true;
    } else {
      genderValidate = false;
    }

    if (profileEdit['avatar'] == null || profileEdit['avatar'] == '') {
      avatarValidate = true;
    } else {
      avatarValidate = false;
    }

    if (profileEdit['pix_key'] == null || profileEdit['pix_key'] == '') {
      pixKeyValidate = true;
    } else {
      pixKeyValidate = false;
    }

    return !birthdayValidate &&
        !bankValidate &&
        !genderValidate &&
        !avatarValidate;
  }

  @action
  setBirthday(context, Function callBack) async {
    DateTime? _birthday;
    pickDate(context, onConfirm: (date) {
      print("Confirm pick date");
      _birthday = date;
      if (_birthday != null) {
        profileEdit["birthday"] = Timestamp.fromDate(_birthday!);
        // profileData["birthday"] = Timestamp.fromDate(_birthday!);
        birthdayValidate = false;
        callBack();
      }
    });
  }

  @action
  Future saveProfile(context) async {
    loadOverlay = OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(loadOverlay);
    Map<String, dynamic> _profileMap = profileEdit.cast();
    // print("_profileMap: $_profileMap");
    await FirebaseFirestore.instance
        .collection('agents')
        .doc(mainStore.authStore.user!.uid)
        .update(_profileMap);
    await setProfileEditFromDoc();
    loadOverlay.remove();
    profileEdit.clear();
    Modular.to.pop();
  }

  @action
  Future<void> setTokenLogout() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('user token: $token');
    DocumentSnapshot _user = await FirebaseFirestore.instance
        .collection('agents')
        .doc(mainStore.authStore.user!.uid)
        .get();

    List tokens = _user['token_id'];
    print('tokens length: ${tokens.length}');

    for (var i = 0; i < tokens.length; i++) {
      if (tokens[i] == token) {
        print('has $token');
        tokens.removeAt(i);
        print('tokens: $tokens');
      }
    }
    print('tokens2: $tokens');
    _user.reference.update({'token_id': tokens});
  }

  @action
  Future<DocumentSnapshot> getAdsDoc(String orderId) async{
    QuerySnapshot orderAdsQuery = await FirebaseFirestore.instance.collection('orders').doc(orderId).collection('ads').get();

    DocumentSnapshot adsDoc = await FirebaseFirestore.instance.collection('ads').doc(orderAdsQuery.docs.first.id).get();

    return adsDoc;
  }

  @action
  Future<void> answerRating(String ratingId, String answer, BuildContext context) async {
    print('answerRating ratingId: $ratingId');
    OverlayEntry? overlayEntry;
    overlayEntry =
      OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(overlayEntry);

    User? _user = FirebaseAuth.instance.currentUser;

    print("_user ${_user!.uid}");
    
    await FirebaseFirestore.instance.collection("agents").doc(_user.uid).collection('ratings').doc(ratingId).update({
      "answered": true,
      "answer": answer,
    });

    await FirebaseFirestore.instance.collection('ratings').doc(ratingId).update({
      "answered": true,
      "answer": answer,
    });
    print('after update');

    Modular.to.pop();
    overlayEntry.remove();    
    overlayEntry = null;
  }
}
