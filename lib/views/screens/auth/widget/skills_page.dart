// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_apex/models/request/auth/add_skills.dart';
import 'package:job_apex/views/common/width_spacer.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_constants.dart';
import '../../../../controllers/skills_provider.dart';
import '../../../../controllers/zoom_provider.dart';
import '../../../../models/response/auth/skills.dart';
import '../../../../services/helpers/auth_helper.dart';
import '../../../common/app_style.dart';
import '../../../common/reusable_text.dart';
import 'add_skills_widget.dart';

class SkillWidget extends StatefulWidget {
  const SkillWidget({super.key});

  @override
  State<SkillWidget> createState() => _SkillWidgetState();
}

class _SkillWidgetState extends State<SkillWidget> {
  Future<List<Skills>>? userSkills;

  final TextEditingController skills = TextEditingController();

  Future<List<Skills>> getSkills() {
    userSkills = AuthHelper.getSkills();
    return userSkills!;
  }

  @override
  void initState() {
    super.initState();
    getSkills();
  }

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var skillsNotifier = Provider.of<SkillsNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                  text: 'Skills',
                  style: appStyle(15, Color(kDark.value), FontWeight.w600)),
              Consumer<SkillsNotifier>(
                  builder: (context, skillNotifier, child) {
                return InkWell(
                  onTap: () {
                    skillNotifier.setSkills = !skillNotifier.addSkills;
                  },
                  child: Icon(
                    !skillNotifier.addSkills
                        ? MaterialCommunityIcons.plus_circle_outline
                        : AntDesign.closecircleo,
                    size: 20,
                  ),
                );
              })
            ],
          ),
        ),
        skillsNotifier.addSkills == true
            ? AddSkillsWidget(
                userSkill: skills,
                onTap: () {
                  if (skills.text.isEmpty) {
                    return;
                  }
                  AddSkill tempModel = AddSkill(skill: skills.text.toString());
                  var model = addSkillToJson(tempModel);
                  AuthHelper.addSkills(model);
                  userSkills = getSkills();
                  skills.clear();
                  skillsNotifier.setSkills = !skillsNotifier.addSkills;
                },
              )
            : SizedBox(
                height: 62.w,
                child: FutureBuilder<List<Skills>>(
                    future: userSkills,
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Animate(
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
                        );
                        // Center(
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     width: 15,
                        //     height: 15,
                        //     child: const CircularProgressIndicator.adaptive(),
                        //   ),
                        // );
                      } else if (snapshot.hasError) {
                        return const Text('No Skills found');
                      }
                      if (snapshot.connectionState == ConnectionState.none) {
                        return const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 2,
                              ),
                            ),
                            WidthSpacer(width: 5),
                            Text('Internal server error'),
                          ],
                        );
                      } else if (snapshot.data!.isEmpty) {
                        return Center(
                            child: ReusableText(
                                text: 'No Skills Found',
                                style: appStyle(10, Color(kDarkGrey.value),
                                    FontWeight.w600)));
                      } else {
                        final skills = snapshot.data;
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: skills!.map((skill) {
                            return GestureDetector(
                              onLongPress: () {
                                skillsNotifier.setSkillsId = skill.id;
                              },
                              onLongPressCancel: () {
                                skillsNotifier.setSkillsId = '';
                              },
                              child: Container(
                                  margin:
                                      EdgeInsets.only(bottom: 30.h, right: 6.w),
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.w),
                                      color: Color(kLightGrey.value)),
                                  child: Row(
                                    children: [
                                      Text(
                                        skill.skill,
                                        style: TextStyle(
                                          color: Color(kDark.value),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      ),
                                      const WidthSpacer(width: 5),
                                      skillsNotifier.addSkillsId == skill.id
                                          ? GestureDetector(
                                              onTap: () {
                                                AuthHelper.deleteSkills(
                                                    skill.id);
                                                skillsNotifier.setSkillsId = '';
                                                userSkills = getSkills();
                                              },
                                              child: Icon(
                                                AntDesign.closecircleo,
                                                size: 14,
                                                color: Color(kDark.value),
                                              ),
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  )),
                            );
                          }).toList(),
                        );
                      }
                      //  else {
                      //   return const Text('No Skills found');
                      // }
                    })),
              )
      ],
    );
  }
}
