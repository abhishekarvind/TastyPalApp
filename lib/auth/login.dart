
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tastypal/auth/forgot_password.dart';
import 'package:tastypal/auth/signup.dart';
import 'package:tastypal/homescreen.dart';
import 'package:tastypal/utils/auth_methods.dart';
import 'package:tastypal/utils/button.dart';
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/responsive.dart';
import 'package:tastypal/utils/textstyles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  // final bool _isObscure = true;

  navigateToHomePage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/20,vertical: AppMediaQuery.screenHeight(context)/10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextStyles.head("Login",
                  AppMediaQuery.textFactor(context) * 28),
              SizedBox(
                height: AppMediaQuery.screenHeight(context) / 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Image.asset('assets/login.gif'),
                ),
              ),
              Form(
                key: key,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      SizedBox(
                        height: AppMediaQuery.screenHeight(context) / 60,
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value!.length < 8) {
                            return "Please enter the password";
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
                                borderRadius: BorderRadius.circular(40))),
                      )
                    ]),
              ),
              SizedBox(
                height: AppMediaQuery.screenHeight(context) / 60,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push((context), MaterialPageRoute(builder: (context)=>const ForgotPage()));
                },
                child:CustomTextStyles.subtext("Forgot password?",
                  AppMediaQuery.textFactor(context) * 14, null),),
              SizedBox(
                height: AppMediaQuery.screenHeight(context) / 30,
              ),
              CustomButton.button(
                "Login",
                CustomColor.darkgreen(),
                Colors.white,
                () async {
                  if (key.currentState!.validate()) {
                    String res = await AuthMethods().loginUser(
                        email: emailcontroller.text.trim(),
                        password: passwordcontroller.text.trim());
                    if (res == "success") {
                      navigateToHomePage();
                    } else {
                      Fluttertoast.showToast(msg: "Some error occurred");
                    }
                  }
                },
              ),
              SizedBox(
                height: AppMediaQuery.screenHeight(context) / 60,
              ),

              Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));
                  },
                  child: RichText(text: const TextSpan(
                    children: [
                      TextSpan(text: "Don’t have an account ",style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black
                      )),
                      TextSpan(text: "SignUp",style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blueAccent
                      )),
                  
                    ]
                  )),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
