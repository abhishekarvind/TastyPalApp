

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
  int like=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            PersistentNavBarNavigator.pushNewScreen(context, screen: const PostScreen(),
                pageTransitionAnimation: PageTransitionAnimation.slideRight
            );
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
          child: StreamBuilder(
            stream:  FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context,AsyncSnapshot snapshot) {
              if(snapshot.hasError||!snapshot.hasData){
                return Center(
                heightFactor: AppMediaQuery.screenHeight(context)/130,
                    child: Image.asset("assets/loading.gif",));}
              return  SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextStyles.head(
                        "Feeds", AppMediaQuery.textFactor(context) * 28),
                    SizedBox(height: AppMediaQuery.screenHeight(context)/40,),
                    SizedBox(
                      height: AppMediaQuery.screenHeight(context),
                      child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context,index){
                          return Card(
                            color: CustomColor.mildgreen(),
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextStyles.head(snapshot.data.docs[index]['title'].toString().toUpperCase(), 18.0),
                                  SizedBox(height: AppMediaQuery.screenHeight(context)/50,),
                                  CustomTextStyles.subtext(snapshot.data.docs[index]['description'], 16.0, TextAlign.start),
                                  SizedBox(height: AppMediaQuery.screenHeight(context)/50,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomTextStyles.head("@"+snapshot.data.docs[index]['username'], 16.0),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          );
                          }),
                    )

                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
