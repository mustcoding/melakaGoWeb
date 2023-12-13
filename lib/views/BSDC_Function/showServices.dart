import 'dart:html';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:melakago_web/views/home/homePageView_Web_BSDC.dart';
import '../../Model/appUser.dart';
import '../../Model/tourismService.dart';
import 'editServices.dart';

class showServices extends StatefulWidget {

  late final appUser user;
  showServices({required this.user});

  @override
  State<showServices> createState() => _showServicesState();
}

class _showServicesState extends State<showServices> {

  late appUser user;

  late tourismService ts;
  final List<tourismService> services = [];
  int tourismServiceId =0;
  String companyName = "";
  String companyAddress = "";
  String businessContactNumber = "";
  String email = "";
  String businessStartHour = "";
  String businessEndHour = "";
  String faxNumber = "";
  String instagram = "";
  String xTwitter = "";
  String thread = "";
  String facebook = "";
  String businessLocation = "";
  int starRating = 0;
  String businessDescription = "";

  int tsId=0;
  int isDelete=0;


  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  Future<void> onListAllClicked() async {
    print("List ALL clicked");
    tourismService service = tourismService (tourismServiceId,companyName,
        companyAddress, businessContactNumber,
        email, businessStartHour,businessEndHour, faxNumber, instagram,
        xTwitter, thread, facebook, businessLocation,starRating,
        businessDescription,tsId, isDelete);
    List<tourismService> loadedServices = await service.loadAll(); // Call the instance method

    setState(() {
      services .clear();
      services.addAll(loadedServices);
    });

  }


  void onTouristSpotClicked() async {

    tsId=6;
    print("Tourist Spot clicked");

    tourismService service = tourismService (tourismServiceId,companyName,
        companyAddress, businessContactNumber,
        email, businessStartHour,businessEndHour, faxNumber, instagram,
        xTwitter, thread, facebook, businessLocation,starRating,
        businessDescription, tsId, isDelete);

    List<tourismService> loadedServices = await service.loadTourismService(); // Call the instance method

    setState(() {
      services .clear();
      services.addAll(loadedServices);
    });

  }


  void onActivityClicked() async {
    tsId=5;
    print("Activity clicked");

    tourismService service = tourismService (tourismServiceId,companyName,
        companyAddress, businessContactNumber,
        email, businessStartHour,businessEndHour, faxNumber, instagram,
        xTwitter, thread, facebook, businessLocation,starRating,
        businessDescription, tsId, isDelete);

    List<tourismService> loadedServices = await service.loadTourismService(); // Call the instance method

    setState(() {
      services .clear();
      services.addAll(loadedServices);
    });

  }

  void onRestaurantClicked() async {
    tsId=4;
    print("Restaurant clicked");

    tourismService service = tourismService (tourismServiceId,companyName,
        companyAddress, businessContactNumber,
        email, businessStartHour,businessEndHour, faxNumber, instagram,
        xTwitter, thread, facebook, businessLocation,starRating,
        businessDescription, tsId, isDelete);

    List<tourismService> loadedServices = await service.loadTourismService(); // Call the instance method

    setState(() {
      services .clear();
      services.addAll(loadedServices);
    });

  }


  void onLodgingClicked() async {
    tsId=3;
    print("Lodging clicked");
    tourismService service = tourismService (tourismServiceId,companyName,
        companyAddress, businessContactNumber,
        email, businessStartHour,businessEndHour, faxNumber, instagram,
        xTwitter, thread, facebook, businessLocation,starRating,
        businessDescription, tsId, isDelete);

    List<tourismService> loadedServices = await service.loadTourismService(); // Call the instance method

    setState(() {
      services .clear();
      services.addAll(loadedServices);
    });

  }


  void onTransportationClicked() async {
    tsId=2;
    print("Transportation clicked");

    tourismService service = tourismService (tourismServiceId,companyName,
        companyAddress, businessContactNumber,
        email, businessStartHour,businessEndHour, faxNumber, instagram,
        xTwitter, thread, facebook, businessLocation,starRating,
        businessDescription, tsId, isDelete);

    List<tourismService> loadedServices = await service.loadTourismService(); // Call the instance method

    setState(() {
      services .clear();
      services.addAll(loadedServices);
    });

  }


  void onSouvenirStallClicked() async {
    tsId=1;
    print("Souvenir Stall clicked");

    tourismService service = tourismService (tourismServiceId,companyName,
        companyAddress, businessContactNumber,
        email, businessStartHour,businessEndHour, faxNumber, instagram,
        xTwitter, thread, facebook, businessLocation,starRating,
        businessDescription, tsId, isDelete);

    List<tourismService> loadedServices = await service.loadTourismService(); // Call the instance method

    setState(() {
      services .clear();
      services.addAll(loadedServices);
    });

  }


  void _removeServices(int index) async{

    int isDelete=1;
    int? id=services[index].tourismServiceId;

    tourismService service = tourismService (id,companyName,
        companyAddress, businessContactNumber,
        email, businessStartHour,businessEndHour, faxNumber, instagram,
        xTwitter, thread, facebook, businessLocation,starRating,
        businessDescription, tsId, isDelete);

    if(await service.deleteService()){

      _AlertMessage(context, "NOTE: Tourism Service Successfully Deleted");
      Future.delayed(Duration(seconds: 2), () {
        // Navigate to the login screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => showServices(user:user)),
        );
      });
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
        title: Center(
          child: const Text(
            'Delete Tourism Service',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightGreen.shade700,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            // Navigate to the home page here
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePageViewWebBSDC(user: user)),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onListAllClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.all_inclusive_outlined,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "List ALL",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onTouristSpotClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Tourist Spot",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onActivityClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_activity,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Activity",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onRestaurantClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.restaurant,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Restaurant",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onLodgingClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.hotel,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Lodging",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onTransportationClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.emoji_transportation,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Transportation",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  GestureDetector(
                    onTap: onSouvenirStallClicked,
                    child: Column(
                      children: [
                        Icon(
                          Icons.storefront_rounded,
                          size: 40.0,
                          color: Colors.deepPurple.shade900,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Souvenir Stall",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height:60),
              _buildListView(),
              SizedBox(height:60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Container(
      width: 1200,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: services.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(services[index].companyName.toString()),
            background: Container(
              color: Colors.red,
              child: Center(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onDismissed: (direction) {
              _removeServices(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Item dismissed')),
              );
            },
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(services[index].companyName.toString()),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Start Hour: ${services[index].businessStartHour}'),
                    Text('End Hour: ${services[index].businessEndHour}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        if (services != null && services.isNotEmpty && index >= 0 && index < services.length) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => editServices(index: index, services: services),
                            ),
                          );
                        } else {
                          // Handle the case where services is null, empty, or the index is out of bounds.
                          print("Invalid index or services list is null or empty.");
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeServices(index),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
