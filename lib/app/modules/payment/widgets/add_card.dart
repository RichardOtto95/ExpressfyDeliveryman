import 'package:delivery_emissary/app/modules/payment/widgets/credit_card.dart';
import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:delivery_emissary/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_emissary/app/shared/widgets/side_button.dart';
import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: maxWidth(context),
                  padding: EdgeInsets.only(
                    top: wXD(96, context),
                    bottom: wXD(30, context),
                  ),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(60)),
                      color: totalBlack),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      CreditCard(width: wXD(257, context)),
                      SizedBox(height: wXD(33, context)),
                      Row(
                        children: [
                          SizedBox(width: wXD(41, context)),
                          Column(
                            children: [
                              CardField(
                                title: 'Número do cartão',
                                data: '9999 9999 9999 9999',
                              ),
                              SizedBox(height: wXD(23, context)),
                              CardField(
                                title: 'Nome do titular do cartão',
                                data: 'Lorem ipsum',
                              ),
                            ],
                          ),
                          SizedBox(width: wXD(23, context)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CardField(
                                width: wXD(81, context),
                                title: 'Data de vencimento',
                                data: '99/99',
                              ),
                              SizedBox(height: wXD(23, context)),
                              CardField(
                                width: wXD(81, context),
                                title: 'CVC',
                                data: '999',
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: wXD(40, context),
                    top: wXD(31, context),
                  ),
                  child: Text('Endereço de cobrança',
                      style: textFamily(
                        fontSize: 17,
                        color: darkGrey,
                      )),
                ),
                BillingAddress(field: 'Estado'),
                BillingAddress(field: 'Cidade'),
                BillingAddress(field: 'Endereço'),
                BillingAddress(field: 'CEP'),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    wXD(40, context),
                    wXD(12, context),
                    wXD(40, context),
                    wXD(38, context),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Cartão principal',
                        style: textFamily(
                          fontSize: 14,
                          color: blue,
                        ),
                      ),
                      Spacer(),
                      Switch(value: false, onChanged: (change) {}),
                    ],
                  ),
                ),
                SideButton(
                  onTap: () {},
                  title: 'Adicionar',
                  width: wXD(142, context),
                  height: wXD(52, context),
                ),
                SizedBox(height: wXD(20, context))
              ],
            ),
          ),
          DefaultAppBar('Adicionar cartão'),
        ],
      ),
    );
  }
}

class CardField extends StatelessWidget {
  final double? width;
  final String title, data;
  CardField({this.width, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textFamily(fontSize: 12, color: grey)),
        Container(
          width: width ?? wXD(160, context),
          height: wXD(31, context),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color(0xff998FA2).withOpacity(.4),
                      width: wXD(.5, context)))),
          alignment: Alignment.centerLeft,
          child: TextField(
            decoration: InputDecoration.collapsed(
                hintText: data, hintStyle: textFamily(color: white)),
          ),
        )
      ],
    );
  }
}

class BillingAddress extends StatelessWidget {
  final String field;
  BillingAddress({required this.field});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: wXD(43, context),
      width: maxWidth(context),
      padding: EdgeInsets.only(bottom: wXD(12, context)),
      margin: EdgeInsets.fromLTRB(
        wXD(40, context),
        wXD(0, context),
        wXD(40, context),
        wXD(25, context),
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: grey.withOpacity(.4)))),
      alignment: Alignment.bottomLeft,
      child: TextField(
        decoration: InputDecoration.collapsed(
            hintText: field,
            hintStyle: textFamily(fontSize: 14, color: grey.withOpacity(.7))),
      ),
    );
  }
}
