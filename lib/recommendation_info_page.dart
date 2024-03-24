import 'package:flutter/material.dart';
import 'package:tastypal/utils/colors.dart';
import 'package:tastypal/utils/responsive.dart';
import 'package:tastypal/utils/textstyles.dart';

class RecommendationInfo extends StatefulWidget {
  final name;
  final description;
  final image;
  const RecommendationInfo({super.key, this.name, this.description, this.image});

  @override
  State<RecommendationInfo> createState() => _RecommendationInfoState();
}

class _RecommendationInfoState extends State<RecommendationInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child:
            Container(
              width: AppMediaQuery.screenWidth(context),
              child: Card(
                color: CustomColor.mildgreen(),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                child: Container(
                  alignment: Alignment.center,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.fitWidth,
                          height: 300,
                          width: 300,
                        ))),
              ),
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextStyles.head(widget.name, 28),
                      SizedBox(height: 10,),
                      CustomTextStyles.subtext(widget.description, 18.0, TextAlign.start),
                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
