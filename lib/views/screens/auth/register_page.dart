import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/signup_provider.dart';
import '../../../controllers/zoom_provider.dart';
import '../../../models/request/auth/signup_model.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/custom_btn.dart';
import '../../common/custom_textfield.dart';
import '../../common/height_spacer.dart';
import '../../common/pages_loader.dart';
import '../../common/reusable_text.dart';
import '../../common/styled_container.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(builder: (context, signupNotifier, child) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: "Signup",
              child: GestureDetector(
                onTap: () {
                  Get.offAll(() => const LoginPage());
                },
                child: const Icon(
                  AntDesign.leftcircleo,
                ),
              ),
            )),
        body: signupNotifier.loader
            ? const PageLoader()
            : buildStyleContainer(
                showImage: true,
                context,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Form(
                      key: signupNotifier.signupFormKey,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const HeightSpacer(size: 50),
                          ReusableText(
                              text: 'Welcome',
                              style: appStyle(
                                  30, Color(kDark.value), FontWeight.w600)),
                          ReusableText(
                              text:
                                  'Fill in the Details to Signup for a account',
                              style: appStyle(
                                  14, Color(kDark.value), FontWeight.w400)),
                          const HeightSpacer(size: 40),
                          CustomTextField(
                            color: 1,
                            controller: username,
                            hintText: 'Enter your Username',
                            keyboardType: TextInputType.emailAddress,
                            validator: (username) {
                              if (username!.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 20),
                          CustomTextField(
                            color: 1,
                            controller: email,
                            hintText: 'Enter your Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              if (email!.isEmpty || !email.contains('@')) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 20),
                          CustomTextField(
                            color: 1,
                            controller: password,
                            hintText: 'Enter your Password',
                            obscureText: signupNotifier.obscureText,
                            suffixIcon: InkWell(
                              onTap: () {
                                signupNotifier.setObsecureText =
                                    !signupNotifier.obscureText;
                              },
                              child: Icon(signupNotifier.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (pass) {
                              if (pass!.isEmpty || pass.length < 8) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Get.offAll(() => const LoginPage());
                              },
                              child: ReusableText(
                                  text: 'Already registered? Login',
                                  style: appStyle(
                                      12, Color(kDark.value), FontWeight.w400)),
                            ),
                          ),
                          const HeightSpacer(size: 50),
                          Consumer<ZoomNotifier>(
                              builder: (context, zoomNotifie, child) {
                            return CustomButton(
                                onTap: () {
                                  signupNotifier.setLoader = true;
                                  SignupModel model = SignupModel(
                                      username: username.text,
                                      email: email.text,
                                      password: password.text);

                                  String newModel = signupModelToJson(model);
                                  signupNotifier.validateAndSave(newModel);
                                },
                                text: "Sign up");
                          })
                        ],
                      )),
                ),
              ),
      );
    });
  }
}
