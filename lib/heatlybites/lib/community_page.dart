import 'package:flutter/material.dart';
import 'package:tastypal/heatlybites/lib/post_screen.dart';
import 'package:tastypal/utils/colors.dart';

import '../../utils/responsive.dart';
import '../../utils/textstyles.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
          },
          backgroundColor: CustomColor.darkgreen(),shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)
        ),
          child: const Icon(Icons.edit,color: Colors.white,size: 30,),
        ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextStyles.head(
                  "Feeds", AppMediaQuery.textFactor(context) * 28),
            ],
          ),
        ),
      ),
    );
  }
}
