import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_apex/controllers/bookmark_provider.dart';
import 'package:job_apex/views/common/styled_container.dart';
import 'package:job_apex/views/screens/boomarks/widgets/bookmark_tile.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/login_provider.dart';
import '../../../models/response/bookmarks/all_bookmarks.dart';
import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';
import '../../common/pages_loader.dart';
import '../auth/non_user.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
        backgroundColor:
            loginNotifier.loggedIn == false ? null : Color(kNewBlue.value),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: CustomAppBar(
              color: loginNotifier.loggedIn == false
                  ? null
                  : Color(kNewBlue.value),
              text: !loginNotifier.loggedIn ? "" : "Bookmarks",
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: DrawerWidget(color: Color(kDark.value)),
              )),
        ),
        body: loginNotifier.loggedIn == false
            ? const NonUser()
            : Consumer<BookNotifier>(
                builder: (context, bookNotifier, child) {
                  bookNotifier.getBookmarks();

                  Future<List<AllBookMarks>> bookmarks =
                      bookNotifier.getBookmarks();
                  return Stack(
                    children: [
                      Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.w),
                                    topLeft: Radius.circular(20.w)),
                                color: Color(kGreen.value)),
                            child: buildStyleContainer(
                                showImage: true,
                                context,
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: FutureBuilder(
                                      future: bookmarks,
                                      builder: (((context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const PageLoader();
                                        } else if (snapshot.hasError) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 40.h),
                                            alignment: Alignment.center,
                                            width: width,
                                            height: hieght * 0.3,
                                            child: Image.asset(
                                                "assets/images/optimized_search.png"),
                                          );
                                        } else if (snapshot.data!.isEmpty) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                                alignment: Alignment.center,
                                                width: width,
                                                height: hieght * 0.3,
                                                child: Image.asset(
                                                    "assets/images/optimized_search.png"),
                                              ),
                                              const Text('No Bookmark Found'),
                                            ],
                                          );
                                        } else {
                                          return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              var bookmark =
                                                  snapshot.data![index];
                                              return BookmarkTile(
                                                  bookmark: bookmark);
                                            },
                                          );
                                        }
                                      }))),
                                )),
                          ))
                    ],
                  );
                },
              ));
  }
}
