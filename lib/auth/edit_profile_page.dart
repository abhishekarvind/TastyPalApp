import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastypal/auth/allergy_page.dart';
import 'package:tastypal/profile_page.dart';
import 'package:tastypal/utils/button.dart';

import '../utils/colors.dart';
import '../utils/responsive.dart';
import '../utils/textstyles.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateTime dateTime = DateTime.now();
  TextEditingController dob = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  void date() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030))
        .then((value) {
      setState(() {
        dateTime = value!;
        dob.text = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      });
    });
  }

  String? user;

  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.lightgreen(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users')
                  .doc(user)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    heightFactor: AppMediaQuery.screenHeight(context)/130,
                      child: Image.asset("assets/loading.gif",));
                }
                return Padding(
                  padding:EdgeInsets.symmetric(vertical: AppMediaQuery.screenHeight(context)/40,horizontal: AppMediaQuery.screenWidth(context)/25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextStyles.head(
                          "Profile", AppMediaQuery.textFactor(context) * 28),
                      SizedBox(height: AppMediaQuery.screenHeight(context)/20,),
                      Head('Name'),
                      TextFormField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            filled: true,
                            fillColor: CustomColor.mildgreen(),
                            hintText: snapshot.data['name'],
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
                          namecontroller.text = value!;
                        },
                      ),
                      SizedBox(
                        height: AppMediaQuery.screenHeight(context) / 50,
                      ),
                      Head('Date of Birth'),
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
                            hintText: snapshot.data['Date of birth'],
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
                        height: AppMediaQuery.screenHeight(context) / 50,
                      ),
                      Head('Weight'),
                      TextFormField(
                        controller: weight,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            filled: true,
                            fillColor: CustomColor.mildgreen(),
                            hintText: snapshot.data['Weight'],
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
                        height: AppMediaQuery.screenHeight(context) / 50,
                      ),
                      Head('Height'),
                      TextFormField(
                        controller: height,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            filled: true,
                            fillColor: CustomColor.mildgreen(),
                            hintText: snapshot.data['Height'],
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
                      SizedBox(height: AppMediaQuery.screenHeight(context)/20,),
                      CustomTextStyles.head(
                          "Allergies", AppMediaQuery.textFactor(context) * 28),
                      SizedBox(height: AppMediaQuery.screenHeight(context)/40,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AllergyPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomColor.mildgreen(),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(snapshot.data['Allergies'], style:
                          GoogleFonts.manrope(color: CustomColor.darkgreen(), fontSize: 18),),
                      ),
                    ),
                  ),
                      SizedBox(height: AppMediaQuery.screenHeight(context)/20,),
                      CustomButton.button("Save Changes", CustomColor.darkgreen(),Colors.white, () {
                        FirebaseFirestore.instance.collection('users').doc(user).update({
                          'name':namecontroller.text.trim(),
                          'Date of birth':dob.text.trim(),
                          'Weight':weight.text.trim(),
                          'Height':height.text.trim(),
                        }).whenComplete(() => Fluttertoast.showToast(msg: "Updated Successfully"));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ProfilePage()));
                      })
                    ],
                  ),
                );
              }
          ),
        ),
      ),
    );
  }

  Widget Head(String title) {
    return CustomTextStyles.subtext(
        title, AppMediaQuery.textFactor(context) * 16 ,TextAlign.start);
  }
}
