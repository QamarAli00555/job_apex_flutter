import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_apex/models/request/auth/login_model.dart';
import 'package:job_apex/views/screens/home/homepage.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/login_provider.dart';
import '../../../controllers/zoom_provider.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/custom_btn.dart';
import '../../common/custom_textfield.dart';
import '../../common/height_spacer.dart';
import '../../common/pages_loader.dart';
import '../../common/reusable_text.dart';
import '../../common/styled_container.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
                text: "Login",
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const HomePage());
                  },
                  child: const Icon(
                    AntDesign.leftcircleo,
                  ),
                ))),
        body: loginNotifier.loader
            ? const PageLoader()
            : buildStyleContainer(
                showImage: true,
                context,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Form(
                      key: loginNotifier.loginFormKey,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const HeightSpacer(size: 50),
                          ReusableText(
                              text: 'Welcome Back',
                              style: appStyle(
                                  30, Color(kDark.value), FontWeight.w600)),
                          ReusableText(
                              text:
                                  'Fill in the Details to Login to your account',
                              style: appStyle(
                                  14, Color(kDark.value), FontWeight.w400)),
                          const HeightSpacer(size: 40),
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
                            obscureText: loginNotifier.obscureText,
                            suffixIcon: InkWell(
                              onTap: () {
                                loginNotifier.setObsecureText =
                                    !loginNotifier.obscureText;
                              },
                              child: Icon(loginNotifier.obscureText
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
                                Get.offAll(() => const RegisterPage());
                              },
                              child: ReusableText(
                                  text: 'Dont\'t have an account? Register',
                                  style: appStyle(
                                      12, Color(kDark.value), FontWeight.w400)),
                            ),
                          ),
                          const HeightSpacer(size: 50),
                          Consumer<ZoomNotifier>(
                              builder: (context, zoomNotifier, child) {
                            return CustomButton(
                                onTap: () {
                                  loginNotifier.setLoader = true;
                                  LoginModel model = LoginModel(
                                      email: email.text,
                                      password: password.text);
                                  String newModel = loginModelToJson(model);
                                  loginNotifier.validateAndSave(
                                      newModel, zoomNotifier);
                                },
                                text: "Login");
                          })
                        ],
                      )),
                ),
              ),
      );
    });
  }
}
