import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/color_theme.dart';
import '../../shared/utilities.dart';
import '../../shared/widgets/default_app_bar.dart';
import '../main/main_store.dart';
import 'notifications_store.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final MainStore mainStore = Modular.get();
  final NotificationsStore store = Modular.get();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        mainStore.setVisibleNav(true);
      } else {
        mainStore.setVisibleNav(false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    store.visualizedAllNotifications();
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: FutureBuilder(
                future: store.getNotifications(),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: maxHeight(context),
                      width: maxWidth(context),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  }

                  List newNotifications = snapshot.data![0];
                  List oldNotifications = snapshot.data![1];

                  if (newNotifications.isEmpty && oldNotifications.isEmpty) {
                    return Container(
                      height: maxHeight(context),
                      width: maxWidth(context),
                      alignment: Alignment.center,
                      child: Text("Nenhuma notificação, ainda..."),
                    );
                  }

                  return Column(
                    children: [
                      newNotifications.isEmpty
                          ? Container()
                          : Container(
                              padding: EdgeInsets.only(top: wXD(90, context)),
                              width: maxWidth(context),
                              color: primary.withOpacity(.06),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: wXD(16, context)),
                                    child: Text(
                                      'Novas',
                                      style: textFamily(
                                        fontSize: 17,
                                        color: darkGrey,
                                      ),
                                    ),
                                  ),
                                  ...newNotifications.map(
                                    (notification) => Notification(
                                      avatar: notification['sender_avatar'],
                                      text: notification['text'],
                                      timeAgo: store
                                          .getTime(notification['sended_at']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      oldNotifications.isEmpty
                          ? Container()
                          : Container(
                              padding: EdgeInsets.only(
                                top: newNotifications.isEmpty
                                    ? wXD(90, context)
                                    : wXD(14, context),
                              ),
                              width: maxWidth(context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: wXD(16, context)),
                                    child: Text(
                                      'Anteriores',
                                      style: textFamily(
                                        fontSize: 17,
                                        color: darkGrey,
                                      ),
                                    ),
                                  ),
                                  ...oldNotifications.map(
                                    (notification) => Notification(
                                      avatar: notification['sender_avatar'],
                                      text: notification['text'],
                                      timeAgo: store
                                          .getTime(notification['sended_at']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  );
                }),
          ),
          DefaultAppBar(
            'Notificações', 
            noPop: true,
          ),
        ],
      ),
    );
  }
}

class Notification extends StatelessWidget {
  final String text, timeAgo;
  final String? avatar;
  const Notification({
    Key? key,
    required this.text,
    required this.timeAgo,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wXD(101, context),
      width: maxWidth(context),
      padding: EdgeInsets.fromLTRB(
        wXD(32, context),
        wXD(21, context),
        wXD(30, context),
        wXD(20, context),
      ),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: darkGrey.withOpacity(.2))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: avatar == null
                ? Image.asset(
                    './assets/images/defaultUser.png',
                    fit: BoxFit.cover,
                    height: wXD(48, context),
                    width: wXD(48, context),
                  )
                : CachedNetworkImage(
                    imageUrl: avatar.toString(),
                    fit: BoxFit.cover,
                    height: wXD(48, context),
                    width: wXD(48, context),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        strokeWidth: 4,
                      ),
                    ),
                  ),
          ),
          Container(
            width: wXD(263, context),
            padding: EdgeInsets.only(left: wXD(15, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: textFamily(fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  timeAgo,
                  style: textFamily(color: Color(0xff8F9AA2)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
