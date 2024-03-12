import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tastypal/profile_page.dart';
import 'package:tastypal/scan_page.dart';
import 'package:tastypal/select_page.dart';
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset('assets/logo.png'),
          ),
          toolbarHeight: 90,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/35),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextStyles.head(
                    "Home", AppMediaQuery.textFactor(context) * 28),
                SizedBox(height: AppMediaQuery.screenHeight(context)/30,),
                SizedBox(
                  width: AppMediaQuery.screenWidth(context),
                  child: Card(
                  color: CustomColor.mildgreen(),
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: AppMediaQuery.screenWidth(context)/2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextStyles.head(
                                  "HealthyBites", AppMediaQuery.textFactor(context) * 24),
                              SizedBox(height: AppMediaQuery.screenHeight(context)/50,),
                              CustomTextStyles.subtext("Easily discover delicious recipes based on the ingredients you have on hand. ", 16.0, TextAlign.start),
                              SizedBox(height: AppMediaQuery.screenHeight(context)/50,),
                              ElevatedButton(onPressed: (){
                                PersistentNavBarNavigator.pushNewScreen(context, screen: SelectPage(),
                                    pageTransitionAnimation: PageTransitionAnimation.slideRight
                                );
                              },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: CustomColor.darkgreen(),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Open",style: TextStyle(color: Colors.white),),
                                  ))
                            ],
                          ),
                        ),
                        Image.asset('assets/chef.png',height: 140,)
                      ],
                    ),
                  )
                            ),
                ),
                SizedBox(height: AppMediaQuery.screenHeight(context)/40,),
                CustomTextStyles.subtext("Here is your personalized food", AppMediaQuery.textFactor(context)*18, TextAlign.start),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
