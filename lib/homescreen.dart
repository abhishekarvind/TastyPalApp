import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastypal/profile_page.dart';
import 'package:tastypal/scan_page.dart';
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/responsive.dart';
import 'package:tastypal/utils/textstyles.dart';
import 'package:glassmorphism/glassmorphism.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ScanPage()) );
        },
          backgroundColor: CustomColor.darkgreen(), label: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Scan Label",style: TextStyle(
                fontWeight: FontWeight.bold,color: CustomColor.lightgreen(),fontSize: AppMediaQuery.textFactor(context)*18
              ),),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset('assets/logo.png'),
          ),
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
              },
                child: Icon(Icons.account_circle_outlined,size:50,color: CustomColor.darkgreen(),))

          ],
          toolbarHeight: 90,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextStyles.head(
                  "Home", AppMediaQuery.textFactor(context) * 28),
              CustomTextStyles.subtext("Here is your personalized food", AppMediaQuery.textFactor(context)*18, TextAlign.start),
              
            ],
          ),
        ),
      ),
    );
  }
}
