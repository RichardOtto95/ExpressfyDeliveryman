import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'dart:math' as math;
import '../advertisement_store.dart';

class AnnouncementDetails extends StatefulWidget {
  AnnouncementDetails({Key? key}) : super(key: key);

  @override
  _AnnouncementDetailsState createState() => _AnnouncementDetailsState();
}

class _AnnouncementDetailsState extends State<AnnouncementDetails> {
  final AdvertisementStore store = Modular.get();

  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter(symbol: 'R\$');

  FocusNode titleFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    print('isEditing: ${store.editingAd}');
    return Observer(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: wXD(17, context), bottom: wXD(9, context)),
            child: Text('Título do anúncio*',
                style: textFamily(
                  fontSize: 15,
                  color: totalBlack,
                )),
          ),
          Center(
            child: Container(
              height: wXD(52, context),
              width: wXD(342, context),
              decoration: BoxDecoration(
                color: white,
                border: Border.all(color: primary),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              padding: EdgeInsets.symmetric(horizontal: wXD(12, context)),
              child: TextFormField(
                initialValue: store.editingAd
                    ? store.adEdit.title
                    : store.announcementTitle,
                focusNode: titleFocus,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Escreva um título válido';
                  }
                  return null;
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Ex: Samsung Galaxy S9',
                ),
                onChanged: (val) {
                  print('title: $val');
                  store.editingAd
                      ? store.adEdit.title = val
                      : store.setAnnouncementTitle(val);
                },
                onEditingComplete: () => descriptionFocus.requestFocus(),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: wXD(35, context),
                left: wXD(17, context),
                bottom: wXD(9, context)),
            child: Text('Descrição*',
                style: textFamily(
                  fontSize: 15,
                  color: totalBlack,
                )),
          ),
          Center(
            child: Container(
              height: wXD(123, context),
              width: wXD(342, context),
              decoration: BoxDecoration(
                color: white,
                border: Border.all(color: primary),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: wXD(12, context),
                vertical: wXD(20, context),
              ),
              alignment: Alignment.topLeft,
              child: TextFormField(
                initialValue: store.editingAd
                    ? store.adEdit.description
                    : store.announcementDescription,
                focusNode: descriptionFocus,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Escreva uma descrição válida';
                  }
                  return null;
                },
                maxLines: 5,
                decoration: InputDecoration.collapsed(
                  hintText:
                      'Ex: Samsung Galaxy S9 com 128gb de memória, com caixa, todos os cabos e sem marca de uso.',
                  hintStyle:
                      textFamily(fontSize: 14, color: darkGrey.withOpacity(.7)),
                ),
                onChanged: (val) {
                  print('description: $val');
                  store.editingAd
                      ? store.adEdit.description = val
                      : store.setAnnouncementDescription(val);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: wXD(35, context),
                left: wXD(17, context),
                bottom: wXD(9, context)),
            child: Text(
              'Categoria*',
              style: textFamily(
                fontSize: 15,
                color: totalBlack,
              ),
            ),
          ),
          Center(
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              onTap: () =>
                  Modular.to.pushNamed('/advertisement/choose-category'),
              child: Container(
                height: wXD(52, context),
                width: wXD(342, context),
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: primary),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                padding: EdgeInsets.only(
                    left: wXD(12, context), right: wXD(15, context)),
                child: Row(
                  children: [
                    Observer(builder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store.editingAd
                                ? '${store.adEdit.category}        ${store.adEdit.option}'
                                : store.announcementCategory == ''
                                    ? 'Selecione uma categoria'
                                    : '${store.announcementCategory}        ${store.announcementOption}',
                            style: textFamily(
                                fontSize: 14, color: darkGrey.withOpacity(.7)),
                          ),
                          Visibility(
                            visible: store.categoryValidateVisible,
                            child: Text(
                              store.getCategoryValidateText(),
                              style: textFamily(
                                fontSize: 11,
                                color: Colors.red.shade400,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primary,
                      size: wXD(17, context),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: wXD(35, context),
                left: wXD(17, context),
                bottom: wXD(9, context)),
            child: Text('Tipo*',
                style: textFamily(
                  fontSize: 15,
                  color: totalBlack,
                )),
          ),
          Center(
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              onTap: () => store.setSearchType(true),
              child: Container(
                height: wXD(52, context),
                width: wXD(342, context),
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: primary),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                padding: EdgeInsets.only(
                    left: wXD(12, context), right: wXD(15, context)),
                child: Row(
                  children: [
                    Observer(builder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store.editingAd
                                ? store.adEdit.type
                                : store.announcementType == ''
                                    ? 'Selecione o tipo'
                                    : store.announcementType,
                            style: textFamily(
                                fontSize: 14, color: darkGrey.withOpacity(.7)),
                          ),
                          Visibility(
                            visible: store.typeValidateVisible,
                            child: Text(
                              'Selecione um tipo',
                              style: textFamily(
                                fontSize: 11,
                                color: Colors.red.shade400,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    Spacer(),
                    Transform.rotate(
                      angle: math.pi / 2,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primary,
                        size: wXD(17, context),
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: wXD(35, context),
                left: wXD(17, context),
                bottom: wXD(20, context)),
            child: Text('Novo/Usado*',
                style: textFamily(
                  fontSize: 15,
                  color: totalBlack,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Observer(
                builder: (
                  context,
                ) {
                  return GestureDetector(
                    onTap: () {
                      store.editingAd
                          ? setState(() {
                              store.adEdit.isNew = true;
                            })
                          : store.setAnnouncementIsNew(true);
                      print('STORE isNew ? ${store.announcementIsNew}');
                    },
                    child: Container(
                      height: wXD(32, context),
                      width: wXD(155, context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: store.editingAd
                            ? store.adEdit.isNew
                                ? primary
                                : white
                            : store.announcementIsNew
                                ? primary
                                : white,
                        border: Border.all(
                          color: store.editingAd
                              ? store.adEdit.isNew
                                  ? Colors.transparent
                                  : lightGrey.withOpacity(.8)
                              : store.announcementIsNew
                                  ? Colors.transparent
                                  : lightGrey.withOpacity(.8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            color: Color(0x30000000),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Novo',
                        style: textFamily(
                          color: store.editingAd
                              ? store.adEdit.isNew
                                  ? white
                                  : textTotalBlack
                              : store.announcementIsNew
                                  ? white
                                  : textTotalBlack,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Observer(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      store.editingAd
                          ? setState(() {
                              store.adEdit.isNew = false;
                            })
                          : store.setAnnouncementIsNew(false);
                      print('STORE isNew ? ${store.announcementIsNew}');
                    },
                    child: Container(
                      height: wXD(32, context),
                      width: wXD(155, context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: store.editingAd
                            ? !store.adEdit.isNew
                                ? primary
                                : white
                            : !store.announcementIsNew
                                ? primary
                                : white,
                        border: Border.all(
                          color: store.editingAd
                              ? !store.adEdit.isNew
                                  ? Colors.transparent
                                  : lightGrey.withOpacity(.8)
                              : !store.announcementIsNew
                                  ? Colors.transparent
                                  : lightGrey.withOpacity(.8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            color: Color(0x30000000),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Usado',
                        style: textFamily(
                          color: store.editingAd
                              ? !store.adEdit.isNew
                                  ? white
                                  : textTotalBlack
                              : !store.announcementIsNew
                                  ? white
                                  : textTotalBlack,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: wXD(35, context),
                left: wXD(17, context),
                bottom: wXD(9, context)),
            child: Text('Preço (R\$)',
                style: textFamily(
                  fontSize: 15,
                  color: totalBlack,
                )),
          ),
          Container(
            height: wXD(52, context),
            width: wXD(171, context),
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: primary),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            padding: EdgeInsets.symmetric(horizontal: wXD(12, context)),
            margin: EdgeInsets.only(left: wXD(17, context)),
            child: TextFormField(
              initialValue: store.editingAd
                  ? _formatter.format(store.adEdit.price.toString())
                  : store.announcementPrice == null
                      ? null
                      : _formatter.format(store.announcementPrice.toString()),
              inputFormatters: [_formatter],
              keyboardType: TextInputType.number,
              validator: (val) {
                print('val price: $val');
                if (val!.isEmpty) {
                  return 'Escreva um preço válido';
                }
                return null;
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Digite o seu preço',
              ),
              onChanged: (val) {
                print('price: ${_formatter.getUnformattedValue()}');
                store.editingAd
                    ? store.adEdit.price =
                        _formatter.getUnformattedValue().toDouble()
                    : store.setAnnouncementPrice(
                        val == '' ? null : _formatter.getUnformattedValue());
              },
            ),
            alignment: Alignment.centerLeft,
          ),
        ],
      );
    });
  }
}
