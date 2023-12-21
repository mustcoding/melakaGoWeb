import 'package:flutter/material.dart';
//import 'package:melakago_web/Model/tourismService.dart';
import 'package:melakago_web/widgets/navigation_bar/navigationLogin_Web_SA.dart';

import '../../Model/appUser.dart';

class HomePageViewWebSA extends StatelessWidget {
  late final appUser user;
  HomePageViewWebSA({required this.user}) : nickName = user.nickName!;
  String nickName = '';
  int? totalUsers;
  int? internationalUsers;
  int? localUsers;
  int? activeUsers;

  static const containerWidth = 270.0;
  static const containerHeight = 104.0;

  Future<void> SAcountTS(int roleId/*serviceId*/) async{
    totalUsers = await user.getCountByRoleId(roleId);
    localUsers = await user.getLocalUsersCount('Malaysia', roleId);
    internationalUsers = await user.getInternationalUsersCount('Other than Malaysia',roleId);
    activeUsers = await user.getCountByAccessStatus('ACTIVE',roleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            NavigationLoginWebSA(user: user),
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                          ),
                        ),
                        child: CustomPaint(
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [Colors.orangeAccent, Colors.red],
                              ).createShader(bounds);
                            },
                            child: Text(
                              '   Where History \nWhispers In Every \n   Cobblestone',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    blurRadius: 8.0,
                                    color: Colors.grey,
                                    offset: Offset(3.0, 3.0),
                                  ),
                                ],
                                fontSize: 75,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.amberAccent.shade400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            width: containerWidth,
                            height: containerHeight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey, // Set the background color to grey
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height:6.0),
                                  // Icon and Title
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on, // Replace with your desired icon
                                        size: 40.0,
                                        color: Colors.red.shade400,
                                      ),
                                      SizedBox(width: 25.0),
                                      Text(
                                        'INTERNATIONAL',//TOURIST SPOT
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  FutureBuilder<void>(
                                    future: SAcountTS(6),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // Display the calculatedService after the calculation is complete
                                        return Text(
                                          '${internationalUsers}',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            color: Colors.black,
                                          ),
                                        );
                                      } else {
                                        // Display a loading indicator or placeholder while waiting for the calculation
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 7.0),
                          SizedBox(
                            width: containerWidth,
                            height: containerHeight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey, // Set the background color to grey
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Icon and Title
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.local_activity, // Replace with your desired icon
                                        size: 40.0,
                                        color: Colors.red.shade400,
                                      ),
                                      SizedBox(width: 25.0),
                                      Text(
                                        'LOCAL',//
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  // Number of Tourist Spots
                                  FutureBuilder<void>(
                                    future: SAcountTS(5),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // Display the calculatedService after the calculation is complete
                                        return Text(
                                          '${localUsers}',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            color: Colors.black,
                                          ),
                                        );
                                      } else {
                                        // Display a loading indicator or placeholder while waiting for the calculation
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            width: containerWidth,
                            height: containerHeight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey, // Set the background color to grey
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height:6.0),
                                  // Icon and Title
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.hotel, // Replace with your desired icon
                                        size: 40.0,
                                        color: Colors.red.shade400,
                                      ),
                                      SizedBox(width: 25.0),
                                      Text(
                                        'ACTIVE USERS',//LODGING
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  // Number of Tourist Spots
                                  FutureBuilder<void>(
                                    future: SAcountTS(3),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // Display the calculatedService after the calculation is complete
                                        return Text(
                                          '${activeUsers}',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            color: Colors.black,
                                          ),
                                        );
                                      } else {
                                        // Display a loading indicator or placeholder while waiting for the calculation
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 7.0),
                          SizedBox(
                            width: containerWidth,
                            height: containerHeight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey, // Set the background color to grey
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height:6.0),
                                  // Icon and Title
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.emoji_transportation, // Replace with your desired icon
                                        size: 40.0,
                                        color: Colors.red.shade400,
                                      ),
                                      SizedBox(width: 25.0),
                                      Text(
                                        'TOTAL USERS',//TRANSPORT
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  // Number of Tourist Spots
                                  FutureBuilder<void>(
                                    future: SAcountTS(2),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // Display the calculatedService after the calculation is complete
                                        return Text(
                                          '${totalUsers}',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            color: Colors.black,
                                          ),
                                        );
                                      } else {
                                        // Display a loading indicator or placeholder while waiting for the calculation
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
