import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_apex/controllers/chat_provider.dart';
import 'package:job_apex/views/common/exports.dart';
import 'package:job_apex/views/common/height_spacer.dart';
import 'package:job_apex/views/common/loader.dart';
import 'package:provider/provider.dart';

import '../../../controllers/login_provider.dart';
import '../../../models/response/chat/get_chat.dart';
import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';
import '../../common/pages_loader.dart';
import '../auth/non_user.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
              text: 'Chats',
              actions: const [
                // InkWell(
                //   onTap: () {
                //     Get.to(() => const ProfilePage(drawer: false));
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.all(12.h),
                //     child: ClipRRect(
                //       borderRadius: const BorderRadius.all(Radius.circular(50)),
                //       child: CachedNetworkImage(
                //         height: 35.w,
                //         width: 35.w,
                //         fit: BoxFit.cover,
                //         imageUrl:
                //             'https://img.freepik.com/free-photo/close-up-portrait-caucasian-unshaved-man-eyeglasses-looking-camera-with-sincere-smile-isolated-gray_171337-630.jpg?size=626&ext=jpg&ga=GA1.1.1391092918.1704647654&semt=ais',
                //       ),
                //     ),
                //   ),
                // )
              ],
              child: Padding(
                padding: EdgeInsets.all(12.h),
                child: DrawerWidget(color: Color(kDark.value)),
              )),
        ),
        body: loginNotifier.loggedIn == false
            ? const NonUser()
            : SizedBox(
                width: width,
                height: hieght,
                child: Consumer<ChatNotifier>(
                  builder: (context, chatNotifier, child) {
                    chatNotifier.getChats();
                    chatNotifier.getPrefs();
                    print(chatNotifier.userId);
                    return FutureBuilder<List<GetChats>>(
                      future: chatNotifier.chats,
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const PageLoader();
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('No Chats Found'));
                        } else if (snapshot.data!.isEmpty) {
                          return const NoSearchResults(
                            text: 'No Chats available',
                          );
                        } else {
                          final chats = snapshot.data;
                          return ListView.builder(
                            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                            itemCount: chats!.length,
                            itemBuilder: (context, index) {
                              final chat = chats[index];
                              var user = chat.users.where(
                                (user) => user.id != chatNotifier.userId,
                              );
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: width,
                                    height: hieght * 0.1,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      minLeadingWidth: 0,
                                      minVerticalPadding: 0,
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage(user.first.profile),
                                      ),
                                      title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ReusableText(
                                              text: user.first.username,
                                              style: appStyle(
                                                  16, kDark, FontWeight.w600)),
                                          const HeightSpacer(size: 5),
                                          ReusableText(
                                              text:
                                                  chat.latestMessage!.content ??
                                                      '',
                                              style: appStyle(16, kDarkGrey,
                                                  FontWeight.normal))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }),
                    );
                  },
                ),
              ));
  }
}
