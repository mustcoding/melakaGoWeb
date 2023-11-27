import 'package:flutter/material.dart';
import '../../Model/appUser.dart';
import '../../views/login.dart';
import '../../views/signUp.dart';

class NavigationLoginWebBSDC extends StatelessWidget {

  final appUser user;

  NavigationLoginWebBSDC({super.key, required this.user});

  void _AlertMessage1(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _AlertMessage2(context, "Lets Confirm it again, \n "
                    "Are You Sure To Deactivate Your Account?");
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                // Handle the action for the second button (YES)
                // You can add your logic here
                Navigator.of(context).pop(); // Close the dialog if needed
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _AlertMessage2(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: ()=>_deactivateAccount(context),
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                // Handle the action for the second button (YES)
                // You can add your logic here
                Navigator.of(context).pop(); // Close the dialog if needed
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _AlertMessage3(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text(msg),
        );
      },
    );
  }

  void _deactivateAccount(BuildContext context) async{
    final List<appUser> admin= [];

    int appUserId=user.appUserId;
    String firstName=user.firstName;
    String lastName=user.lastName;
    String nickName=user.nickName;
    String dateOfBirth=user.dateOfBirth;
    String email = user.email;
    String password = user.password;
    String phoneNumber=user.phoneNumber;
    String accessStatus=user.accessStatus;
    String country=user.country;
    int roleId=user.roleId;

    if(email.isNotEmpty && appUserId!=null)
    {
      appUser user = appUser (appUserId, firstName, lastName, nickName, dateOfBirth,
          phoneNumber,email, password, accessStatus,
          country, roleId);

      if ( await user.deleteUser()) {
        _AlertMessage3(context, "NOTE: Account Successfully Deactivate");
        Future.delayed(Duration(seconds: 2), () {
          // Navigate to the login screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => signIn()),
          );
        });
      }
      else{
        _AlertMessage3(context, "NOTE: Account Unsuccessful To Deactivate");
      }
    }

  }

  List<String> settingMenu = [
    'Update Profile',
    'Deactivate Account',
    'Sign Out',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen.shade700,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 20), // Adjust as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                'Business Spot Data Collector Admin',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Hi, ${user.nickName}",
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(width:15.0),
              PopupMenuButton<String>(
                icon: Icon(Icons.person, size: 23,),
                itemBuilder: (BuildContext context){
                  return settingMenu.map((String item){
                    return PopupMenuItem(
                      value: item,
                      child: Text(item),);
                  }).toList();
                },
                onSelected: (String value){
                  if(value == 'Update Profile'){
                    Navigator.push(
                      context, MaterialPageRoute(builder:(context)=>signUp(),
                    ),
                    );
                  }
                  if(value == 'Deactivate Account'){

                    _AlertMessage1(context, "Are You Sure To Deactivate"
                        " Your Account?");

                  }
                  if(value == 'Sign Out'){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => signIn()),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

}

