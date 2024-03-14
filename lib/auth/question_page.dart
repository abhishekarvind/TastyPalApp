import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tastypal/main_homescreen.dart';
import 'package:tastypal/utils/button.dart';
import 'package:tastypal/utils/colors.dart';

import '../utils/recommendation_question_model.dart';
import '../utils/responsive.dart';
import '../utils/textstyles.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List selected = [];
  PageController pageController =PageController();
  String? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user=FirebaseAuth.instance.currentUser!.uid;
  }
  Future<void> addinfo() async {
    await FirebaseFirestore.instance.collection("users").doc(user).update(
        {'user_preferences':selected.toString().replaceAll("[", "").replaceAll("]","")});
    Fluttertoast.showToast(msg: "Added Successfully!");
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: pageController,
          itemCount: Question.data.length,
          itemBuilder: (context,index){
            final data= Question.data[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/20,vertical: AppMediaQuery.screenHeight(context)/10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: CustomTextStyles.head("Personal Information",
                        AppMediaQuery.textFactor(context) * 28),
                  ),
                  CustomTextStyles.subtext(data.question,22.0, TextAlign.start),
                  SizedBox(
                    height: AppMediaQuery.screenHeight(context)/2,
                    child: ListView.builder(
                      itemCount: data.choices.length,
                        itemBuilder: (context,index1){
                          final data2 =Question.data[index].choices;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(onPressed: (){
                              final choice = data.choices[index1];
                              setState(() {
                                if(selected.contains(choice)){
                                  selected.remove(choice);
                                }
                                else{
                                  selected.add(choice);
                                }
                              });
                              print(selected);
                            },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: CustomColor.darkgreen()),
                                backgroundColor: selected.contains(data2[index1])?CustomColor.mildgreen():CustomColor.lightgreen()
                              ),
                                child:Padding(
                                  padding: EdgeInsets.all(15),
                                  child: CustomTextStyles.head(data2[index1],16.0,),

                                ),
                            ),
                          );
                        }),
                  ),
                  CustomButton.button(index==Question.data.length-1?"Done":"Next", CustomColor.darkgreen(),Colors.white, () {
                    if(index==Question.data.length-1){
                      addinfo();
                      Navigator.pushReplacement((context), MaterialPageRoute(builder: (context)=>Mainhome()));
                    }
                    pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);

                  })
                ],
              ),
            );

          },
        ),
      ),
    );
  }
}
