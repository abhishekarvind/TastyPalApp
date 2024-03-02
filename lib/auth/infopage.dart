import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tastypal/auth/email_verification.dart';
import 'package:tastypal/utils/button.dart';
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/responsive.dart';
import 'package:tastypal/utils/textstyles.dart';

class Infopage extends StatefulWidget {
  const Infopage({super.key});

  @override
  State<Infopage> createState() => _InfopageState();
}

class _InfopageState extends State<Infopage> {
  final GlobalKey<FormState> key3 = GlobalKey<FormState>();
  TextEditingController dob = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController sex = TextEditingController();
  String? user;
  Future<void> addinfo(
      String dob, String height, String weight, String sex) async {
    await FirebaseFirestore.instance.collection("users").doc(user).update(
        {'Date of birth': dob, 'Sex': sex, 'Weight': weight, 'Height': height});
    Fluttertoast.showToast(msg: "Added Successfully!");

  }

  @override
  void initState() {
    setState(() {
      user = FirebaseAuth.instance.currentUser!.uid;
    });
    super.initState();
  }
  DateTime dateTime =DateTime.now();

  void date() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030))
        .then((value) {
      setState(() {
        dateTime = value!;
        dob.text = '${dateTime!.day}/${dateTime!.month}/${dateTime!.year}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/20,vertical: AppMediaQuery.screenHeight(context)/10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextStyles.head(
                      "Personal Information", 28.0),
                  SizedBox(
                    height: AppMediaQuery.screenHeight(context) / 40.0,
                  ),
                  Center(
                    child: Image.asset("assets/login.gif"),
                  ),
                  Form(
                    key: key3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: AppMediaQuery.screenHeight(context) / 40,
                          ),
                          CustomTextStyles.head("Date of birth", 14),
                          SizedBox(
                            height: AppMediaQuery.screenHeight(context) / 70,
                          ),
                          TextFormField(
                            controller: dob,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            showCursor: false,
                            onTap: date,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                filled: true,
                                fillColor: CustomColor.mildgreen(),
                                hintText: 'MM/DD/YY',
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
                                return ("Please enter your DOB");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              dob.text = value!;
                            },
                          ),
                          SizedBox(
                            height: AppMediaQuery.screenHeight(context) / 60,
                          ),
                          CustomTextStyles.head("Sex", 14.0),
                          SizedBox(
                            height: AppMediaQuery.screenHeight(context) / 70,
                          ),
                          TextFormField(
                            controller: sex,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                filled: true,
                                fillColor: CustomColor.mildgreen(),
                                hintText: 'Sex',
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
                                return ("Please enter your sex");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              sex.text = value!;
                            },
                          ),
                          SizedBox(
                            height: AppMediaQuery.screenHeight(context) / 60,
                          ),
                          CustomTextStyles.head("Weight(kg)", 14),
                          SizedBox(
                            height: AppMediaQuery.screenHeight(context) / 70,
                          ),
                          TextFormField(
                            controller: weight,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                filled: true,
                                fillColor: CustomColor.mildgreen(),
                                hintText: 'Weight',
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
                                return ("Please enter your weight");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              weight.text = value!;
                            },
                          ),
                          SizedBox(
                            height: AppMediaQuery.screenHeight(context) / 60,
                          ),
                          CustomTextStyles.head("Height(cm)", 14),
                          SizedBox(
                            height: AppMediaQuery.screenHeight(context) / 70,
                          ),
                          TextFormField(
                            controller: height,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                filled: true,
                                fillColor: CustomColor.mildgreen(),
                                hintText: 'Height',
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
                                return ("Please enter your weight");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              height.text = value!;
                            },
                          ),
                          SizedBox(
                            height: AppMediaQuery.screenHeight(context) / 20,
                          ),
                          CustomButton.button("Continue",
                              CustomColor.darkgreen(), Colors.white, () {
                            addinfo(dob.text.trim(), height.text.trim(),
                                weight.text.trim(), sex.text.trim());
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const EmailVerification()));

                          })
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
