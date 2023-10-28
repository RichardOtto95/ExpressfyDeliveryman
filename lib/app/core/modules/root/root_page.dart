import 'package:delivery_emissary/app/core/modules/root/root_store.dart';
import 'package:delivery_emissary/app/modules/main/main_module.dart';
import 'package:delivery_emissary/app/modules/sign/widgets/on_boarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  final RootStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    print(
        'FirebaseAuth.instance.currentUser != null ?? ${FirebaseAuth.instance.currentUser != null}');
    if (FirebaseAuth.instance.currentUser != null) {
      return MainModule();
    } else {
      return OnBoarding();
    }
  }
}
