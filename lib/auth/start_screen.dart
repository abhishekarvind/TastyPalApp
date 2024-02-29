import 'package:flutter/material.dart';
import 'package:tastypal/auth/login.dart';
import 'package:tastypal/utils/button.dart';
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/responsive.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: AppMediaQuery.screenHeight(context)/40,
            ),
            Column(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: AppMediaQuery.screenHeight(context) / 5,
                ),

                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Tasty",
                      style: TextStyle(
                          fontSize: AppMediaQuery.textFactor(context) * 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "Pal",
                      style: TextStyle(
                          fontSize: AppMediaQuery.textFactor(context) * 35,
                          color: CustomColor.mildgreen(),
                          fontWeight: FontWeight.bold)),
                ])),
                Text('Elevate your dining experience\nwith us',textAlign: TextAlign.center,style: TextStyle(
                  color: CustomColor.darkgreen()
                ),),
              ],
            ),


            CustomButton.button("Get Started", CustomColor.darkgreen(), Colors.white, () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            })

          ],
        ),
      ),
    ));
  }
}
