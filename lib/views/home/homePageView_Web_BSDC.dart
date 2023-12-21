import 'package:flutter/material.dart';
import 'package:melakago_web/Model/tourismService.dart';
import 'package:melakago_web/widgets/navigation_bar/navigationLogin_Web_BSDC.dart';

import '../../Model/appUser.dart';

class HomePageViewWebBSDC extends StatelessWidget {
  late final appUser user;
  HomePageViewWebBSDC({required this.user}) : nickName = user.nickName!;
  String nickName = '';
  int? touristSpot;
  int? shopping;
  int? transport;
  int? lodging;
  int? restaurant;
  int? activity;

  static const containerWidth = 270.0;
  static const containerHeight = 104.0;

  Future<void> countTS(int serviceId) async{

        int tourismServiceId=0;
        String companyName='';
        String companyAddress='';
        String businessContactNumber='';
        String email='';
        String businessStartHour='';
        String businessEndHour='';
        String faxNumber='';
        String instagram='';
        String xTwitter='';
        String thread='';
        String facebook='';
        String businessLocation='';
        int starRating=0;
        String businessDescription='';
        int tsId=serviceId;
        int isDelete=0;

            tourismService service=tourismService (tourismServiceId,
            companyName,companyAddress,businessContactNumber, email,
            businessStartHour, businessEndHour, faxNumber,instagram, xTwitter,
            thread,facebook, businessLocation, starRating, businessDescription,
            tsId, isDelete);

            if(tsId==1){
              shopping=(await service.calculate()) as int?;
            }
            else if(tsId==2){
              transport=(await service.calculate()) as int?;
            }
            else if(tsId==3){
              lodging=(await service.calculate()) as int?;
            }
            else if(tsId==4){
              restaurant=(await service.calculate()) as int?;
            }
            else if(tsId==5){
              activity=(await service.calculate()) as int?;
            }
            else if(tsId==6){
              touristSpot=(await service.calculate()) as int?;
            }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            NavigationLoginWebBSDC(user: user),
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
                                        'TOURIST SPOT',
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
                                    future: countTS(6),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // Display the calculatedService after the calculation is complete
                                        return Text(
                                          '${touristSpot}',
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
                                        Icons.local_activity, // Replace with your desired icon
                                        size: 40.0,
                                        color: Colors.red.shade400,
                                      ),
                                      SizedBox(width: 25.0),
                                      Text(
                                        'ACTIVITIES',
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
                                    future: countTS(5),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // Display the calculatedService after the calculation is complete
                                        return Text(
                                          '${activity}',
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
                                        Icons.restaurant, // Replace with your desired icon
                                        size: 40.0,
                                        color: Colors.red.shade400,
                                      ),
                                      SizedBox(width: 25.0),
                                      Text(
                                        'RESTAURANT',
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
                                    future: countTS(4),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // Display the calculatedService after the calculation is complete
                                        return Text(
                                          '${restaurant}',
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
                                        'LODGING',
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
                                    future: countTS(3),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // Display the calculatedService after the calculation is complete
                                        return Text(
                                          '${lodging}',
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
                                        'TRANSPORT',
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
                                    future: countTS(2),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // Display the calculatedService after the calculation is complete
                                        return Text(
                                          '${transport}',
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
                                        Icons.storefront_rounded, // Replace with your desired icon
                                        size: 40.0,
                                        color: Colors.red.shade400,
                                      ),
                                      SizedBox(width: 25.0),
                                      Text(
                                        'SHOPPING',
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
                                    future: countTS(1),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        // Display the calculatedService after the calculation is complete
                                        return Text(
                                          '${shopping}',
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

