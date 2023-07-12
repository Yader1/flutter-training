// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_app/src/colors.dart';
import 'package:video_player/video_player.dart';

import 'homePage.dart';

class InfoVideoPage extends StatefulWidget {
  const InfoVideoPage({Key? key}) : super(key: key);

  @override
  State<InfoVideoPage> createState() => _InfoVideoPageState();
}

class _InfoVideoPageState extends State<InfoVideoPage> {
  bool _playArea = false;
  List videoInfo = [];
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  VideoPlayerController? _videoPlayerController;

  _initData() async {
    await DefaultAssetBundle.of(context).loadString("json/videoInfo.json").then((value){
      setState((){
        videoInfo = json.decode(value);
      });
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
        decoration: _playArea == false ? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientFirst.withOpacity(0.9),
              AppColors.gradientSecond
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight
          )
        ) : BoxDecoration(
          color: AppColors.gradientSecond
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _playArea == false ? Container(
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
            ) : Container(
              child: Column(
                children: [
                  Container(
                    height: 100.0,
                    padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){

                          },
                          child: Icon(Icons.arrow_back_ios, size: 20.0, color: AppColors.secondPageTopIconColor),
                        ),
                        Expanded(child: Container()),
                        Icon(Icons.info_outline, size: 20.0, color: AppColors.secondPageTopIconColor),
                      ],
                    ),
                  ),
                  _playView(context),
                  _controlView(context),
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
                  Expanded(child: _listView())
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _playView(BuildContext context){
    final controller = _videoPlayerController;

    if(controller != null && controller.value.isInitialized){
      return AspectRatio(
        aspectRatio: 16/9,
        child: VideoPlayer(controller),
      );
    }else{
      return const AspectRatio(
          aspectRatio: 16/9,
          child: Center(
              child: Text("Preparing...", style: TextStyle(fontSize: 20.0, color: Colors.white60))
          )
      );
    }
  }

  var _onUpdateControllerTime;
  void _onControllerUpdate() async {
    if(_disposed){
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().microsecondsSinceEpoch;

    if(_onUpdateControllerTime > now){
      return;
    }

    _onUpdateControllerTime = now+500;

    final controller = _videoPlayerController;
    if(controller == null){
      return;
    }

    if(!controller.value.isInitialized){
      return;
    }

    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _initializeVideo(int index){
    final controller = VideoPlayerController.network(videoInfo[index]["videoUrl"]);
    final old = _videoPlayerController;
    _videoPlayerController = controller;

    if(old != null){
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller..initialize().then((_){
      old?.dispose();
      _isPlayingIndex = index;
      controller.addListener(_onControllerUpdate);
      controller.play();
      setState(() {});
    });
  }

  _onTapVideoView(int index){
    _initializeVideo(index);
  }

  Widget _controlView(BuildContext context){
    final noMute = (_videoPlayerController?.value?.volume??0)>0;
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 5.0),
      color: AppColors.gradientSecond,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(50, 0, 0, 0),
                    )
                  ]
                ),
                child: Icon(
                  noMute ? Icons.volume_up : Icons.volume_off,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: (){
              if(noMute){
                _videoPlayerController?.setVolume(0);
              }else{
                _videoPlayerController?.setVolume(1.0);
              }
              setState(() {});
            },
          ),
          IconButton(
            onPressed: () async {
              final index = _isPlayingIndex-1;

              if(index >= 0 && videoInfo.length >= 0){
                _initializeVideo(index);
              }else{
                Get.snackbar(
                  "Video List", "",
                  snackPosition: SnackPosition.BOTTOM,
                  icon: const Icon(Icons.face, size: 30.0, color: Colors.white),
                  backgroundColor: AppColors.gradientSecond,
                  colorText: Colors.white,
                  messageText: const Text("No videos ahead !", style: TextStyle(fontSize: 20.0, color: Colors.white)),
                );
              }
            },
            icon: const Icon(Icons.fast_rewind, size: 36.0, color: Colors.white),
          ),
          IconButton(
            onPressed: () async {
              if(_isPlaying){
                setState(() {
                  _isPlaying = false;
                });
                _videoPlayerController?.pause();
              }else{
                setState(() {
                  _isPlaying = true;
                });
                _videoPlayerController?.play();
              }
            },
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 36.0, color: Colors.white),
          ),
          IconButton(
            onPressed: () async {
              final index = _isPlayingIndex+1;

              if(index <= videoInfo.length-1){
                _initializeVideo(index);
              }else{
                Get.snackbar(
                  "Video List", "",
                  snackPosition: SnackPosition.BOTTOM,
                  icon: const Icon(Icons.face, size: 30.0, color: Colors.white),
                  backgroundColor: AppColors.gradientSecond,
                  colorText: Colors.white,
                  messageText: const Text("You have finished watching all the videos. Congrats !", style: TextStyle(fontSize: 20.0, color: Colors.white)),
                );
              }
            },
            icon: const Icon(Icons.fast_forward, size: 36.0, color: Colors.white),
          ),
        ],
      ),
    );
  }

  _listView(){
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        itemCount: videoInfo.length,
        itemBuilder: (_, int index){
          return GestureDetector(
            onTap: (){
              _onTapVideoView(index);
              setState(() {
                if(_playArea == false){
                  _playArea = true;
                }
              });
            },
            child: _buildCard(index),
          );
        }
    );
  }

  _buildCard(int index){
    return Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          const SizedBox(height: 18.0),
          Row(
            children: [
              Container(
                width: 80.0,
                height: 20.0,
                decoration: BoxDecoration(
                    color: const Color(0xFFeaeefc),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: const Center(child: Text("15s rest", style: TextStyle(fontSize: 14.0, color: Color(0xFF839fed)))),
              ),
              Row(
                children: [
                  for(int i = 0; i < 70; i++)
                    i.isEven ? Container(
                      width: 3.0,
                      height: 1.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFF839fed),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ) : Container(
                      width: 3.0,
                      height: 1.0,
                      color: Colors.white,
                    ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _disposed = true;
    _videoPlayerController?.pause();
    _videoPlayerController?.dispose();
    _videoPlayerController = null;
    super.dispose();
  }
}