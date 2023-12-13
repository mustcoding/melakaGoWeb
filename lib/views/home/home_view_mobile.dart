import 'package:flutter/material.dart';
import '../../widgets/navigation_bar/navigation_bar_mobile.dart';

class HomeViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
        SingleChildScrollView(
          child: Column(
              children: <Widget>[
                NavigationBarsMobile(destinations: []),
                SizedBox(height: 80),
                Padding(padding: const EdgeInsets.all(50.0),
                  child:
                  Column(
                    children: [
                      Row(
                        children: <Widget>[
                        Flexible(
                          child: Image.asset(
                            'assets/MelakaGo.png',
                            width: 460,
                            height: 350,
                          ),
                        ),
                        Flexible(
                          child: Image.asset(
                            'assets/MelakaGo.png',
                            width: 460,
                            height: 350,
                          ),
                        ),
                        Flexible(
                          child: Image.asset(
                            'assets/MelakaGo.png',
                            width: 460,
                            height: 350,
                          ),
                        ),
                      ],),
                      SizedBox(height: 80),
                      Row( children: <Widget>[
                        Flexible(
                          child: Image.asset(
                            'assets/MelakaGo.png',
                            width: 460,
                            height: 350,
                          ),
                        ),
                        Flexible(
                          child: Image.asset(
                            'assets/MelakaGo.png',
                            width: 460,
                            height: 350,
                          ),
                        ),
                        Flexible(
                          child: Image.asset(
                            'assets/MelakaGo.png',
                            width: 460,
                            height: 350,
                          ),
                        ),
                      ],),
                    ],
                  ),
                ),
              ],
            ),
        ),

    );
  }
}