import 'package:flutter/material.dart';
import 'package:melakago_web/widgets/navigation_bar/navigationLogin_Web_TAC.dart';
import '../../Model/appUser.dart';

class HomePageViewWebTAC extends StatelessWidget {

  late final appUser user;
  HomePageViewWebTAC({required this.user}) : nickName = user.nickName;
  String nickName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            NavigationLoginWebTAC(user: user),
            SizedBox(height: 80),
            Padding(padding: const EdgeInsets.all(50.0),
              child:
              Column(
                children: [
                  Row( children: <Widget>[
                    Text('Where History Whispers In Every Cobblestone'),
                  ],),
                  SizedBox(height: 80),
                  Row( children: <Widget>[
                    Image.asset(
                      'assets/MelakaGo.png',
                      width: 460,
                      height: 350,
                    ),
                    Image.asset(
                      'assets/MelakaGo.png',
                      width: 460,
                      height: 350,
                    ),
                    Image.asset(
                      'assets/MelakaGo.png',
                      width: 460,
                      height: 350,
                    ),
                  ],),
                  SizedBox(height:8),
                  Row( children: <Widget>[
                    Image.asset(
                      'assets/MelakaGo.png',
                      width: 460,
                      height: 350,
                    ),
                    Image.asset(
                      'assets/MelakaGo.png',
                      width: 460,
                      height: 350,
                    ),
                    Image.asset(
                      'assets/MelakaGo.png',
                      width: 460,
                      height: 350,
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