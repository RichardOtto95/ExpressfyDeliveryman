import 'package:delivery_emissary/app/modules/address/address_module.dart';
import 'package:delivery_emissary/app/modules/home/home_module.dart';
import 'package:delivery_emissary/app/modules/main/main_module.dart';
import 'package:delivery_emissary/app/modules/main/main_store.dart';
import 'package:delivery_emissary/app/modules/messages/messages_module.dart';
import 'package:delivery_emissary/app/modules/orders/orders_module.dart';
import 'package:delivery_emissary/app/modules/payment/payment_module.dart';
import 'package:delivery_emissary/app/modules/profile/profile_module.dart';
import 'package:delivery_emissary/app/modules/sign/sign_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../modules/support/widgets/support_chat.dart';
import 'root_page.dart';
import 'root_store.dart';

class RootModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RootStore()),
    Bind.lazySingleton((i) => MainStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => RootPage()),
    ModuleRoute('/orders', module: OrdersModule()),
    ModuleRoute('/address', module: AddressModule()),
    ModuleRoute('/main', module: MainModule()),
    ModuleRoute('/sign', module: SignModule()),
    ModuleRoute('/profile', module: ProfileModule()),
    ModuleRoute('/messages', module: MessagesModule()),
    ModuleRoute('/payment', module: PaymentModule()),
    ModuleRoute('/home', module: HomeModule()),
    ChildRoute('/support-chat', child: (_, args) => SupportChat()),
  ];
}
