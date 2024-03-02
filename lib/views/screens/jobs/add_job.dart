import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_apex/services/helpers/jobs_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/skills_provider.dart';
import '../../../controllers/zoom_provider.dart';
import '../../../models/request/jobs/create_job.dart';
import '../../common/BackBtn.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/custom_outline_btn.dart';
import '../../common/custom_textfield.dart';
import '../../common/height_spacer.dart';
import '../../common/pages_loader.dart';
import '../../common/reusable_text.dart';
import '../../common/styled_container.dart';
import '../auth/profile_page.dart';
import '../mainscreen.dart';

class AddJobs extends StatefulWidget {
  const AddJobs({super.key});

  @override
  State<AddJobs> createState() => _AddJobsState();
}

class _AddJobsState extends State<AddJobs> {
  TextEditingController title = TextEditingController();
  TextEditingController comapny = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController period = TextEditingController();
  TextEditingController contract = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
  TextEditingController req1 = TextEditingController();
  TextEditingController req2 = TextEditingController();
  TextEditingController req3 = TextEditingController();
  TextEditingController req4 = TextEditingController();
  TextEditingController req5 = TextEditingController();
  final String profileUrl =
      "https://img.freepik.com/premium-vector/anonymous-user-circle-icon-vector-illustration-flat-style-with-long-shadow_520826-1931.jpg?size=626&ext=jpg&ga=GA1.1.1391092918.1704647654&semt=ais";

  @override
  Widget build(BuildContext context) {
    var skillsNotifier = Provider.of<SkillsNotifier>(context);
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    return Scaffold(
      backgroundColor: kNewBlue,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.w),
        child: CustomAppBar(actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularAvatar(imgUrl: profileUrl, w: 30, h: 30),
          )
        ], text: 'Upload Jobs', color: kNewBlue, child: const BackBtn()),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Color(kLight.value)),
                child: skillsNotifier.loader
                    ? const PageLoader()
                    : buildStyleContainer(
                        showImage: true,
                        context,
                        Form(
                          key: skillsNotifier.createJobFormKey,
                          child: ListView(
                            children: [
                              const HeightSpacer(size: 20),
                              FieldArea(controller: title, hintText: 'Tilte'),
                              FieldArea(
                                  controller: comapny, hintText: 'Company'),
                              FieldArea(
                                  controller: location, hintText: 'Location'),
                              FieldArea(
                                  controller: salary,
                                  hintText: 'Expacted Slaary'),
                              FieldArea(controller: period, hintText: 'Period'),
                              FieldArea(
                                  controller: contract, hintText: 'Contract'),
                              FieldArea(
                                  controller: description,
                                  hintText: 'Description'),
                              Consumer<SkillsNotifier>(
                                  builder: (context, skillsNotifier, child) {
                                return SizedBox(
                                  width: width,
                                  height: 95,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.8,
                                        height: 95,
                                        child: FieldArea(
                                            controller: imageUrl,
                                            hintText: 'Image URL'),
                                      ),
                                      skillsNotifier.addLogoURL == ''
                                          ? IconButton(
                                              onPressed: () {
                                                skillsNotifier.setLogoURL =
                                                    imageUrl.text.toString();
                                              },
                                              icon: const Icon(
                                                Entypo.upload_to_cloud,
                                                size: 35,
                                                color: kNewBlue,
                                              ))
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircularAvatar(
                                                  imgUrl:
                                                      skillsNotifier.addLogoURL,
                                                  w: 35,
                                                  h: 35),
                                            )
                                    ],
                                  ),
                                );
                              }),
                              const HeightSpacer(size: 20),
                              ReusableText(
                                  text: "Requirements",
                                  style: appStyle(14, kDark, FontWeight.w600)),
                              const HeightSpacer(size: 10),
                              FieldArea(
                                  controller: req1, hintText: 'Requirement 1'),
                              FieldArea(
                                  controller: req2, hintText: 'Requirement 2'),
                              FieldArea(
                                  controller: req3, hintText: 'Requirement 3'),
                              FieldArea(
                                  controller: req4, hintText: 'Requirement 4'),
                              FieldArea(
                                  controller: req5, hintText: 'Requirement 5'),
                              CustomOutlineBtn(
                                  onTap: () async {
                                    // Check if any of the fields is empty
                                    if (title.text.isEmpty ||
                                        location.text.isEmpty ||
                                        comapny.text.isEmpty ||
                                        description.text.isEmpty ||
                                        salary.text.isEmpty ||
                                        period.text.isEmpty ||
                                        contract.text.isEmpty ||
                                        req1.text.isEmpty ||
                                        req2.text.isEmpty) {
                                      Get.snackbar('Invalid Submission',
                                          'Please fill all required fields',
                                          colorText: Color(kLight.value),
                                          backgroundColor: Colors.redAccent,
                                          icon: const Icon(
                                            Ionicons.alert,
                                            color: kLight,
                                          ));
                                    } else {
                                      // If all fields are filled, proceed with form submission

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      String agentName =
                                          prefs.getString("username") ?? "";
                                      CreateJobsRequest tempModel =
                                          CreateJobsRequest(
                                        title: title.text.toString(),
                                        location: location.text.toString(),
                                        company: comapny.text.toString(),
                                        hiring: true,
                                        description:
                                            description.text.toString(),
                                        salary: salary.text.toString(),
                                        period: period.text.toString(),
                                        contract: contract.text.toString(),
                                        imageUrl: skillsNotifier.addLogoURL,
                                        agentId: userUid,
                                        agentName: agentName,
                                        requirements: [
                                          req1.text,
                                          req2.text,
                                          req3.text,
                                          req4.text,
                                          req5.text,
                                        ],
                                      );

                                      var model =
                                          createJobsRequestToJson(tempModel);
                                      JobsHelper.createJob(model);
                                      zoomNotifier.currentIndex = 0;
                                      Get.to(() => const Mainscreen());
                                    }
                                  },
                                  width: width,
                                  hieght: 40.h,
                                  text: 'Submit',
                                  color: Color(kNewBlue.value)),
                            ],
                          ),
                        )),
              ))
        ],
      ),
    );
  }
}

class FieldArea extends StatelessWidget {
  const FieldArea(
      {super.key,
      required this.controller,
      required this.hintText,
      this.inputType = TextInputType.text});
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          color: 1,
          controller: controller,
          hintText: hintText,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return "This field is required";
            }
            return null;
          },
        ),
        const HeightSpacer(size: 10),
      ],
    );
  }
}
