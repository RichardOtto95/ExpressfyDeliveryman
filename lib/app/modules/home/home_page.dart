import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_emissary/app/modules/home/home_store.dart';
import 'package:delivery_emissary/app/modules/main/main_store.dart';
import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/black_app_bar.dart';
import 'widgets/home_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore>
    with SingleTickerProviderStateMixin {
  final MainStore mainStore = Modular.get();
  int selected = 0;

  // ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: mainStore.mainScrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: viewPaddingTop(context) + wXD(60, context),
                    width: maxWidth(context)),
                Observer(
                  builder: (context) {
                    if (mainStore.agentMap.isNotEmpty &&
                        mainStore.agentMap["mission_in_progress"] != null) {
                      return SeeRoute(
                        onTap: () async {
                          mainStore.missionInProgressOrderDoc =
                              FirebaseFirestore.instance
                                  .collection("agents")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("orders")
                                  .doc(mainStore
                                      .agentMap["mission_in_progress"]);
                          // QuerySnapshot ordersAccepted = await FirebaseFirestore.instance
                          //   .collection("agents")
                          //   .doc(FirebaseAuth.instance.currentUser!.uid)
                          //   .collection("orders")
                          //   .where('status', whereIn: ['DELIVERY_ACCEPTED', 'SENDED'])
                          //   .get();
                          await Future.delayed(
                            Duration(seconds: 1),
                            () => mainStore.setPage(2),
                          );
                          await Future.delayed(
                            Duration(milliseconds: 200),
                            () async => await Modular.to.pushNamed(
                              "orders/mission-in-progress",
                              arguments: mainStore.missionInProgressOrderDoc.id,
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
                HomeCard(),
                Padding(
                  padding: EdgeInsets.only(
                    left: wXD(16, context),
                    top: wXD(12, context),
                    bottom: wXD(16, context),
                  ),
                  child: Text(
                    'Operações/Estatísticas',
                    style: textFamily(
                      fontSize: 17,
                      color: textTotalBlack,
                    ),
                  ),
                ),
                Period(
                  onToday: () => setState(() => selected = 0),
                  onWeek: () => setState(() => selected = 1),
                  onMonth: () => setState(() => selected = 2),
                  selected: selected,
                ),
                FutureBuilder<List>(
                    future: store.getStatistics(selected),
                    builder: (context, snapshot) {
                      print('snapshot.hasError: ${snapshot.hasError}');
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      if (snapshot.hasData) {
                        print(snapshot.data);
                      }
                      return PerformanceCard(
                        values: snapshot.data,
                      );
                    }),
                SizedBox(height: wXD(90, context), width: maxWidth(context)),
              ],
            ),
          ),
          BlackAppBar(),
        ],
      ),
    );
  }
}

class SeeRoute extends StatelessWidget {
  final void Function()? onTap;
  const SeeRoute({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: wXD(56, context),
              width: wXD(343, context),
              margin: EdgeInsets.symmetric(vertical: wXD(24, context)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Color(0xfffff4e4),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    offset: Offset(0, 3),
                    color: totalBlack.withOpacity(.2),
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rota em andamento',
                    style: textFamily(
                      fontSize: 14,
                      color: primary,
                    ),
                  ),
                  SizedBox(height: wXD(4, context)),
                  Text(
                    'Ver rota em andamento',
                    style: textFamily(
                      fontSize: 10,
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: wXD(12, context),
            child: Icon(
              Icons.arrow_forward_rounded,
              size: wXD(30, context),
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}

class PerformanceCard extends StatelessWidget {
  List? values;
  PerformanceCard({Key? key, this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(17, 21, 0, 7),
          child: Text(
            "Sua atividade hoje",
            style: textFamily(fontSize: 12),
          ),
        ),
        Center(
          child: Container(
            // height: wXD(179, context),
            height: wXD(110, context),
            width: wXD(362, context),
            padding: EdgeInsets.symmetric(
                horizontal: wXD(8, context), vertical: wXD(10, context)),
            decoration: BoxDecoration(
              border: Border.all(color: veryLightGrey.withOpacity(.3)),
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 3),
                    color: totalBlack.withOpacity(.1))
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PerformanceData(
                        qtd: values == null ? 0 : values![0],
                        title: "Pedidos entregues"),
                    PerformanceData(
                        qtd: values == null ? 0 : values![1],
                        title: "Ofertas aceitas"),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     PerformanceData(qtd: 2, title: "Pedidos entregues"),
                //     PerformanceData(qtd: 1, title: "Ofertas aceitas"),
                //   ],
                // ),
                InkWell(
                  onTap: () => Modular.to.pushNamed("/home/full-performance"),
                  child: Container(
                    height: wXD(28, context),
                    width: wXD(332, context),
                    padding: EdgeInsets.only(
                      left: wXD(2, context),
                      right: wXD(13, context),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: grey.withOpacity(.3)))),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Text(
                          "Ver desempenho completo",
                          style: textFamily(
                            color: primary,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          color: primary,
                          size: wXD(20, context),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PerformanceData extends StatelessWidget {
  final int qtd;
  final String title;

  const PerformanceData({Key? key, required this.qtd, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wXD(162, context),
      // height: wXD(56, context),
      padding: EdgeInsets.only(top: wXD(8, context), bottom: wXD(7, context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(17)),
        border: Border.all(color: primary.withOpacity(.4)),
      ),
      child: Column(
        children: [
          Text(
            qtd.toString(),
            style: textFamily(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: primary,
            ),
          ),
          Text(
            title,
            style: textFamily(
              fontWeight: FontWeight.w400,
              color: Color(0xff4D4D4D),
            ),
          ),
        ],
      ),
    );
  }
}

class Period extends StatelessWidget {
  final void Function() onToday;
  final void Function() onWeek;
  final void Function() onMonth;
  final int selected;

  Period(
      {required this.onToday,
      required this.onWeek,
      required this.onMonth,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: wXD(40, context),
        width: wXD(342, context),
        decoration: BoxDecoration(
          border: Border.all(color: totalBlack, width: wXD(1.6, context)),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            Spacer(),
            GestureDetector(
              onTap: onToday,
              child: Text(
                'Hoje',
                style: textFamily(
                  fontSize: 16,
                  color: selected == 0 ? primary : textTotalBlack,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Spacer(),
            Container(
              height: wXD(40, context),
              width: wXD(150, context),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: totalBlack,
                    width: wXD(2, context),
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: onWeek,
                child: Text(
                  'Semana',
                  style: textFamily(
                    fontSize: 16,
                    color: selected == 1 ? primary : textTotalBlack,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: onMonth,
              child: Text(
                'Mês',
                style: textFamily(
                  fontSize: 16,
                  color: selected == 2 ? primary : textTotalBlack,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
