import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tastypal/auth/start_screen.dart';
import 'package:tastypal/utils/auth_methods.dart';
import 'package:tastypal/utils/button.dart';
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/responsive.dart';
import 'package:tastypal/utils/textstyles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.lightgreen(),
      ),
      body: Padding(
        padding:EdgeInsets.symmetric(vertical: AppMediaQuery.screenHeight(context)/40,horizontal: AppMediaQuery.screenWidth(context)/25),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users")
                .doc(FirebaseAuth.instance.currentUser?.uid )
                .snapshots(),
            builder: (context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                Center(
                  child: Image.asset("assest/loading.gif"),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextStyles.head(
                      "Profile", AppMediaQuery.textFactor(context) * 28),
                  card("Name", snapshot.data['name'].toString()),
                  card("Date of Birth", snapshot.data['Date of birth'].toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      card('Height',"${snapshot.data['Height']} cm"),
                      card('Weight',"${snapshot.data['Weight']} kg")
                    ],
                  ),
                  CustomTextStyles.head(
                      "Allergies", AppMediaQuery.textFactor(context) * 28),
                  const SizedBox(height: 200,),
                  CustomButton.button('Edit Profile', CustomColor.darkgreen(), Colors.white, () { }),
                  CustomButton.button('Log out', const Color(0xffFF4545), Colors.white, () {
                    AuthMethods().signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const GetStarted()));
                  }),



                ],

              );
            }


        )
      ),
    ));
  }
  Widget card(String title,String content){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextStyles.subtext(title,AppMediaQuery.textFactor(context)*18,TextAlign.end),
        Padding(padding:EdgeInsets.symmetric(horizontal: AppMediaQuery.screenWidth(context)/14) ,child: CustomTextStyles.head(content, AppMediaQuery.textFactor(context)*26),)
      ],
    );
  }

}
