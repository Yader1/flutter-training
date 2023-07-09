import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_app/src/colors.dart';

import 'homePage.dart';

class InfoVideoPage extends StatefulWidget {
  const InfoVideoPage({Key? key}) : super(key: key);

  @override
  State<InfoVideoPage> createState() => _InfoVideoPageState();
}

class _InfoVideoPageState extends State<InfoVideoPage> {
  List videoInfo = [];
  _initData() async {
    await DefaultAssetBundle.of(context).loadString("json/videoInfo.json").then((value){
      videoInfo = json.decode(value);
    });
    log("SALIDA ${videoInfo.length}");
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientFirst.withOpacity(0.9),
              AppColors.gradientSecond
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: (){
                            Get.to(()=>HomePage());
                          },
                          child: Icon(Icons.arrow_back_ios, color: AppColors.secondPageIconColor, size: 20.0)
                      ),
                      Expanded(child: Container()),
                      Icon(Icons.info_outline, color: AppColors.secondPageIconColor, size: 20.0),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Text("Legs Toning", style: TextStyle(color: AppColors.secondPageTitleColor, fontSize: 25.0)),
                  const SizedBox(height: 5.0),
                  Text("and Glutes Workout", style: TextStyle(color: AppColors.secondPageTitleColor, fontSize: 25.0)),
                  const SizedBox(height: 50.0),
                  Row(
                    children: [
                      Container(
                        width: 90.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                            colors: [
                              AppColors.secondPageContainerGradient1stColor,
                              AppColors.secondPageContainerGradient2stColor
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer_outlined, size: 20, color: AppColors.secondPageIconColor),
                            const SizedBox(width: 5.0,),
                            Text("60 min", style: TextStyle(color: AppColors.secondPageIconColor, fontSize: 16.0)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20.0,),
                      Container(
                        width: 220.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                                colors: [
                                  AppColors.secondPageContainerGradient1stColor,
                                  AppColors.secondPageContainerGradient2stColor
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.handyman_outlined, size: 20, color: AppColors.secondPageIconColor),
                            const SizedBox(width: 5.0,),
                            Text("Resistent band, kettebell", style: TextStyle(color: AppColors.secondPageIconColor, fontSize: 16.0)),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70.0))
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  Row(
                    children: [
                      const SizedBox(width: 30.0),
                      Text("Circuit 1: Legs Toning", style: TextStyle(color: AppColors.circuitsColor, fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Icon(Icons.loop, size: 30, color: AppColors.loopColor),
                          const SizedBox(width: 10.0,),
                          Text("3 sets", style: TextStyle(color: AppColors.setsColor, fontSize: 15.0)),
                        ],
                      ),
                      const SizedBox(width: 20.0,),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    itemCount: videoInfo.length,
                      itemBuilder: (_, int index){
                        return GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                            height: 135.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(videoInfo[index]["thumbnail"]),
                                          fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      children: [
                                        Text(videoInfo[index]["title"], style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 10.0),
                                        Padding(
                                            padding: const EdgeInsets.only(top: 3.0),
                                            child: Text(videoInfo[index]["time"], style: TextStyle(color: Colors.grey[500]))
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  ))
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}