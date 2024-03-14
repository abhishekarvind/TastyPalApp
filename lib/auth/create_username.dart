import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tastypal/auth/email_verification.dart';
import 'package:tastypal/heatlybites/lib/community_page.dart';

import '../utils/button.dart';
import '../utils/colors.dart';
import '../utils/responsive.dart';
import '../utils/textstyles.dart';

class CreateUsername extends StatefulWidget {
  const CreateUsername({super.key});

  @override
  State<CreateUsername> createState() => _CreateUsernameState();
}

class _CreateUsernameState extends State<CreateUsername> {
  TextEditingController username = TextEditingController();
  String? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user=FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void>createuser(String username)async{
    FirebaseFirestore.instance.collection('users').doc(user).update({
      'username':username
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/20,vertical: AppMediaQuery.screenHeight(context)/10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: AppMediaQuery.screenHeight(context)/20,),
              CustomTextStyles.head("Create User",
                  AppMediaQuery.textFactor(context) * 28),
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    filled: true,
                    fillColor: CustomColor.mildgreen(),
                    hintText: 'Username',
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
                  return null;
                  // reg expression for email validation
                },
                onSaved: (value) {
                  username.text = value!;
                },
              ),
              CustomButton.button("Create", CustomColor.darkgreen(), Colors.white, () {
                createuser(username.text.trim());
                Fluttertoast.showToast(msg: "Created Successfully!");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EmailVerification()));
              }),
              SizedBox(height: AppMediaQuery.screenHeight(context)/30,),
            ],
          ),
        ),
      ),
    );
  }
}
