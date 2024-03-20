import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tastypal/auth/edit_profile_page.dart';
import 'package:tastypal/auth/login.dart';
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
      body: Padding(
        padding:EdgeInsets.symmetric(vertical: AppMediaQuery.screenHeight(context)/30,horizontal: AppMediaQuery.screenWidth(context)/25),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users")
                .doc(FirebaseAuth.instance.currentUser?.uid )
                .snapshots(),
            builder: (context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(
                    heightFactor: AppMediaQuery.screenHeight(context)/130,
                    child: Image.asset("assets/loading.gif",));
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/logo.png',height: 50,),
                    SizedBox(height: AppMediaQuery.screenHeight(context)/20,),
                    CustomTextStyles.head(
                        "Profile", AppMediaQuery.textFactor(context) * 28),
                    SizedBox(height: AppMediaQuery.screenHeight(context)/20,),
                    card("Name", snapshot.data['name'].toString()),
                    SizedBox(height: AppMediaQuery.screenHeight(context)/40,),
                    card("Date of Birth", snapshot.data['Date of birth'].toString()),
                    SizedBox(height: AppMediaQuery.screenHeight(context)/40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        card('Height',"${snapshot.data['Height']} cm"),
                        card('Weight',"${snapshot.data['Weight']} kg")
                      ],
                    ),
                    SizedBox(height: AppMediaQuery.screenHeight(context)/40,),
                    CustomTextStyles.head(
                        "Allergies", AppMediaQuery.textFactor(context) * 28),
                    Padding(padding:EdgeInsets.symmetric(horizontal: AppMediaQuery.screenWidth(context)/14) ,child: CustomTextStyles.subtext(snapshot.data['Allergies'], AppMediaQuery.textFactor(context)*22,TextAlign.start))
                    ,SizedBox(height: AppMediaQuery.screenHeight(context)/10,),
                    CustomButton.button('Edit Profile', CustomColor.darkgreen(), Colors.white, () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const EditProfile()));
                    }),
                    SizedBox(height: AppMediaQuery.screenHeight(context)/60,),
                    CustomButton.button('Log out', const Color(0xffFF4545), Colors.white, () {
                      AuthMethods().signOut();
                      PersistentNavBarNavigator.pushNewScreen(context, screen: LoginPage(),withNavBar: false);
                    }),
                  ],
                
                ),
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
        Padding(padding:EdgeInsets.symmetric(horizontal: AppMediaQuery.screenWidth(context)/12) ,child: CustomTextStyles.head(content, AppMediaQuery.textFactor(context)*26),)
      ],
    );
  }

}
