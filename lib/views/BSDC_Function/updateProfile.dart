import 'package:flutter/material.dart';
import 'package:melakago_web/views/home/homePageView_Web_BSDC.dart';

import '../../Model/appUser.dart';
import '../login.dart';


class updateProfilePage extends StatefulWidget {
  late appUser user;

  updateProfilePage({Key? key, required appUser user}) : super(key: key) {
    this.user = user;
  }


  @override
  State<updateProfilePage> createState() => _updateProfilePageState();
}

class _updateProfilePageState extends State<updateProfilePage> {
  int appUserId=0;
  int roleId=0;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController nickNameController;
  late TextEditingController dateOfBirthController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneNumberController;
  late TextEditingController countryController;
  late TextEditingController adminRoleController;
  late TextEditingController DOBController;

  DateTime? selectedDate;
  String? selectedCountry;
  String? role;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    nickNameController = TextEditingController();
    dateOfBirthController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();
    countryController = TextEditingController();
    adminRoleController = TextEditingController();


    // Initialize the user field here
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    nickNameController.text = widget.user.nickName;
    dateOfBirthController.text = widget.user.dateOfBirth;
    emailController.text = widget.user.email;
    passwordController.text = widget.user.password;
    phoneNumberController.text = widget.user.phoneNumber;
    countryController.text = widget.user.country ;
    adminRoleController.text = widget.user.roleId.toString();
    appUserId = widget.user.appUserId;
    roleId = widget.user.roleId;


    if (adminRoleController.text=="1"){
      adminRoleController.text = "System Admin" ;
    }
    else if (adminRoleController.text=="2"){
      adminRoleController.text="Business Spot Data Collector";
    }
    else if (adminRoleController.text=="3"){
      adminRoleController.text="Tourist Activity Curator";
    }

  }


  void _editAdmin() async{

    final String firstName = firstNameController.text.trim();
    final String lastName = lastNameController.text.trim();
    final String nickName = nickNameController.text.trim();
    final String dateOfBirth = dateOfBirthController.text.trim();
    final String email = emailController.text.trim();
    final String password=passwordController.text.trim();
    final String phoneNumber=phoneNumberController.text.trim();
    final String selectedCountry = countryController.text.trim();
    final String accessStatus = 'ACTIVE';

    appUser user = appUser (appUserId,firstName, lastName, nickName,
       dateOfBirth, phoneNumber,email, password, accessStatus,
     selectedCountry, roleId);

    if ( await user.updateProfile()) {
      _AlertMessage(context, "NOTE: Profile Successfully Updated");
      Future.delayed(Duration(seconds: 2), () {
        // Navigate to the login screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageViewWebBSDC(user: user)),
        );
      });
    }
    else{
      _AlertMessage(context, "NOTE: Profile Unsuccessful Updated");
    }

  }

  void _AlertMessage(BuildContext context, String msg) {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Center(child: const Text('Profile Update',
            style: TextStyle(fontWeight: FontWeight.bold)),),
        backgroundColor: Colors.lightGreen.shade700,
      ),
      body: SingleChildScrollView(
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              SizedBox(height: 80),
              Text("Lets Become a MelakaGoer !",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
              SizedBox(height: 30),

              ClipOval(
                child: Image.asset(
                  'assets/MelakaGo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover, // This ensures that the image covers the circular area
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300.0, // Set the width to the desired value
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'First Name', // Your label text
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: TextField(
                              controller: firstNameController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 300.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last Name', // Your label text
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0), // Add some space between the label and the text field
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: TextField(
                              controller: lastNameController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 600.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nick Name', // Your label text
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0), // Add some space between the label and the text field
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextField(
                          controller: nickNameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date of Birth', // Your label text
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0), // Add some space between the label and the text field
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: TextField(
                              controller: dateOfBirthController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 300.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Country', // Your label text
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0), // Add some space between the label and the text field
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: TextField(
                              controller: countryController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width:300,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number', // Your label text
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0), // Add some space between the label and the text field
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: TextField(
                              controller: phoneNumberController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 300.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Admin Role', // Your label text
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0), // Add some space between the label and the text field
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: TextField(
                              controller: adminRoleController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 600.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email', // Your label text
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0), // Add some space between the label and the text field
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 600.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password', // Your label text
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0), // Add some space between the label and the text field
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: _editAdmin,
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen.shade700, // Set your desired background color here
                ),
                child: const Text('Edit Profile',
                    style: TextStyle(fontSize: 18.0,
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
