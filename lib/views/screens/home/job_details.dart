import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/bookmark_provider.dart';
import '../../../controllers/jobs_provider.dart';
import '../../../controllers/login_provider.dart';
import '../../../models/response/bookmarks/book_res.dart';
import '../../../models/response/jobs/get_job.dart';
import '../../../services/helpers/jobs_helper.dart';
import '../../common/BackBtn.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/custom_outline_btn.dart';
import '../../common/height_spacer.dart';
import '../../common/loader.dart';
import '../../common/pages_loader.dart';
import '../../common/reusable_text.dart';
import '../../common/styled_container.dart';
import '../auth/login_page.dart';

class JobDetails extends StatefulWidget {
  const JobDetails(
      {super.key,
      required this.title,
      required this.id,
      required this.agentName});
  final String title;
  final String id;
  final String agentName;

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  late Future<GetJobRes> job;
  @override
  void initState() {
    getJob();
    super.initState();
  }

  getJob() {
    job = JobsHelper.getJob(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: 'Job Details',
              actions: [
                loginNotifier.loggedIn == true
                    ? Consumer<BookNotifier>(
                        builder: (context, bookNotifier, child) {
                        bookNotifier.getBookmark(widget.id);
                        return GestureDetector(
                          onTap: () {
                            if (bookNotifier.bookmark == true) {
                              bookNotifier
                                  .deleteBookmark(bookNotifier.bookmarkId);
                            } else {
                              BookMarkReqRes model =
                                  BookMarkReqRes(job: widget.id);
                              var newModel = bookMarkReqResToJson(model);
                              bookNotifier.addBookmark(newModel);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: Icon(bookNotifier.bookmark == false
                                ? Fontisto.bookmark
                                : Fontisto.bookmark_alt),
                          ),
                        );
                      })
                    : const SizedBox.shrink()
              ],
              child: const BackBtn(),
            ),
          ),
          body: buildStyleContainer(
            showImage: true,
            context,
            FutureBuilder<GetJobRes>(
              future: job,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const PageLoader();
                } else if (snapshot.hasError) {
                  return NoSearchResults(text: 'Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final job = snapshot.data;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Stack(
                      children: [
                        ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Container(
                              width: width,
                              height: hieght * 0.27,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9.w),
                                  color: Color(kLightGrey.value),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/jobs.png',
                                      ),
                                      opacity: 0.35)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30.w,
                                    backgroundImage:
                                        NetworkImage(job!.imageUrl),
                                  ),
                                  const HeightSpacer(size: 10),
                                  ReusableText(
                                      text: job.title,
                                      style: appStyle(16, Color(kDark.value),
                                          FontWeight.w600)),
                                  HeightSpacer(size: 5.w),
                                  ReusableText(
                                      text: job.location,
                                      style: appStyle(
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.w600)),
                                  HeightSpacer(size: 15.w),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                            horizontal: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomOutlineBtn(
                                            width: width * 0.26,
                                            hieght: hieght * 0.04,
                                            text: job.contract,
                                            color: Color(kOrange.value)),
                                        SizedBox(
                                          width: width * 0.4,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  job.salary,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: appStyle(
                                                      16,
                                                      Color(kDark.value),
                                                      FontWeight.w600),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '/${job.period}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: appStyle(
                                                      16,
                                                      Color(kDarkGrey.value),
                                                      FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            HeightSpacer(size: 20.w),
                            ReusableText(
                                text: 'Description',
                                style: appStyle(
                                    16, Color(kDark.value), FontWeight.w600)),
                            const HeightSpacer(size: 10),
                            Text(
                              job.description,
                              style: appStyle(
                                  12, Color(kDarkGrey.value), FontWeight.w500),
                            ),
                            HeightSpacer(size: 20.w),
                            ReusableText(
                                text: 'Requirements',
                                style: appStyle(
                                    16, Color(kDark.value), FontWeight.w600)),
                            const HeightSpacer(size: 10),
                            SizedBox(
                              height: hieght * 0.6,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: job.requirements.length,
                                  itemBuilder: (context, index) {
                                    String requirement =
                                        job.requirements[index];
                                    String bullet = '\u2022';
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 8.0.w),
                                      child: Text(
                                        "$bullet $requirement",
                                        style: appStyle(
                                            12,
                                            Color(kDarkGrey.value),
                                            FontWeight.normal),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.w),
                            child: CustomOutlineBtn(
                              onTap: () {
                                if (!loginNotifier.loggedIn) {
                                  Get.to(() => const LoginPage());
                                }
                              },
                              text: !loginNotifier.loggedIn == true
                                  ? "Please Login"
                                  : "Apply",
                              hieght: hieght * 0.06,
                              color: Color(kLight.value),
                              color2: Color(kOrange.value),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return const PageLoader();
              }),
            ),
          ),
        );
      },
    );
  }
}
