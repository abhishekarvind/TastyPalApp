import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tastypal/utils/auth_methods.dart';

import '../utils/button.dart';
import '../utils/colors.dart';
import '../utils/responsive.dart';
import '../utils/textstyles.dart';


class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/20,vertical: AppMediaQuery.screenHeight(context)/10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CustomTextStyles.head("Forgot Password",
                    AppMediaQuery.textFactor(context) * 28),
                CustomTextStyles.subtext("To change your account password, please click the\nlink sent to your email address.", AppMediaQuery.textFactor(context)*14, TextAlign.center)
              ],
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
                      borderRadius: BorderRadius.circular(40),
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
                  return "Please enter correct mail";
                }
                return null;
              },
              onSaved: (value) {
                emailcontroller.text = value!;
              },
            ),
            //Image.assets("assets/flogo.gif"),
            CustomButton.button("Send Link", CustomColor.darkgreen(), Colors.white, () {
              AuthMethods().forgotpassword(email:emailcontroller.text.trim());
              Fluttertoast.showToast(msg: "Sent Successfully!");
            })


          ],
        ),
      ),
    ));
  }
}
