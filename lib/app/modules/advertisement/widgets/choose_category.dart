import 'package:delivery_emissary/app/modules/advertisement/advertisement_store.dart';
import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:delivery_emissary/app/shared/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChooseCategory extends StatelessWidget {
  final AdvertisementStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    List categories = [
      'Categoria 1',
      'Categoria 2',
      'Categoria 3',
      'Categoria 4',
      'Categoria 5',
      'Categoria 6',
      'Categoria 7',
      'Categoria 8',
      'Categoria 9',
    ];
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: wXD(77, context)),
                ...categories.map((e) => InkWell(
                      onTap: () async {
                        store.editingAd
                            ? store.adEdit.category = e
                            : store.setAnnouncementCategory(e);
                        await Modular.to.pushNamed('/advertisement/category');
                      },
                      child: Container(
                        width: maxWidth(context),
                        height: wXD(52, context),
                        margin:
                            EdgeInsets.symmetric(horizontal: wXD(23, context)),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: darkGrey.withOpacity(.2)))),
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e,
                              style: textFamily(
                                color: primary,
                                fontSize: 17,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: wXD(23, context),
                              color: primary,
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
          DefaultAppBar('Escolha uma categoria')
        ],
      ),
    );
  }
}
