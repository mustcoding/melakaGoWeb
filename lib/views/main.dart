import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'home/home_view_mobile.dart';
import 'home/home_view_tablet.dart';
import 'home/home_view_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ResponsiveBuilder(
        builder: (context, sizingInformation){
          // Check the sizing information here and return your UI
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return HomeViewWeb();
          } else if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
            return HomeViewTablet();
          } else if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return HomeViewMobile();
          } else {
            return Container(color: Colors.purple);
          }
        },
      ),
    );
  }
}