import 'package:flutter/material.dart';
import '../../widgets/navigation_bar/navigation_bar_tablet.dart';

class HomeViewTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Column(
            children: <Widget>[
              NavigationBarsTablet(destinations: []),
              SizedBox(height: 80),
              Padding(padding: const EdgeInsets.all(50.0),
                child:
                Column(
                  children: [
                    Row( children: <Widget>[
                      Flexible(
                        child: Image.asset(
                          'assets/MelakaGo.png',
                          width: 220,
                          height: 150,
                        ),
                      ),
                      Flexible(
                        child: Image.asset(
                          'assets/MelakaGo.png',
                          width: 220,
                          height: 150,
                        ),
                      ),
                      Flexible(
                        child: Image.asset(
                          'assets/MelakaGo.png',
                          width: 220,
                          height: 150,
                        ),
                      ),
                    ],),
                    SizedBox(height: 80),
                    Row( children: <Widget>[
                      Flexible(
                        child: Image.asset(
                          'assets/MelakaGo.png',
                          width: 220,
                          height: 150,
                        ),
                      ),
                      Flexible(
                        child: Image.asset(
                          'assets/MelakaGo.png',
                          width: 220,
                          height: 150,
                        ),
                      ),
                      Flexible(
                        child: Image.asset(
                          'assets/MelakaGo.png',
                          width: 220,
                          height: 150,
                        ),
                      ),
                    ],),
                  ],
                ),
              ),
            ],
          ),


    );
  }
}