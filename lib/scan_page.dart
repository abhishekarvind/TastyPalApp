import 'dart:convert';
import 'dart:io';
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
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String prompt = '';
  late String answer = '';

  Future<void> detect(String userContent) async {
    if (userContent == null) {
      // Handle the case when userContent is null (you might want to return early or provide a default value)
      return;
    }

    final http.Response response = await http.post(
      Uri.parse('http://192.168.1.7:5000/get_openai_response'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_input': userContent}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      setState(() {
        answer = responseData['generated_content'].toString();
      });
    } else {
      print('Error: ${response.reasonPhrase}');
    }
    print(answer);
  }
  
  Future<void> getdata()async{
    String a ="";
    final http.Response response= await http.get(Uri.parse('http://192.168.1.7:5000/send_hi'));
    final Map<String , dynamic> data =json.decode(response.body);
    print(data['message']);
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
          prompt+=line.text!;
          }
        }
      }

    catch (e) {
      print('Error: $e');
    }
    finally {
      textRecognizer.close();
    }
    print(prompt);
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
          getdata();
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
                    SizedBox(height: AppMediaQuery.screenHeight(context)/20,),
                    Image.asset("assets/scanpage.png"),


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
