//import 'package:flutter/cupertino.dart';
//import 'dart:js';

import 'package:flutter/material.dart';
//import 'package:melakago_web/widgets/navigation_bar/navigationLogin_Web_SA.dart';
import '../../Model/appUser.dart';
//import '../../views/login.dart';
//import '../../views/signUp.dart';

class SettingsPageSA extends StatefulWidget {
  late appUser user;

  SettingsPageSA({Key? key, required this.user}) : super(key: key);
  //SettingsPageSA({Key? key, required this.settingsUser, required this.user}) : super(key: key);

  @override
  _SettingsPageSAState createState() => _SettingsPageSAState();
// Method to show the update profile confirmation dialog
/*showUpdateProfileConfirmation(BuildContext context)
  {showUpdateProfileConfirmation(context);}*/

}

class _SettingsPageSAState extends State<SettingsPageSA> {

  //late appUser user;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController dateOfBirthController;
  late TextEditingController countryController;
  late TextEditingController nickNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    //_showUpdateProfileConfirmation(context);
    /// Initialize controllers and set initial values
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    dateOfBirthController = TextEditingController();
    countryController = TextEditingController();
    nickNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();

    // Set initial values for nickname and phone number
    firstNameController.text = widget.user.firstName!;
    lastNameController.text = widget.user.lastName!;
    dateOfBirthController.text = widget.user.dateOfBirth!;
    countryController.text = widget.user.country!;
    nickNameController.text = widget.user.nickName!;
    phoneNumberController.text = widget.user.phoneNumber!;
    passwordController.text = widget.user.password!;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),*/
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Update Profile'),
              onTap: () {
                // Handle 'Update Profile' tap
                //_showUpdateProfileDialog(context);
                _showUpdateProfileConfirmation(context);
                // You can navigate to the update profile page or perform any action
              },
            ),
            /*ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              onTap: () {
               // _showChangePasswordDialog(context);
                // Handle 'Change Password' tap
                // You can navigate to the change password page or perform any action
              },
            ),
            Divider(), // Add a divider for visual separation

            Text(
              'Account Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                //marginTop: 16,
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Deactivate Account'),
              onTap: () {
                //_AlertMessage1(context, "Are You Sure To Deactivate\n" " Your Account?");
               // _showDeactivateConfirmation(context);
                // You can show a confirmation dialog or perform any action
              },
            ),
            Divider(), // Add a divider for visual separation

            Text(
              'App Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                //marginTop: 16,
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                // Handle 'Notifications' tap
                // You can navigate to the notifications settings page or perform any action
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              onTap: () {
                // Handle 'Language' tap
                // You can navigate to the language settings page or perform any action
              },
            ),*/
            // Add more settings as needed
          ],
        ),
      ),
    );
  }

  void _showUpdateProfileConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update Profile"),
          content: Text("Are you sure you want to update your profile?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation dialog
                _showUpdateProfileDialog(context);
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
  void _showUpdateProfileDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update Profile"),
          content: Column(
            children: [
              TextField(
                controller: firstNameController,
                readOnly: true,
                decoration: InputDecoration(labelText: 'First Name '),
              ),
              TextField(
                controller: lastNameController,
                readOnly:true,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: nickNameController,
                decoration: InputDecoration(labelText: 'Nick Name'),
              ),
              TextField(
                controller: dateOfBirthController,
                readOnly:true,
                decoration: InputDecoration(labelText: 'Date of Birth'),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: countryController,
                readOnly:true,
                decoration: InputDecoration(labelText: 'Country'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                // Validate and update profile
                if (_validateProfileData(
                  nickNameController.text,
                  phoneNumberController.text,
                  passwordController.text,
                )) {
                  await _updateUserProfile(
                    nickName: nickNameController.text,
                    phoneNumber: phoneNumberController.text,
                    password:passwordController.text,
                  );
                  _showProfileUpdateSuccess(context);
                } else {
                  _showProfileUpdateFailure(context);
                }
              },
              child: Text("Update Profile"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  bool _validateProfileData(String nickName, String phoneNumber, String password) {
    if (nickName.isEmpty || phoneNumber.isEmpty ||password.isEmpty ) {
      return false;
    }
    return true;
  }

  Future<void> _updateUserProfile({
    required String nickName,
    required String phoneNumber,
    required String password
  }) async {
    try {
      // Set the new values for nickname and phone number
      widget.user.nickName = nickName;
      widget.user.phoneNumber = phoneNumber;
      widget.user.password=password;

      // Call the save method to persist the changes on the server
      bool profileUpdated = await widget.user.profilesave();

      if (profileUpdated) {
        // Handle success
        print("Profile updated successfully");
      } else {
        // Handle failure
        print("Failed to update profile");
      }
    } catch (e) {
      // Handle errors, log them, and show an error message
      print("Error updating profile: $e");
      _showProfileUpdateFailure(context);
    }
  }


  void _showProfileUpdateSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update Profile"),
          content: Text("Profile updated successfully."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the success dialog
                Navigator.of(context).pop(); // Close the update profile dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showProfileUpdateFailure(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update Profile"),
          content: Text("Failed to update profile. Please try again."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the failure dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

