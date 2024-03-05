import 'dart:io';

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
  File? _image;
  final ImagePicker _picker = ImagePicker();

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
          for (TextElement element in line.elements) {
            if(RegExp(r'^[a-zA-Z]+$').hasMatch(element.text.toString())){
              print(element.text.toString());
            }
          }
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      textRecognizer.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
            backgroundColor: CustomColor.lightgreen(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.large(onPressed: (){
          _pickImage(ImageSource.gallery);

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
            child: Column(
              children: [
                Column(
                  children: [
                    CustomTextStyles.head("Scan a product",
                        AppMediaQuery.textFactor(context) * 28),
                    CustomTextStyles.subtext("Point your camera at the product\nbarcode to get details.", AppMediaQuery.textFactor(context)*16, TextAlign.center),
                    Image.asset("assets/scanpage.png")

                  ],
                ),


              ],
            ),
          ),
        ),

      ),
    );
  }
}
