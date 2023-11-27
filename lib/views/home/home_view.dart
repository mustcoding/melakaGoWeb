import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'home_view_mobile.dart';
import 'home_view_tablet.dart';
import 'home_view_web.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            NavigationBar(destinations: []),
            Expanded(child: ScreenTypeLayout(
              mobile: HomeViewMobile(),
              tablet: HomeViewTablet(),
              desktop: HomeViewWeb(),
            )),
          ],
        ),
      ),
    );
  }
}