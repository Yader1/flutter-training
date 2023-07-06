import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:training_app/src/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackgroud,
      body: Container(
        padding: const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Training", style: TextStyle(fontSize: 30.0, color: AppColors.homePageTitle, fontWeight: FontWeight.w700)),
                Expanded(child: Container()),
                Icon(Icons.arrow_back_ios, size: 20.0, color: AppColors.homePageIcons),
                const SizedBox(width: 10.0),
                Icon(Icons.calendar_today_outlined, size: 20.0, color: AppColors.homePageIcons),
                const SizedBox(width: 10.0),
                Icon(Icons.arrow_forward_ios, size: 20.0, color: AppColors.homePageIcons),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                Text("Your program", style: TextStyle(fontSize: 20.0, color: AppColors.homePageSubtitle, fontWeight: FontWeight.w700)),
                Expanded(child: Container()),
                Text("Details", style: TextStyle(fontSize: 20.0, color: AppColors.homePageDetail)),
                const SizedBox(width: 5.0),
                Icon(Icons.arrow_forward, size: 20.0, color: AppColors.homePageIcons),
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 220.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gradientFirst.withOpacity(0.8),
                    AppColors.gradientSecond.withOpacity(0.9)
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(80.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 10),
                    blurRadius: 20.0,
                    color: AppColors.gradientSecond.withOpacity(0.2)
                  )
                ]
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Next workout", style: TextStyle(color: AppColors.homePageContainerTextSmall, fontSize: 16.0)),
                    const SizedBox(height: 5.0),
                    Text("Legs Toning", style: TextStyle(color: AppColors.homePageContainerTextSmall, fontSize: 25.0)),
                    const SizedBox(height: 5.0),
                    Text("and Glutes Workout", style: TextStyle(color: AppColors.homePageContainerTextSmall, fontSize: 25.0)),
                    const SizedBox(height: 10.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer_outlined, size: 20, color: AppColors.homePageContainerTextSmall),
                            const SizedBox(width: 5.0,),
                            Text("60 min", style: TextStyle(color: AppColors.homePageContainerTextSmall, fontSize: 14.0)),
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60.0),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gradientFirst,
                                blurRadius: 10.0,
                                offset: const Offset(4, 8)
                              )
                            ]
                          ),
                          child: Icon(Icons.play_circle_fill, size: 60, color: AppColors.homePageContainerTextSmall)
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              height: 180.0,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 30.0),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: const DecorationImage(image: AssetImage("assets/card.jpg"), fit: BoxFit.fill),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40.0,
                          offset: const Offset(8, 10),
                          color: AppColors.gradientSecond.withOpacity(0.2)
                        ),
                        BoxShadow(
                          blurRadius: 10.0,
                          offset: const Offset(-1, -5),
                          color: AppColors.gradientSecond.withOpacity(0.2)
                        )
                      ]
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    margin: const EdgeInsets.only(right: 200.0, bottom: 70.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: const DecorationImage(image: AssetImage("assets/figure.png")),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 100.0,
                    margin: const EdgeInsets.only(left: 150.0, top: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("You are doing great", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: AppColors.homePageDetail)),
                        const SizedBox(height: 20.0,),
                        RichText(
                          text: TextSpan(
                            text: "keep it up\n", 
                            style: TextStyle(color: AppColors.homePagePlanColor, fontSize: 16.0),
                            children: [
                              TextSpan(
                                text: "stick to your plan", 
                                style: TextStyle(color: AppColors.homePagePlanColor, fontSize: 16.0),
                              )
                            ]
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );  
  }
}