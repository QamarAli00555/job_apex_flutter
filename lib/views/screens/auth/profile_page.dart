import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/login_provider.dart';
import '../../../controllers/zoom_provider.dart';
import '../../../models/response/auth/profile_model.dart';
import '../../../services/helpers/auth_helper.dart';
import '../../common/BackBtn.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/custom_outline_btn.dart';
import '../../common/drawer/drawer_widget.dart';
import '../../common/height_spacer.dart';
import '../../common/loader.dart';
import '../../common/pages_loader.dart';
import '../../common/reusable_text.dart';
import '../../common/styled_container.dart';
import '../../common/width_spacer.dart';
import '../jobs/add_job.dart';
import '../mainscreen.dart';
import 'non_user.dart';
import 'widget/skills_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.drawer});
  final bool drawer;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<ProfileRes>? userProfile;
  String username = '';
  ProfileRes? profileInfo;
  String profile = '';
  final String profileUrl =
      "https://img.freepik.com/premium-vector/anonymous-user-circle-icon-vector-illustration-flat-style-with-long-shadow_520826-1931.jpg?size=626&ext=jpg&ga=GA1.1.1391092918.1704647654&semt=ais";

  getProfile() async {
    var loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    if (widget.drawer == false && loginNotifier.loggedIn == true) {
      userProfile = AuthHelper.getProfile();
      profileInfo = await AuthHelper.getProfile();
    } else if (widget.drawer == true && loginNotifier.loggedIn == true) {
      userProfile = AuthHelper.getProfile();
      profileInfo = await AuthHelper.getProfile();
    }
  }

  getName() async {
    var loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (widget.drawer == false && loginNotifier.loggedIn == true) {
      username = prefs.getString('username') ?? '';
      profile = prefs.getString('profile') ?? '';
    } else if (widget.drawer == true && loginNotifier.loggedIn == true) {
      username = prefs.getString('username') ?? '';
      profile = prefs.getString('profile') ?? '';
    }
  }

  @override
  void initState() {
    getProfile();
    getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
        backgroundColor:
            loginNotifier.loggedIn == false ? null : Color(kNewBlue.value),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
              color: loginNotifier.loggedIn == false
                  ? null
                  : Color(kNewBlue.value),
              text: loginNotifier.loggedIn ? username : '',
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: widget.drawer == false
                    ? const BackBtn()
                    : DrawerWidget(color: Color(kLight.value)),
              )),
        ),
        body: loginNotifier.loggedIn == false
            ? const NonUser()
            : Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5),
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Color(kLightBlue.value)),
                      child: profileInfo == null
                          ? Animate(
                              effects: [
                                ShimmerEffect(
                                    curve: Curves.easeInBack,
                                    duration: const Duration(seconds: 7),
                                    colors: [
                                      Color(kLightGrey.value),
                                      Color(kLightBlue.value),
                                      Color(kLightGrey.value),
                                    ]),
                              ],
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 10.h),
                                height: hieght * 0.15,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Color(kLightGrey.value),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularAvatar(
                                    imgUrl: profileInfo!.profile ?? profileUrl,
                                    w: 60,
                                    h: 60),
                                const WidthSpacer(width: 8),
                                SizedBox(
                                  width: width * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                          text: profileInfo!.username,
                                          style: appStyle(
                                              18,
                                              Color(kLight.value),
                                              FontWeight.w400)),
                                      Text(
                                        profileInfo!.email,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: kLightGrey),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Feather.edit,
                                      color: kLight,
                                    ))
                              ],
                            ),
                    ),
                  ),
                  Positioned(
                    top: 95.h,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Color(kLight.value)),
                      child: FutureBuilder<ProfileRes>(
                          future: userProfile,
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const PageLoader();
                            } else if (snapshot.hasError) {
                              return const NoSearchResults(
                                  text: 'Profile info not found');
                            } else if (snapshot.hasData) {
                              profileInfo = snapshot.data;
                              return buildStyleContainer(
                                  context,
                                  ListView(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.h),
                                    children: [
                                      const HeightSpacer(size: 20),
                                      ReusableText(
                                          text: "Profile",
                                          style: appStyle(
                                              14, kDark, FontWeight.w600)),
                                      const HeightSpacer(size: 10),
                                      Stack(
                                        children: [
                                          Container(
                                            width: width,
                                            height: hieght * 0.12,
                                            decoration: BoxDecoration(
                                              color: Color(kLightGrey.value),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 12.w),
                                                  width: 60.w,
                                                  height: 70.h,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(kLight.value),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: const Icon(
                                                    FontAwesome5Regular
                                                        .file_pdf,
                                                    color: Colors.red,
                                                    size: 40,
                                                  ),
                                                ),
                                                const WidthSpacer(width: 20),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ReusableText(
                                                        text:
                                                            'Upload Your Resume',
                                                        style: appStyle(
                                                            16,
                                                            Color(kDark.value),
                                                            FontWeight.w500)),
                                                    FittedBox(
                                                      child: Text(
                                                          'Please make sure to upload resume in PDF format',
                                                          style: appStyle(
                                                              8,
                                                              Color(kDarkGrey
                                                                  .value),
                                                              FontWeight.w500)),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(kOrange.value),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(9),
                                                    bottomLeft:
                                                        Radius.circular(9),
                                                  ),
                                                ),
                                                child: ReusableText(
                                                    text: "  Edit  ",
                                                    style: appStyle(
                                                        12,
                                                        Color(kLight.value),
                                                        FontWeight.w500)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const HeightSpacer(size: 20),
                                      const SkillWidget(),
                                      const HeightSpacer(size: 20),
                                      !profileInfo!.isAgent
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                    text: "Agent Section",
                                                    style: appStyle(14, kDark,
                                                        FontWeight.w600)),
                                                const HeightSpacer(size: 20),
                                                CustomOutlineBtn(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          const AddJobs());
                                                    },
                                                    width: width,
                                                    hieght: 40.h,
                                                    text: 'Add Jobs',
                                                    color:
                                                        Color(kNewBlue.value)),
                                                const HeightSpacer(size: 20),
                                                CustomOutlineBtn(
                                                    onTap: () {},
                                                    width: width,
                                                    hieght: 40.h,
                                                    text: 'Update Information',
                                                    color:
                                                        Color(kNewBlue.value)),
                                              ],
                                            )
                                          : CustomOutlineBtn(
                                              onTap: () {},
                                              width: width,
                                              hieght: 40.h,
                                              text: 'Apply to become and Agent',
                                              color: Color(kOrange.value)),
                                      const HeightSpacer(size: 20),
                                      CustomOutlineBtn(
                                          onTap: () {
                                            zoomNotifier.currentIndex = 0;
                                            loginNotifier.logout();
                                            Get.to(() => const Mainscreen());
                                          },
                                          width: width,
                                          hieght: 40.h,
                                          text: 'Proceed to Logout',
                                          color: Color(kOrange.value))
                                    ],
                                  ));
                            } else {
                              return const NoSearchResults(
                                  text: 'Profile info not found');
                            }
                          })),
                    ),
                  ),
                ],
              ));
  }
}

class CircularAvatar extends StatelessWidget {
  const CircularAvatar(
      {super.key, required this.imgUrl, required this.w, required this.h});
  final String imgUrl;
  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(99.w),
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        width: w,
        height: h,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
