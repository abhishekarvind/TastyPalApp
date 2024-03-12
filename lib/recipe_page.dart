import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/responsive.dart';
import 'package:tastypal/utils/textstyles.dart';

class RecipePage extends StatefulWidget {
  final List selected;
  const RecipePage({super.key, required this.selected});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String generated_content="";
  List<String> contentList = [];

  Future<void> postdata()async{
    Map<String, dynamic> prompt={
      'prompt':'Act as a Indian chef ,When prompted with ingredients or the items present in kitchen . You should suggest food item that could be cooked with these ingredients'+widget.selected.toString()
          + 'in the below format\n'+'Title\n'
      'Description\n'
      'Recipe'+'make the content short and easy to ready give it in a proper format and make the content short an precise'
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
        generated_content=content['generated_content'];
        contentList.addAll(generated_content.split('\n'));
        print(contentList);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postdata();
    contentList.addAll(generated_content.split('\n'));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColor.lightgreen(),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal:AppMediaQuery.screenWidth(context)/20,vertical: AppMediaQuery.screenHeight(context)/20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextStyles.head(
                      "Here is your recipe", AppMediaQuery.textFactor(context) * 24),
                  SizedBox(height: AppMediaQuery.screenHeight(context)/40,),
                  Center(child: Image.asset('assets/cook.png',height: 180,)),
                  SizedBox(height: AppMediaQuery.screenHeight(context)/40,),
                  Card(
                    color: CustomColor.mildgreen(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: CustomTextStyles.subtext(generated_content,18.0,TextAlign.start),
                        ),
                      ],
                    )
                  )
              
              
                ],
              ),
            ),
          ),
        ));
  }
}
