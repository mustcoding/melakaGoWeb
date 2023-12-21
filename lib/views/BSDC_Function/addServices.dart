import 'dart:html';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:melakago_web/Model/tourismService.dart';
import 'package:melakago_web/Model/tourismServiceImage.dart';
import 'package:file_picker/file_picker.dart';

import '../../Model/appUser.dart';
import '../home/homePageView_Web_BSDC.dart';


class addServices extends StatefulWidget {
  late appUser user;

  addServices({Key? key, required appUser user}) : super(key: key) {
    this.user = user;
  }


  @override
  State<addServices> createState() => _addServicesState();
}

class _addServicesState extends State<addServices> {


  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController businessContactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController businessStartHourController=TextEditingController();
  TextEditingController businessEndHourController=TextEditingController();
  TextEditingController faxNumberController=TextEditingController();
  TextEditingController instagramController=TextEditingController();
  TextEditingController xTwitterController=TextEditingController();
  TextEditingController threadController=TextEditingController();
  TextEditingController facebookController=TextEditingController();
  TextEditingController businessLocationController=TextEditingController();
  TextEditingController starRatingController=TextEditingController();
  TextEditingController businessDescriptionController=TextEditingController();
  TextEditingController tsIdController=TextEditingController();

  String base64String='';
  int isDelete=0;
  String? types;
  final PageController _pageController = PageController();

  List<Uint8List> selectedImages = [];

  // ubah jadi get role
  List<String> servicesType = [
    'Shopping',
    'Transport',
    'Lodging',
    'Restaurant',
    'Activity',
    'Tourist Spot',
  ];

  void _addServices() async{

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


    int? tourismServiceId=0;
    int tsId=0;

    if (companyName.isNotEmpty && companyAddress.isNotEmpty &&
         businessStartHour.isNotEmpty && businessEndHour.isNotEmpty &&
        businessLocation.isNotEmpty && businessDescription.isNotEmpty
        && servicesType != null ) {

      //_AlertMessage("success");

      if(types == 'Shopping')
      {
        tsId = 1;
        //_AlertMessage("success");
      }
      else if(types == 'Transport')
      {
        tsId = 2;
        // _AlertMessage("success");
      }
      else if(types == 'Lodging')
      {
        tsId = 3;
      }
      else if(types == 'Restaurant')
      {
        tsId = 4;
      }
      else if(types == 'Activity')
      {
        tsId = 5;
      }
      else if(types == 'Tourist Spot')
      {
        tsId = 6;
      }

      tourismService services = tourismService (tourismServiceId,companyName,
          companyAddress, businessContactNumber,
          email, businessStartHour,businessEndHour, faxNumber, instagram,
          xTwitter, thread, facebook, businessLocation,starRating,
          businessDescription, tsId, isDelete);

      if (await services.saveService()){

        tourismService getId = tourismService.getId(companyName, companyAddress, businessContactNumber);

        if(await getId.getServiceId()){
          int imageId=0;
          tourismServiceId = getId.tourismServiceId;
          print("Service ID: ${tourismServiceId}");

          tourismServiceImage image = tourismServiceImage
            (imageId,base64String as String,tourismServiceId!);

          if(await image.saveImage()){
            _AlertMessage("Tourism Service Has Been Added");
            Future.delayed(Duration(seconds: 1), () {

              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageViewWebBSDC(user: widget.user)),
                );
              });

              // Navigate to the login screen
            });
          } else{
            _AlertMessage("Unable to save the images");
          }
        } else{
          _AlertMessage("Can't Retrieve TourismServiceID");
        }

      }
      else{
        _AlertMessage("Registration Failed!!");
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
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String msg){
    if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
    }
  }

  void _pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      List<Uint8List> fileDataList = result.files.map((file) => file.bytes!).toList();

      if (fileDataList.length ==1) {
        setState(() {
          selectedImages.clear();
          selectedImages.addAll(fileDataList);
        });
      } else {
        _showMessage("Please select at least 3 images.");
      }
    }

    List<int> flattenedList = [];
    for (var bytes in selectedImages) {
      flattenedList.addAll(bytes);
    }

    base64String = base64Encode(flattenedList);
    print("Images: ${base64String}");
  }

//hello world
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:90,
          title: Center(child: const Text('Tourism Service Registration',
              style: TextStyle(fontWeight: FontWeight.bold)),),
          backgroundColor: Colors.lightGreen.shade700,
      ),
      body: SingleChildScrollView(
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              SizedBox(height: 80),
              InkWell(
                onTap: _pickImages,
                child:  Container(
                  width: 500,
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: selectedImages.isEmpty
                        ? Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.grey,
                    )
                        : PageView.builder(
                      controller: _pageController,
                      itemCount: selectedImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Image.memory(
                              selectedImages[index],
                              width: 500,
                              height: 350,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.clear, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      selectedImages.removeAt(index);
                                      // Notify the PageView that the number of pages has changed
                                      _pageController.jumpToPage(index);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      onPageChanged: (index) {
                        // Handle page change, if needed
                        // You can update your UI or perform other actions here
                      },
                    ),
                  ),
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
                          SizedBox(height: 5.0), // Add some space between the label and the text field
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
                        child: DropdownButtonFormField<String>(
                          value: types,
                          hint: Text('Select Service Type'),
                          onChanged: (value) {
                            setState(() {
                              types = value ;
                            });
                          },
                          isExpanded: true,
                          items: servicesType.map((String service) {
                            return DropdownMenuItem<String>(
                              value: service,
                              child: Text(service),
                            );
                          }).toList(),
                          decoration: InputDecoration(
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
                onPressed: _addServices,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen.shade700, // Set your desired background color here
                ),
                child: const Text('Register',
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
