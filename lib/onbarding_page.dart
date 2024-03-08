import 'package:flutter/material.dart';
import 'package:tastypal/auth/allergy_page.dart';
import 'package:tastypal/homescreen.dart';
import 'package:tastypal/utils/button.dart';
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
                      CustomTextStyles.head(onboarding().ob_data[index]['title'].toString(),AppMediaQuery.textFactor(context)*20),
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            }, child: CustomTextStyles.subtext(currentindex!=2?"Skip":"", AppMediaQuery.textFactor(context)*18, TextAlign.left)),
            SizedBox(
              width: 100,
              height: 40,
              child: ElevatedButton(
                onPressed: (){
                  if(currentindex!=2){
                    pageController.nextPage(duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  }else{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AllergyPage()));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.darkgreen()
                ),
                child: currentindex!=2?Text("Next",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),):Text("Done",
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
