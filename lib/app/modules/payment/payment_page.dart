import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:delivery_emissary/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_emissary/app/shared/widgets/side_button.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:delivery_emissary/app/modules/payment/payment_store.dart';
import 'package:flutter/material.dart';

import 'widgets/credit_card.dart';

class PaymentPage extends StatefulWidget {
  final String title;
  const PaymentPage({Key? key, this.title = 'PaymentPage'}) : super(key: key);
  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  final PaymentStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Observer(builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: wXD(97, context)),
                  Padding(
                    padding: EdgeInsets.only(
                      left: wXD(29, context),
                      bottom: wXD(17, context),
                    ),
                    child: Text(
                      'Meus cartões',
                      style: textFamily(
                        fontSize: 17,
                        color: darkGrey,
                      ),
                    ),
                  ),
                  Container(
                    width: maxWidth(context),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: wXD(6, context),
                        right: wXD(6, context),
                        bottom: wXD(22, context),
                      ),
                      scrollDirection: Axis.horizontal,
                      child: Observer(builder: (context) {
                        return Row(
                          children: [...store.cards.map((e) => CreditCard())],
                        );
                      }),
                    ),
                  ),
                  SideButton(
                    width: wXD(81, context),
                    onTap: () => Modular.to.pushNamed('/payment/add-card'),
                    child: Icon(
                      Icons.add_rounded,
                      size: wXD(30, context),
                      color: primary,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: wXD(22, context),
                      top: wXD(16, context),
                      bottom: wXD(8, context),
                    ),
                    child: Text(
                      'Histórico',
                      style: textFamily(
                        fontSize: 17,
                        color: darkGrey,
                      ),
                    ),
                  ),
                  ...store.cards.map((e) => Transaction())
                ],
              );
            }),
          ),
          DefaultAppBar('Pagamento'),
        ],
      ),
    );
  }
}

class Transaction extends StatelessWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wXD(56, context),
      width: maxWidth(context),
      margin: EdgeInsets.symmetric(horizontal: wXD(22, context)),
      padding: EdgeInsets.only(top: wXD(13, context), bottom: wXD(8, context)),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: darkGrey.withOpacity(.2)))),
      alignment: Alignment.topLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Transação realizada...',
            style: textFamily(
              fontSize: 15,
              color: grey,
            ),
          ),
          Column(
            children: [
              Text(
                '- R\$120,00',
                style: textFamily(
                  fontSize: 14,
                  color: grey,
                ),
              ),
              Text(
                '15 de Março',
                style: textFamily(
                  fontSize: 12,
                  color: darkGrey.withOpacity(.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
