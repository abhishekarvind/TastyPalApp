import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tastypal/heatlybites/lib/community_page.dart';
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
  }

  void createpost()async{
    FirebaseFirestore.instance.collection('posts').add({
      'user_id':user,
      'title':title.text.trim(),
      'description':description.text.trim(),
      'date':date.hour,
      'type':"general"

    }).whenComplete(() => Fluttertoast.showToast(msg: "Posted"));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CommunityPage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextStyles.head(
                "Create a post", AppMediaQuery.textFactor(context) * 28),
            Form(
              key: key,
                child: Column(
              children: [
                TextFormField(
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
    ));
  }
}
