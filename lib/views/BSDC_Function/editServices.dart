import 'dart:html';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:melakago_web/Model/tourismService.dart';
import 'package:melakago_web/Model/tourismServiceImage.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:melakago_web/views/BSDC_Function/showServices.dart';

import '../../Model/appUser.dart';


class editServices extends StatefulWidget {

  final List<tourismService>? services;
  final int ? index;

  editServices({required int? index, required List<tourismService>? services})
      : index = index,
        services = services;

  @override
  State<editServices> createState() => _editServicesState(index!, services!);
}

class _editServicesState extends State<editServices> {

  late appUser user;

  final int ? index;
  final List<tourismService>? services;
  String base64String='';
  String images='';
  String getImages='';
  int btypes=0;
  int? tourismServiceId=0;
  Uint8List? gambar;
  int isDelete=0;

  _editServicesState(this.index, this.services);

  late TextEditingController tourismServiceIdController;
  late TextEditingController companyNameController;
  late TextEditingController companyAddressController;
  late TextEditingController businessContactNumberController;
  late TextEditingController emailController;
  late TextEditingController businessStartHourController;
  late TextEditingController businessEndHourController;
  late TextEditingController faxNumberController;
  late TextEditingController instagramController;
  late TextEditingController xTwitterController;
  late TextEditingController threadController;
  late TextEditingController facebookController;
  late TextEditingController businessLocationController;
  late TextEditingController starRatingController;
  late TextEditingController businessDescriptionController;
  late TextEditingController tsIdController;

  @override
  void initState() {
    super.initState();
    companyNameController = TextEditingController(text: services![index!].companyName);
    companyAddressController = TextEditingController(text: services![index!].companyAddress);
    businessContactNumberController = TextEditingController(text: services![index!].businessContactNumber);
    emailController = TextEditingController(text: services![index!].email);
    businessStartHourController = TextEditingController(text: services![index!].businessStartHour);
    businessEndHourController = TextEditingController(text: services![index!].businessEndHour);
    faxNumberController = TextEditingController(text: services![index!].faxNumber);
    instagramController = TextEditingController(text: services![index!].instagram);
    xTwitterController = TextEditingController(text: services![index!].xTwitter);
    threadController = TextEditingController(text: services![index!].thread);
    facebookController = TextEditingController(text: services![index!].facebook);
    businessLocationController = TextEditingController(text: services![index!].businessLocation);
    starRatingController = TextEditingController(text: services![index!].starRating.toString());
    businessDescriptionController = TextEditingController(text: services![index!].businessDescription);
    tsIdController = TextEditingController(text: services![index!].tsId.toString());

    tourismServiceId = services![index!].tourismServiceId;

    print("WOI: ${companyNameController.text}");

    if (tsIdController.text=="1"){
      tsIdController.text = "Shopping" ;
    }
    else if (tsIdController.text=="2"){
      tsIdController.text="Transport";
    }
    else if (tsIdController.text=="3"){

      tsIdController.text="Lodging";
    }
    else if (tsIdController.text=="4"){
      tsIdController.text="Restaurant";
    }
    else if (tsIdController.text=="5"){
      tsIdController.text="Activity";
    }
    else if (tsIdController.text=="6"){
      tsIdController.text="Tourist Spot";
    }
  }

  Future<bool> loadImages() async {
    int imageId = 0;
    tourismServiceImage serviceImage = tourismServiceImage(imageId, images, tourismServiceId!);
    if (await serviceImage.getImage()) {
      getImages = serviceImage.image;
      getImages = getImages.replaceAll("\\", "");
      print("Images WOI: ${getImages}");
      return true;
    } else {
      getImages = "";
      return false;
    }
  }

  String? types;
  final PageController _pageController = PageController();

  List<Uint8List> selectedImages = [];

  List<String> servicesType = [
    'Shopping',
    'Transport',
    'Lodging',
    'Restaurant',
    'Activity',
    'Tourist Spot',
  ];

  void _editServices() async{
    final List<tourismService> service= [];
    final String companyName = companyNameController.text.trim();
    final String companyAddress = companyAddressController.text.trim();
    final String businessContactNumber= businessContactNumberController.text.trim();
    final String email = emailController.text.trim();
    final String businessStartHour = businessStartHourController.text.trim();
    final String businessEndHour=businessEndHourController.text.trim();
    final String faxNumber=faxNumberController.text.trim();
    final String instagram = instagramController.text.trim();
    final String xTwitter = xTwitterController.text.trim();
    final String thread = threadController.text.trim();
    final String facebook = facebookController.text.trim();
    final String businessLocation = businessLocationController.text.trim();
    final int starRating = int.parse(starRatingController.text.trim()) ;
    final String businessDescription = businessDescriptionController.text.trim();
    final String businessType = tsIdController.text.trim();

    if (businessType == "Shopping"){
      btypes = 1;
    }
    else if (businessType == "Transport"){
      btypes = 2;
    }
    else if(businessType == "Lodging"){
      btypes = 3;
    }
    else if (businessType == "Restaurant"){
      btypes = 4;
    }
    else if (businessType == "Activity")
    {
        btypes = 5;
    }
    else if (businessType == "Tourist Spot"){
      btypes = 6;
    }


    if (companyName.isNotEmpty && companyAddress.isNotEmpty &&
        businessStartHour.isNotEmpty && businessEndHour.isNotEmpty &&
        businessLocation.isNotEmpty && businessDescription.isNotEmpty
        && btypes != null ) {

      tourismService services = tourismService (tourismServiceId,companyName,
          companyAddress, businessContactNumber,
          email, businessStartHour,businessEndHour, faxNumber, instagram,
          xTwitter, thread, facebook, businessLocation,starRating,
          businessDescription, btypes, isDelete);

      if (await services.updateService()){
        _AlertMessage("Tourism Service Has Been Updated");
        Future.delayed(Duration(seconds: 1), () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => showServices(user:user)),
          );
        });
      }
      else{
        _AlertMessage("Update Failed!!");
      }
    }
    else{
      _AlertMessage("Please Insert All The Information Needed");
      setState(() {
        companyNameController.clear();
        companyAddressController.clear();
        businessContactNumberController.clear();
        emailController.clear();
        businessStartHourController.clear();
        businessEndHourController.clear();
        faxNumberController.clear();
        instagramController.clear();
        xTwitterController.clear();
        threadController.clear();
        facebookController.clear();
        businessLocationController.clear();
        starRatingController.clear();
        businessDescriptionController.clear();
        types = null; // Set selectedCountry to null
      });
    }
  }

  void _AlertMessage(String msg) {
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
        toolbarHeight:90,
        title: Center(child: const Text('Update Tourism Service',
            style: TextStyle(fontWeight: FontWeight.bold)),),
        backgroundColor: Colors.lightGreen.shade700,
      ),
      body: SingleChildScrollView(
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              SizedBox(height: 80),
              Container(
                width: 500,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: FutureBuilder<bool>(
                  future: loadImages(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // or another loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error loading image');
                    } else {
                      return Center(
                        child: Image.memory(
                          base64.decode(getImages),
                          width: 500,
                          height: 350,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 600.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Company Name', // Your label text
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
                          controller: companyNameController,
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
                width: 600.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Company Address', // Your label text
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
                          controller: companyAddressController,
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
                    width: 300.0, // Set the width to the desired value
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Business Phone Number', // Your label text
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
                              controller: businessContactNumberController,
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
                            'Business Email', // Your label text
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
                ],
              ),
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
                            'Business Start Hour', // Your label text
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
                              controller: businessStartHourController,
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
                            'Business End Hour', // Your label text
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
                              controller: businessEndHourController,
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
                    width: 300.0, // Set the width to the desired value
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fax Number', // Your label text
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
                              controller: faxNumberController,
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
                            'Instagram URL', // Your label text
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
                              controller: instagramController,
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
                    width: 300.0, // Set the width to the desired value
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'xTwitter URL', // Your label text
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
                              controller: xTwitterController,
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
                            'Thread URL', // Your label text
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
                              controller: threadController,
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
                    width: 300.0, // Set the width to the desired value
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Facebook URL', // Your label text
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
                              controller: facebookController,
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
                            'Star Rating', // Your label text
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
                              controller: starRatingController,
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
                        'Business Location', // Your label text
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
                          controller: businessLocationController,
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
                        'Business Description', // Your label text
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
                          controller: businessDescriptionController,
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
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Business Type',
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
                          controller: tsIdController,
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
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: _editServices,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen.shade700, // Set your desired background color here
                ),
                child: const Text('Update',
                    style: TextStyle(fontSize: 18.0,
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
