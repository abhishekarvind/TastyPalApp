import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/responsive.dart';
import 'package:tastypal/utils/textstyles.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}



class _ScanPageState extends State<ScanPage> {
  bool done =false;
  String? user;
  String user_allegries=" ";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user=FirebaseAuth.instance.currentUser!.uid;
    userdata();
  }
  Future<void> userdata() async{
    DocumentSnapshot documentSnapshot= await FirebaseFirestore.instance.collection('users').doc(user).get();
    setState(() {
      user_allegries=documentSnapshot.get('Allergies');
    });
  }



  File? _image;
  final ImagePicker _picker = ImagePicker();
  String ingredients = '';
  String generated_text="";

  Future<void> postdata()async{

    Map<String, dynamic> prompt={
      'prompt':'you have respond to this prompt as yes or no based on whether the user allergic to the food and also give reason'+
          'specific what type of the allergen that the ingredients list has that is allergy to the user.'+'The user is allergic to $user_allegries'+'and the ingredients in the food products are $ingredients'
    };

    http.Response response= await http.post(
      Uri.parse('http://192.168.1.7:5000/get_openai_response'),
    headers: {"Content-Type":'application/json'},
      body: json.encode(prompt),
    );
    if( response.statusCode==200){
      print('Done');
    }
    final getresponse= await http.get(
      Uri.parse('http://192.168.1.7:5000/get_openai_response'),
      headers: {"Content-Type":'application/json'},
    );
    if(getresponse.statusCode==200){
      Map<String, dynamic> content = jsonDecode(getresponse.body);
      setState(() {
        generated_text=content['generated_content'];
        print(generated_text);
        done=true;
      });
    }
  }


  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source:source);

    setState(() {
      _image = File(pickedFile!.path);
    });

    _processImage();
  }

  Future<void> _processImage() async {
    if (_image == null) return;

    final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(_image!);
    final TextRecognizer textRecognizer = GoogleVision.instance.textRecognizer();

    try {
      final VisionText visionText = await textRecognizer.processImage(visionImage);
      for (TextBlock block in visionText.blocks) {
        for (TextLine line in block.lines) {
          setState(() {
            ingredients+=line.text!;
          });
          }
        }
      }

    catch (e) {
      print('Error: $e');
    }
    finally {
      textRecognizer.close();
    }
    print(ingredients);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(onPressed: (){
          _pickImage(ImageSource.gallery);
          if(_image!=null){
            setState(() {
              postdata();
            });
          }
        },
          backgroundColor: CustomColor.darkgreen(),
          elevation: 5,
          child: Icon(Icons.camera_alt,color: Colors.white,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/20,vertical: AppMediaQuery.screenHeight(context)/20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      CustomTextStyles.head("Scan a product",
                          AppMediaQuery.textFactor(context) * 28),

                      CustomTextStyles.subtext("Point your camera at the product\nbarcode to get details.", AppMediaQuery.textFactor(context)*16, TextAlign.center),
                      SizedBox(height: AppMediaQuery.screenHeight(context)/20,),
                      done!=true?Image.asset("assets/scanpage.png"):(generated_text.contains("Yes",0)?Image.asset("assets/alert.png",height: AppMediaQuery.screenHeight(context)/5,):Image.asset("assets/tick.png",height: AppMediaQuery.screenHeight(context)/5)),
                      Text(generated_text,
                        style:GoogleFonts.manrope(color: CustomColor.darkgreen(), fontSize: 16),
                      )


                    ],
                  ),


                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
