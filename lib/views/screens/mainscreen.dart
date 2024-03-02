import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../controllers/zoom_provider.dart';
import '../common/drawer/drawerScreen.dart';
import 'auth/profile_page.dart';
import 'boomarks/bookmarkpage.dart';
import 'chat/chats_list.dart';
import 'home/homepage.dart';
import 'jobs/jobspage.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ZoomNotifier>(builder: (context, zoomNotifier, child) {
      return ZoomDrawer(
          menuScreen: DrawerScreen(indexSetter: (index) {
            zoomNotifier.currentIndex = index;
          }),
          borderRadius: 30,
          menuBackgroundColor: Color(kLightBlue.value),
          angle: 0.0,
          slideWidth: 230,
          mainScreen: currentScreen(context));
    }));
  }

  Widget currentScreen(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatList();
      case 2:
        return const BookmarkPage();
      case 3:
        return const AppliedJobs();
      case 4:
        return const ProfilePage(drawer: true);
      default:
        return const HomePage();
    }
  }
}
