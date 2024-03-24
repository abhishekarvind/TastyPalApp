import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tastypal/recommendation_info_page.dart';
import 'package:tastypal/select_page.dart';
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/recommendation_item_model.dart';
import 'package:tastypal/utils/responsive.dart';
import 'package:tastypal/utils/textstyles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser!.uid;
    Future.delayed(
      Duration(seconds: 2),
      () => Image.asset("assets/loading.gif"),
    );
    get_data();
    loadData();
  }

  List<RecommendationModel> food_data=[];
  Future<void> loadData()async{
    setState(() async {
      food_data= await modeldata();
    });
  }

  String generated_text = "";
  List<String> dishes = [];

  String user_preferences = "";
  String user_allergies="";

  Future<void> recommend_model(String user_preferences,String user_allergies) async {
    http.Client client = http.Client();

    try {
      Map<String, dynamic> prompt = {
        'prompt': 'Act as a recommendation model you have to give only the dish name and the dish name should be selected from the question asked here is the questions What is your favorite cuisine?,Do you have any dietary restrictions or preferences?,How do you feel about spicy food?,'
                'What type of meal are you looking for?,What is your budget range for a meal?,Are you aiming for healthy food options? and the response  given are' +
            user_preferences +
            'make sure the answer should be within the give list of dishes and is not allegic to user and the user is to'+user_allergies +
            RecommendationModel.dish.toString() +
            'and the response should be in a array list suggest me only 10 dish'
      };
      http.Response response = await client.post(
        Uri.parse('http://192.168.1.7:5000/get_openai_response'),
        headers: {"Content-Type": 'application/json'},
        body: json.encode(prompt),
      );

      if (response.statusCode == 200) {
        final getresponse = await client.get(
          Uri.parse('http://192.168.1.7:5000/get_openai_response'),
          headers: {"Content-Type": 'application/json'},
        );

        if (getresponse.statusCode == 200) {
          Map<String, dynamic> content = jsonDecode(getresponse.body);
          generated_text = content['generated_content'];
          print(generated_text);
        } else {
          print('Failed to get response: ${getresponse.statusCode}');
        }
      } else {
        print('Failed to post response: ${response.statusCode}');
      }
    } finally {
    }
  }

  Future<void> get_data() async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(user).get();
    setState(() {
      user_preferences = documentSnapshot.get('user_preferences');
      user_allergies = documentSnapshot.get('Allergies');
      recommend_model(user_preferences,user_allergies).then((_) {
        setState(() {
          dishes = generated_text
              .split('\n')
              .map((dish) {
                return dish.replaceAll(RegExp(r'^\d+\.\s*'), '');
              })
              .where((dish) => dish.isNotEmpty)
              .toList();
        });
      });
    });
  }

  Widget? itemcard(String item) {
    for (RecommendationModel data in food_data) {
      if (item == data.item) {
        return GestureDetector(
          onTap: (){
            PersistentNavBarNavigator.pushNewScreen(context, screen: RecommendationInfo(name: data.item,description: data.description,image: data.image,));
          },
          child: Card(
            color: CustomColor.mildgreen(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            data.image,
                            fit: BoxFit.fitWidth,
                          ))),
                  SizedBox(
                    width: AppMediaQuery.screenWidth(context) / 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextStyles.head(data.item, 16),
                        CustomTextStyles.subtext(
                            data.description, 14.0, TextAlign.start)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          padding: EdgeInsets.symmetric(
              horizontal: AppMediaQuery.screenWidth(context) / 35),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextStyles.head(
                    "Home", AppMediaQuery.textFactor(context) * 24),
                SizedBox(
                  height: AppMediaQuery.screenHeight(context) / 30,
                ),
                SizedBox(
                  width: AppMediaQuery.screenWidth(context),
                  child: Card(
                      color: CustomColor.mildgreen(),
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: AppMediaQuery.screenWidth(context) / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextStyles.head("HealthyBites",
                                      AppMediaQuery.textFactor(context) * 22),
                                  SizedBox(
                                    height:
                                        AppMediaQuery.screenHeight(context) /
                                            50,
                                  ),
                                  CustomTextStyles.subtext(
                                      "Easily discover delicious recipes based on the ingredients you have on hand. ",
                                      AppMediaQuery.textFactor(context) * 14.0,
                                      TextAlign.start),
                                  SizedBox(
                                    height:
                                        AppMediaQuery.screenHeight(context) /
                                            50,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        PersistentNavBarNavigator.pushNewScreen(
                                            context,
                                            screen: const SelectPage(),
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .slideRight);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              CustomColor.darkgreen(),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Open",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Image.asset(
                              'assets/chef.png',
                              height: 140,
                            )
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: AppMediaQuery.screenHeight(context) / 40,
                ),
                CustomTextStyles.subtext(
                    "Here is your personalized food recommendation",
                    AppMediaQuery.textFactor(context) * 17,
                    TextAlign.start),
                SizedBox(
                  height: AppMediaQuery.screenHeight(context) / 50,
                ),
                dishes.isEmpty
                    ? Center(
                        heightFactor: 2,
                        child: Image.asset("assets/loading.gif"))
                    : ListView.builder(
                        physics: const PageScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dishes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: itemcard(dishes[index].toString()),
                          );
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
