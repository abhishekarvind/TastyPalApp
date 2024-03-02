import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tastypal/auth/infopage.dart';
import 'package:tastypal/utils/auth_methods.dart';
import 'package:tastypal/utils/button.dart';
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/textstyles.dart';

import '../utils/responsive.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> key2 = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController cpasswordcontroller = TextEditingController();

  navigateToInfoScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const Infopage(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/20,vertical: AppMediaQuery.screenHeight(context)/10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CustomTextStyles.head("SignUp",
                AppMediaQuery.textFactor(context) * 28),
            Center(
              child: Image.asset("assets/login.gif"),
            ),
            SizedBox(
              height: AppMediaQuery.screenHeight(context) / 40,
            ),
            Form(
              key: key2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          filled: true,
                          fillColor: CustomColor.mildgreen(),
                          hintText: 'Name',
                          hintStyle:
                              TextStyle(color: CustomColor.darkgreen()),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                style: BorderStyle.none,
                                width: 0,
                              ))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please enter your email");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailcontroller.text = value!;
                      },
                    ),
                    SizedBox(
                      height: AppMediaQuery.screenHeight(context) / 60,
                    ),
                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          filled: true,
                          fillColor: CustomColor.mildgreen(),
                          hintText: 'Email address',
                          hintStyle:
                              TextStyle(color: CustomColor.darkgreen()),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                style: BorderStyle.none,
                                width: 0,
                              ))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please enter your email");
                        }
                        // reg expression for email validation
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please enter a valid email");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailcontroller.text = value!;
                      },
                    ),
                    SizedBox(
                      height: AppMediaQuery.screenHeight(context) / 60,
                    ),
                    TextFormField(
                      controller: passwordcontroller,
                      validator: (value) {
                        if (value!.length < 8) {
                          return " Invaild Password";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        passwordcontroller.text = value!;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          hintText: "Password",
                          hintStyle:
                              TextStyle(color: CustomColor.darkgreen()),
                          fillColor: CustomColor.mildgreen(),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  style: BorderStyle.none, width: 0),
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: AppMediaQuery.screenHeight(context) / 60,
                    ),
                    TextFormField(
                      controller: cpasswordcontroller,
                      validator: (value) {
                        if (value!.length < 8) {
                          return " Invaild Password";
                        }
                        if (value.toString() !=
                            passwordcontroller.text.trim()) {
                          return "Password does not match";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        passwordcontroller.text = value!;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          hintText: "Confirm Password",
                          hintStyle:
                              TextStyle(color: CustomColor.darkgreen()),
                          fillColor: CustomColor.mildgreen(),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  style: BorderStyle.none, width: 0),
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ]),
            ),
            SizedBox(
              height: AppMediaQuery.screenHeight(context) / 40,
            ),
            CustomButton.button(
              "Sign up",
              CustomColor.darkgreen(),
              Colors.white,
              () async {
                if (key2.currentState!.validate()) {
                  String res = await AuthMethods().signUpUser(
                      email: emailcontroller.text.trim(),
                      password: passwordcontroller.text.trim(),
                      name: namecontroller.text.trim());
                  if (res == "success") {
                    navigateToInfoScreen();
                  } else {
                    Fluttertoast.showToast(msg: "Some error occurred");
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
