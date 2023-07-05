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
            )
          ],
        ),
      ),
    );  
  }
}