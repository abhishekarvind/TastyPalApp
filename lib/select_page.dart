

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tastypal/recipe_page.dart';

import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/responsive.dart';
import 'package:tastypal/utils/textstyles.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  List ingredients = ["Eggs", "Chicken", "Rice", "Tomatoes", "Onions", "Potato", "Olive oil", "Flour", "Spinach", "Milk"];
  List ingredients_image=[
    'https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/egg.png?alt=media&token=94373b0b-4df2-443d-b37a-796839e45a1a',
    'https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/chicken.png?alt=media&token=5e98c422-da64-496b-8265-53a6c3f15c33',
    'https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/rice.png?alt=media&token=80168f6f-b0fb-4a9c-89ce-35f23b59b6bc',
    'https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/tomato.png?alt=media&token=9af0045e-2831-42f7-90a9-0c05d4937b7f',
    'https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/onion.png?alt=media&token=f79c8175-2acb-4ff6-8daa-52159fc7f36c',
    'https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/potato.png?alt=media&token=73343978-f146-4ea2-83e2-e35d23c95985',
    'https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/oil.png?alt=media&token=23889929-88d1-420a-bf7e-c165fc5426bc',
    'https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/flour.png?alt=media&token=0bab7c93-12c2-47ce-93b5-535b527560c6',
    'https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/spinach.png?alt=media&token=ff0a5b99-ecc3-4eb8-9930-11c62462c623',
    'https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/milk.png?alt=media&token=6ce043eb-5cab-4e36-82ad-cb0e5bd4ab59',
  ];
  List selected=[];
  void _onItemTap(int index) {
    setState(() {
      if (selected.contains(ingredients[index])) {
        selected.remove(ingredients[index]);
      } else {
        selected.add(ingredients[index]);
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selected.clear();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.lightgreen(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(context, screen: RecipePage(selected: selected));
          setState(() {
            selected.clear();
          });
          },
        backgroundColor: CustomColor.darkgreen(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Get Recipe",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
      ),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextStyles.head(
                  "What's in your Fridge", AppMediaQuery.textFactor(context) * 24),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: AppMediaQuery.screenHeight(context)/1.25,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemCount: ingredients.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: ()=>_onItemTap(index),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),
                                side: selected.contains(ingredients[index])?BorderSide(color: CustomColor.darkgreen(),width: 3):BorderSide.none
                              ),

                              color: CustomColor.mildgreen(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(ingredients_image[index],height: 60,),
                                  CustomTextStyles.head(ingredients[index], 22)
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
              SizedBox(height: AppMediaQuery.screenHeight(context)/40,),

            ],
          ),
        ),
      ),
    ));
  }
}
