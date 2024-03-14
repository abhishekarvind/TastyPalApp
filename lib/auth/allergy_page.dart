import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tastypal/auth/question_page.dart';
import 'package:tastypal/utils/button.dart';
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/textstyles.dart';

import '../utils/responsive.dart';

class AllergyPage extends StatefulWidget {
  const AllergyPage({super.key});

  @override
  State<AllergyPage> createState() => _AllergyPageState();
}

class _AllergyPageState extends State<AllergyPage> {
  String? user;
 List<String> unique_allergens = [
  'Almonds',
  'Chicken',
  'Celery',
  'Anchovies',
  'Cocoa',
  'Eggs',
  'Mustard',
  'Soybeans',
  'Fish',
  'Coconut',
  'Strawberries',
  'Oats',
  'Peanuts',
  'Pine nuts',
  'Rice',
  'Shellfish',
  'Pork',
  'Alcohol'
  ];
  List<String>selectedValue=[];
  Future<void> addinfo() async {
    await FirebaseFirestore.instance.collection("users").doc(user).update(
        {'Allergies':selectedValue.toString().replaceAll("[", "").replaceAll("]","")});
    Fluttertoast.showToast(msg: "Added Successfully!");

  }



  @override
  void initState() {
    // TODO: implement initState
    user=FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Padding(
          padding:EdgeInsets.symmetric(vertical: AppMediaQuery.screenHeight(context)/40,horizontal: AppMediaQuery.screenWidth(context)/35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextStyles.head("Pick your Allergies", 24),
              SizedBox(height: AppMediaQuery.screenHeight(context)/23,),
              SizedBox(
                child: ChipsChoice.multiple(
                  wrapped: true,
                    value: selectedValue,
                    choiceStyle: C2ChipStyle.filled(
                      color: CustomColor.mildgreen(),
                        elevation: 3,
                        borderRadius: BorderRadius.circular(30),
                        height: 50,
                        padding: const EdgeInsets.all(15),
                        selectedStyle: C2ChipStyle.filled(color: CustomColor.darkgreen())),
                    onChanged: (val) => setState(() => selectedValue = val),
                  choiceItems: C2Choice.listFrom(source: unique_allergens,
                      value: (i, v) => v, label: (i, v) => v,),
                ),
              ),
              SizedBox(height: AppMediaQuery.screenHeight(context)/10,),
              CustomButton.button("Next", CustomColor.darkgreen(), Colors.white, () {
                print(selectedValue);
                addinfo();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const QuestionPage()));
              })

            ],
          ),
        ),
      ),
    );
  }
}
