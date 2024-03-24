import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tastypal/heatlybites/lib/community_page.dart';
import 'package:tastypal/main_homescreen.dart';
import 'package:tastypal/utils/button.dart';
import 'package:tastypal/utils/colors.dart';

import '../../utils/responsive.dart';
import '../../utils/textstyles.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  String? user;
  String type="General";
  DateTime date =DateTime.now();
  GlobalKey<FormState> key=GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user=FirebaseAuth.instance.currentUser!.uid;
    getdata();
  }
  String? username;
  Future<void>getdata()async{
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(user).get();
    setState(() {
      username=documentSnapshot.get('username');
    });

  }


  void createpost()async{
    FirebaseFirestore.instance.collection('posts').add({
      'username':username,
      'user_id':user,
      'title':title.text.trim(),
      'description':description.text.trim(),
      'date':date.minute,
      'likeCount': 0

    }).whenComplete(() => Fluttertoast.showToast(msg: "Posted"));
    PersistentNavBarNavigator.pushNewScreen(context, screen: CommunityPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/35),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextStyles.head(
                  "Create a post", AppMediaQuery.textFactor(context) * 28),SizedBox(
                height: AppMediaQuery.screenHeight(context)/30,
              ),
              ListView(
                shrinkWrap: true,
                physics: const PageScrollPhysics(),
                children: [
                  Form(
                    key: key,
                      child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: title,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Please fill";
                          }
                          return null;
                        },
                        onSaved: (value){
                            title.text=value!;
                  
                        },
                        decoration: InputDecoration(
                          fillColor: CustomColor.mildgreen(),
                          filled: true,
                  
                          hintText: 'Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none
                          )
                        ),
                  
                      ),
                      SizedBox(
                        height: AppMediaQuery.screenHeight(context)/30,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Please fill";
                          }
                          return null;
                        },
                        onSaved: (value){
                            description.text=value!;
                        },
                        controller: description,
                        maxLines: 8,
                        maxLength: 300,
                        decoration: InputDecoration(
                          fillColor: CustomColor.mildgreen(),
                          filled: true,
                          hintText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none
                          )
                        ),
                      ),
                      SizedBox(
                        height: AppMediaQuery.screenHeight(context)/30,
                      ),
                    ],
                  )
                  ),
                ],
              ),
          
          
              CustomButton.button('Post', CustomColor.darkgreen(), Colors.white, () {
                if(key.currentState!.validate()){
                  createpost();
                }
              }),
              SizedBox(
                height: AppMediaQuery.screenHeight(context)/30,
              ),
          
          
          
            ],
          ),
        ),
      ),
    ));
  }
}
