
import 'package:flutter/material.dart';
import '../../views/login.dart';
import '../../views/signUp.dart';

class NavigationBarsTablet extends StatelessWidget {
  final List<String> destinations;

  const NavigationBarsTablet({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen.shade700,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 20), // Adjust as needed
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipOval(
              child: Image.asset(
                'assets/MelakaGo.png',
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Welcome to MelakaGo',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton(onPressed:(){

                }, style: TextButton.styleFrom(
                  primary: Colors.black, // text color
                ),
                  child:
                  Text('About Us',style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                SizedBox(width: 25),
                TextButton(onPressed:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:(context)=>signIn(),));

                },style: TextButton.styleFrom(
                  primary: Colors.black, // text color
                ),
                  child:
                  Text('Sign In',style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                SizedBox(width: 25),
                TextButton(onPressed:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:(context)=>signUp(),));
                },style: TextButton.styleFrom(
                  primary: Colors.black, // text color
                ),
                  child:
                  Text('Sign Up',style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                SizedBox(width: 25),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

