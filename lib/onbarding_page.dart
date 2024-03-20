import 'package:flutter/material.dart';
import 'package:tastypal/auth/allergy_page.dart';
import 'package:tastypal/homescreen.dart';
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/onboarding_model.dart';
import 'package:tastypal/utils/responsive.dart';
import 'package:tastypal/utils/textstyles.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentindex=0;
  @override
  Widget build(BuildContext context) {
    PageController pageController=PageController();
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          onPageChanged: (value){
            setState(() {
              currentindex=value;
            });
          },
          controller: pageController,
            itemCount: onboarding().ob_data.length,
            itemBuilder: (context,index){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/20,vertical: AppMediaQuery.screenHeight(context)/10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(onboarding().ob_data[index]["image"].toString(),height: 100,),
                      Text(onboarding().ob_data[index]['title'],
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppMediaQuery.textFactor(context)*18,
                          color: CustomColor.darkgreen()
                        ),
                      ),
                      CustomTextStyles.subtext(onboarding().ob_data[index]['content'].toString(), AppMediaQuery.textFactor(context)*16, TextAlign.center)
                    ],
                  ),


                ],
              ),
            );

        }),
          bottomSheet: SizedBox(

      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AllergyPage()));
            }, child: CustomTextStyles.subtext(currentindex!=3?"Skip":"", AppMediaQuery.textFactor(context)*18, TextAlign.left)),
            SizedBox(
              width: 100,
              height: 40,
              child: ElevatedButton(
                onPressed: (){
                  if(currentindex!=3){
                    pageController.nextPage(duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn);
                  }else{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AllergyPage()));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.darkgreen()
                ),
                child: currentindex!=3?const Text("Next",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),):const Text("Done",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)

              ),
            )
          ],
        ),
      ),
    ),

      ),
    );
  }
}
